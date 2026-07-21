import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/beneficio.dart';
import '../../../models/alumno.dart';
import '../../../models/entrega.dart';
import '../../../models/api_exception.dart';
import '../../../services/beneficios_service.dart';

// Events
abstract class EstablishmentDeliveryEvent extends Equatable {
  const EstablishmentDeliveryEvent();
  @override
  List<Object?> get props => [];
}

class LoadBeneficios extends EstablishmentDeliveryEvent {}

class SelectBeneficio extends EstablishmentDeliveryEvent {
  final Beneficio beneficio;
  const SelectBeneficio(this.beneficio);
  @override
  List<Object?> get props => [beneficio];
}

class SearchAlumnos extends EstablishmentDeliveryEvent {
  final String query;
  const SearchAlumnos(this.query);
  @override
  List<Object?> get props => [query];
}

class SelectAlumno extends EstablishmentDeliveryEvent {
  final Alumno alumno;
  const SelectAlumno(this.alumno);
  @override
  List<Object?> get props => [alumno];
}

class ClearSelectedAlumno extends EstablishmentDeliveryEvent {}

class RegisterAlumnoManual extends EstablishmentDeliveryEvent {
  final String rut;
  final String nombre;
  final String? nacimiento;
  final String? curso;

  const RegisterAlumnoManual({
    required this.rut,
    required this.nombre,
    this.nacimiento,
    this.curso,
  });

  @override
  List<Object?> get props => [rut, nombre, nacimiento, curso];
}

class SubmitEntrega extends EstablishmentDeliveryEvent {
  final String? codigo;
  const SubmitEntrega({this.codigo});
  @override
  List<Object?> get props => [codigo];
}

class ResetDeliveryFlow extends EstablishmentDeliveryEvent {}

// State
class EstablishmentDeliveryState extends Equatable {
  final List<BeneficioArea> areas;
  final Beneficio? selectedBeneficio;
  final List<Alumno> alumnos;
  final Alumno? selectedAlumno;
  final bool isLoadingBeneficios;
  final bool isSearchingAlumnos;
  final bool isRegisteringAlumno;
  final bool isSubmittingEntrega;
  final String? errorMessage;
  final String? successMessage;
  final EntregaResponse? lastEntrega;

  const EstablishmentDeliveryState({
    this.areas = const [],
    this.selectedBeneficio,
    this.alumnos = const [],
    this.selectedAlumno,
    this.isLoadingBeneficios = false,
    this.isSearchingAlumnos = false,
    this.isRegisteringAlumno = false,
    this.isSubmittingEntrega = false,
    this.errorMessage,
    this.successMessage,
    this.lastEntrega,
  });

  EstablishmentDeliveryState copyWith({
    List<BeneficioArea>? areas,
    Beneficio? selectedBeneficio,
    bool clearSelectedBeneficio = false,
    List<Alumno>? alumnos,
    Alumno? selectedAlumno,
    bool clearSelectedAlumno = false,
    bool? isLoadingBeneficios,
    bool? isSearchingAlumnos,
    bool? isRegisteringAlumno,
    bool? isSubmittingEntrega,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    EntregaResponse? lastEntrega,
    bool clearLastEntrega = false,
  }) {
    return EstablishmentDeliveryState(
      areas: areas ?? this.areas,
      selectedBeneficio: clearSelectedBeneficio
          ? null
          : (selectedBeneficio ?? this.selectedBeneficio),
      alumnos: alumnos ?? this.alumnos,
      selectedAlumno: clearSelectedAlumno
          ? null
          : (selectedAlumno ?? this.selectedAlumno),
      isLoadingBeneficios: isLoadingBeneficios ?? this.isLoadingBeneficios,
      isSearchingAlumnos: isSearchingAlumnos ?? this.isSearchingAlumnos,
      isRegisteringAlumno: isRegisteringAlumno ?? this.isRegisteringAlumno,
      isSubmittingEntrega: isSubmittingEntrega ?? this.isSubmittingEntrega,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccessMessage ? null : (successMessage ?? this.successMessage),
      lastEntrega: clearLastEntrega ? null : (lastEntrega ?? this.lastEntrega),
    );
  }

  @override
  List<Object?> get props => [
        areas,
        selectedBeneficio,
        alumnos,
        selectedAlumno,
        isLoadingBeneficios,
        isSearchingAlumnos,
        isRegisteringAlumno,
        isSubmittingEntrega,
        errorMessage,
        successMessage,
        lastEntrega,
      ];
}

