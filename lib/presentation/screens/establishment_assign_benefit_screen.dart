import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import '../../models/beneficio.dart';
import '../../models/alumno.dart';
import '../bloc/establishment/establishment_auth_bloc.dart';
import '../bloc/establishment/establishment_delivery_bloc.dart';
import '../widgets/barcode_scanner_dialog.dart';

class EstablishmentAssignBenefitScreen extends StatefulWidget {
  final Beneficio beneficio;

  const EstablishmentAssignBenefitScreen({
    super.key,
    required this.beneficio,
  });

  @override
  State<EstablishmentAssignBenefitScreen> createState() =>
      _EstablishmentAssignBenefitScreenState();
}

class _EstablishmentAssignBenefitScreenState
    extends State<EstablishmentAssignBenefitScreen> {
  final _searchController = TextEditingController();
  final _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<EstablishmentDeliveryBloc>()
          .add(SelectBeneficio(widget.beneficio));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _codigoController.dispose();
    super.dispose();
  }

  void _openScanDialog() async {
    final scannedCode = await BarcodeScannerDialog.scan(context);
    if (scannedCode != null && scannedCode.isNotEmpty) {
      setState(() {
        _codigoController.text = scannedCode;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Código escaneado: $scannedCode'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _openScanDialogForStudentSearch() async {
    final scannedCode = await BarcodeScannerDialog.scan(context);
    if (scannedCode != null && scannedCode.isNotEmpty) {
      setState(() {
        _searchController.text = scannedCode;
      });
      if (mounted) {
        context.read<EstablishmentDeliveryBloc>().add(SearchAlumnos(scannedCode));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('RUT / Alumno escaneado: $scannedCode'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showManualRegisterModal(BuildContext context) {
    final rutCtrl = TextEditingController();
    final nombreCtrl = TextEditingController();
    final cursoCtrl = TextEditingController();
    final nacimientoCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(modalContext).viewInsets.bottom + 24,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Alta Manual de Alumno',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(modalContext),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Registra al alumno si no aparece en la nómina oficial. Quedará marcado como "Sin verificar".',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: rutCtrl,
                    decoration: const InputDecoration(
                      labelText: 'RUT del Alumno *',
                      hintText: 'ej: 20.123.456-7',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'El RUT es obligatorio' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nombre Completo *',
                      hintText: 'ej: Juan Pérez',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'El nombre es obligatorio' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cursoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Curso (Opcional)',
                            hintText: 'ej: 5° Básico A',
                            prefixIcon: Icon(Icons.school_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: nacimientoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'F. Nac. (YYYY-MM-DD)',
                            hintText: '2013-05-10',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        Navigator.pop(modalContext);
                        context.read<EstablishmentDeliveryBloc>().add(
                              RegisterAlumnoManual(
                                rut: rutCtrl.text,
                                nombre: nombreCtrl.text,
                                curso: cursoCtrl.text,
                                nacimiento: nacimientoCtrl.text,
                              ),
                            );
                      }
                    },
                    child: const Text('Registrar Alumno', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<EstablishmentAuthBloc>().state;
    final user = authState is EstablishmentAuthenticated ? authState.user : null;
    final isAdmin = user?.isAdministrador ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Asignación de Beneficio',
          style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/establishment-home');
            }
          },
        ),
      ),
      body: BlocConsumer<EstablishmentDeliveryBloc, EstablishmentDeliveryState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state.successMessage != null && state.lastEntrega != null) {
            _codigoController.clear();
            _searchController.clear();
          }
        },
        builder: (context, state) {
          if (isAdmin) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.gpp_maybe_outlined, size: 64, color: Colors.orange.shade700),
                    const SizedBox(height: 16),
                    const Text(
                      'Acceso Restringido',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Tu usuario tiene rol Administrador. Las entregas de beneficios solo pueden ser registradas por un Encargado u Operario.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }

          // SUCCESS VIEW AFTER REGISTRATION
          if (state.lastEntrega != null && state.successMessage != null) {
            final entrega = state.lastEntrega!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check_circle_outline, size: 72, color: Colors.green.shade600),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '¡Entrega Registrada!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.successMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _DetailRow(
                            label: 'Beneficio',
                            value: entrega.beneficio?.nombre ?? widget.beneficio.nombre,
                          ),
                          const Divider(height: 20),
                          _DetailRow(
                            label: 'Alumno',
                            value: entrega.alumno?.nombre ?? 'RUT: ${entrega.alumnoId}',
                          ),
                          if (entrega.codigo != null && entrega.codigo!.isNotEmpty) ...[
                            const Divider(height: 20),
                            _DetailRow(
                              label: 'Código Serie / Barras',
                              value: entrega.codigo!,
                            ),
                          ],
                          const Divider(height: 20),
                          _DetailRow(
                            label: 'Fecha / Hora',
                            value: entrega.createdAt,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            context.read<EstablishmentDeliveryBloc>().add(ResetDeliveryFlow());
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/establishment-home');
                            }
                          },
                          child: const Text('Volver al Stock'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            context.read<EstablishmentDeliveryBloc>().add(ResetDeliveryFlow());
                            context.read<EstablishmentDeliveryBloc>().add(SelectBeneficio(widget.beneficio));
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Otra Entrega'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          final beneficioActual = state.selectedBeneficio ?? widget.beneficio;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BENEFIT HEADER CARD
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.card_giftcard,
                          color: AppColors.primaryBlue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              beneficioActual.nombre,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMain,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: beneficioActual.canBeDelivered
                                        ? Colors.blue.shade50
                                        : Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    beneficioActual.stockActual == null
                                        ? 'Stock ilimitado'
                                        : (beneficioActual.isOutOfStock
                                            ? 'SIN STOCK'
                                            : 'Stock disponible: ${beneficioActual.stockActual}'),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: beneficioActual.canBeDelivered
                                          ? AppColors.primaryBlue
                                          : Colors.red.shade800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // STUDENT SEARCH & SELECTION SECTION
                const Text(
                  'Buscador de Alumnos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Busca al alumno por Nombre o RUT para asignar la entrega.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Buscar por Nombre o RUT...',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    context.read<EstablishmentDeliveryBloc>().add(const SearchAlumnos(''));
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                        ),
                        onChanged: (val) {
                          context.read<EstablishmentDeliveryBloc>().add(SearchAlumnos(val));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton.filled(
                      onPressed: _openScanDialogForStudentSearch,
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                      tooltip: 'Escanear QR de Alumno',
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                if (state.isSearchingAlumnos)
                  const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
                else if (state.selectedAlumno != null)
                  _buildSelectedAlumnoCard(context, state.selectedAlumno!)
                else if (state.alumnos.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.alumnos.length,
                    itemBuilder: (context, idx) {
                      final a = state.alumnos[idx];
                      return _buildAlumnoTile(context, a);
                    },
                  )
                else if (_searchController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.person_search_outlined, size: 48, color: AppColors.textTertiary),
                          const SizedBox(height: 8),
                          const Text(
                            'No se encontraron alumnos con ese criterio.',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => _showManualRegisterModal(context),
                            icon: const Icon(Icons.person_add_alt_1),
                            label: const Text('Registrar Alumno Manualmente'),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () => _showManualRegisterModal(context),
                      icon: const Icon(Icons.person_add_alt_1, color: AppColors.primaryBlue),
                      label: const Text(
                        '¿El alumno no aparece? Alta Manual',
                        style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                const SizedBox(height: 32),

                // CONFIRM DELIVERY SECTION (Visible when student selected)
                if (state.selectedAlumno != null) ...[
                  const Text(
                    'Confirmar Entrega',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  ),
                  const SizedBox(height: 12),
                  if (beneficioActual.stockeable) ...[
                    const Text(
                      'Código de Serie / Barras (Obligatorio):',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textMain),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _codigoController,
                            decoration: InputDecoration(
                              hintText: 'Ingresar o escanear código...',
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.qr_code, color: AppColors.primaryBlue),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: AppColors.border),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: AppColors.border),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton.filled(
                          onPressed: _openScanDialog,
                          icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                          tooltip: 'Escanear con Cámara',
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 2,
                      ),
                      onPressed: state.isSubmittingEntrega
                          ? null
                          : () {
                              final codigo = beneficioActual.stockeable
                                  ? _codigoController.text.trim()
                                  : null;
                              if (beneficioActual.stockeable && (codigo == null || codigo.isEmpty)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Por favor ingresa o escanea el código de barras/serie.'),
                                    backgroundColor: AppColors.warning,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }
                              context.read<EstablishmentDeliveryBloc>().add(
                                    SubmitEntrega(codigo: codigo),
                                  );
                            },
                      child: state.isSubmittingEntrega
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                            )
                          : Text(
                              'Confirmar Entrega de ${beneficioActual.nombre}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedAlumnoCard(BuildContext context, Alumno alumno) {
    return Card(
      elevation: 0,
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.primaryBlue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alumno.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textMain),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'RUT: ${alumno.rut}${alumno.curso != null ? " • ${alumno.curso}" : ""}',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  _buildStatusBadge(alumno),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                context.read<EstablishmentDeliveryBloc>().add(ClearSelectedAlumno());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlumnoTile(BuildContext context, Alumno alumno) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        onTap: () {
          context.read<EstablishmentDeliveryBloc>().add(SelectAlumno(alumno));
        },
        leading: CircleAvatar(
          backgroundColor: AppColors.background,
          child: Text(
            alumno.nombre.isNotEmpty ? alumno.nombre[0].toUpperCase() : 'A',
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
          ),
        ),
        title: Text(alumno.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(
          'RUT: ${alumno.rut}${alumno.curso != null ? " • ${alumno.curso}" : ""}',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        trailing: _buildStatusBadge(alumno),
      ),
    );
  }

  Widget _buildStatusBadge(Alumno alumno) {
    if (alumno.validado) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Nómina Oficial',
          style: TextStyle(color: Colors.green.shade900, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      );
    } else if (!alumno.verificado) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Sin verificar',
          style: TextStyle(color: Colors.amber.shade900, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textMain),
          ),
        ),
      ],
    );
  }
}