// Bloc
class EstablishmentDeliveryBloc
    extends Bloc<EstablishmentDeliveryEvent, EstablishmentDeliveryState> {
  final BeneficiosService _beneficiosService;

  EstablishmentDeliveryBloc({BeneficiosService? beneficiosService})
      : _beneficiosService = beneficiosService ?? BeneficiosService(),
        super(const EstablishmentDeliveryState()) {
    on<LoadBeneficios>(_onLoadBeneficios);
    on<SelectBeneficio>(_onSelectBeneficio);
    on<SearchAlumnos>(_onSearchAlumnos);
    on<SelectAlumno>(_onSelectAlumno);
    on<ClearSelectedAlumno>(_onClearSelectedAlumno);
    on<RegisterAlumnoManual>(_onRegisterAlumnoManual);
    on<SubmitEntrega>(_onSubmitEntrega);
    on<ResetDeliveryFlow>(_onResetDeliveryFlow);
  }

  Future<void> _onLoadBeneficios(
      LoadBeneficios event, Emitter<EstablishmentDeliveryState> emit) async {
    emit(state.copyWith(isLoadingBeneficios: true, clearErrorMessage: true));
    try {
      final areas = await _beneficiosService.getBeneficios();
      emit(state.copyWith(areas: areas, isLoadingBeneficios: false));
    } on ApiException catch (e) {
      emit(state.copyWith(
          isLoadingBeneficios: false, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          isLoadingBeneficios: false, errorMessage: 'Error al cargar beneficios: $e'));
    }
  }

  void _onSelectBeneficio(
      SelectBeneficio event, Emitter<EstablishmentDeliveryState> emit) {
    emit(state.copyWith(
      selectedBeneficio: event.beneficio,
      clearSelectedAlumno: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));
  }

  Future<void> _onSearchAlumnos(
      SearchAlumnos event, Emitter<EstablishmentDeliveryState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(alumnos: []));
      return;
    }
    emit(state.copyWith(isSearchingAlumnos: true, clearErrorMessage: true));
    try {
      final list = await _beneficiosService.searchAlumnos(event.query);
      emit(state.copyWith(alumnos: list, isSearchingAlumnos: false));
    } on ApiException catch (e) {
      emit(state.copyWith(
          isSearchingAlumnos: false, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          isSearchingAlumnos: false, errorMessage: 'Error al buscar alumnos: $e'));
    }
  }

  void _onSelectAlumno(
      SelectAlumno event, Emitter<EstablishmentDeliveryState> emit) {
    emit(state.copyWith(
      selectedAlumno: event.alumno,
      clearErrorMessage: true,
    ));
  }

  void _onClearSelectedAlumno(
      ClearSelectedAlumno event, Emitter<EstablishmentDeliveryState> emit) {
    emit(state.copyWith(clearSelectedAlumno: true));
  }

  Future<void> _onRegisterAlumnoManual(
      RegisterAlumnoManual event, Emitter<EstablishmentDeliveryState> emit) async {
    emit(state.copyWith(isRegisteringAlumno: true, clearErrorMessage: true));
    try {
      final alumno = await _beneficiosService.registrarAlumnoManual(
        rut: event.rut,
        nombre: event.nombre,
        nacimiento: event.nacimiento,
        curso: event.curso,
      );
      emit(state.copyWith(
        isRegisteringAlumno: false,
        selectedAlumno: alumno,
        successMessage: 'Alumno ${alumno.nombre} registrado/seleccionado exitosamente.',
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
          isRegisteringAlumno: false, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          isRegisteringAlumno: false, errorMessage: 'Error al registrar alumno: $e'));
    }
  }

  Future<void> _onSubmitEntrega(
      SubmitEntrega event, Emitter<EstablishmentDeliveryState> emit) async {
    if (state.selectedBeneficio == null) {
      emit(state.copyWith(errorMessage: 'Debes seleccionar un beneficio primero.'));
      return;
    }
    if (state.selectedAlumno == null) {
      emit(state.copyWith(errorMessage: 'Debes seleccionar un alumno primero.'));
      return;
    }

    emit(state.copyWith(isSubmittingEntrega: true, clearErrorMessage: true, clearSuccessMessage: true));
    try {
      final response = await _beneficiosService.registrarEntrega(
        beneficioId: state.selectedBeneficio!.id,
        alumnoRut: state.selectedAlumno!.rut,
        codigo: event.codigo,
      );

      // Refresh benefits list after delivery to update stock count
      final updatedAreas = await _beneficiosService.getBeneficios();

      emit(state.copyWith(
        isSubmittingEntrega: false,
        areas: updatedAreas,
        lastEntrega: response,
        successMessage: '¡Entrega registrada exitosamente!',
        clearSelectedAlumno: true,
        clearSelectedBeneficio: true,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
          isSubmittingEntrega: false, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          isSubmittingEntrega: false, errorMessage: 'Error al registrar entrega: $e'));
    }
  }

  void _onResetDeliveryFlow(
      ResetDeliveryFlow event, Emitter<EstablishmentDeliveryState> emit) {
    emit(state.copyWith(
      clearSelectedBeneficio: true,
      clearSelectedAlumno: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
      clearLastEntrega: true,
      alumnos: [],
    ));
  }
}
