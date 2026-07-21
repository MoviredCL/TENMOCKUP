import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import '../../models/beneficio.dart';
import '../../models/alumno.dart';
import '../bloc/establishment/establishment_auth_bloc.dart';
import '../bloc/establishment/establishment_delivery_bloc.dart';
import '../widgets/barcode_scanner_dialog.dart';

class EstablishmentDeliveryScreen extends StatefulWidget {
  const EstablishmentDeliveryScreen({super.key});

  @override
  State<EstablishmentDeliveryScreen> createState() => _EstablishmentDeliveryScreenState();
}

class _EstablishmentDeliveryScreenState extends State<EstablishmentDeliveryScreen> {
  final _searchController = TextEditingController();
  final _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EstablishmentDeliveryBloc>().add(LoadBeneficios());
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
            backgroundColor: Colors.green.shade700,
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
                    child: const Text('Registrar Alumno'),
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
      appBar: AppBar(
        title: const Text('Entrega de Beneficios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                backgroundColor: Colors.red.shade700,
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
                      'Tu usuario tiene rol Administrador. Según la política del sistema, las entregas de beneficios solo pueden ser registradas por un Encargado u Operario.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.isLoadingBeneficios) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.lastEntrega != null && state.successMessage != null) {
            final entrega = state.lastEntrega!;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _DetailRow(
                            label: 'Beneficio',
                            value: entrega.beneficio?.nombre ?? 'Beneficio #${entrega.beneficioId}',
                          ),
                          const Divider(height: 20),
                          _DetailRow(
                            label: 'Alumno',
                            value: entrega.alumno?.nombre ?? 'RUT: ${entrega.alumnoId}',
                          ),
                          if (entrega.codigo != null && entrega.codigo!.isNotEmpty) ...[
                            const Divider(height: 20),
                            _DetailRow(
                              label: 'Código Serie/Barras',
                              value: entrega.codigo!,
                            ),
                          ],
                          const Divider(height: 20),
                          _DetailRow(
                            label: 'Fecha/Hora',
                            value: entrega.createdAt,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<EstablishmentDeliveryBloc>().add(ResetDeliveryFlow());
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Registrar Otra Entrega'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primaryBlue,
            onRefresh: () async {
              context.read<EstablishmentDeliveryBloc>().add(LoadBeneficios());
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STEP 1: SELECT BENEFIT
                const Text(
                  '1. Selecciona el Beneficio',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
                ),
                const SizedBox(height: 8),
                if (state.areas.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('No hay beneficios habilitados para este establecimiento.'),
                  )
                else
                  ...state.areas.map((area) => _buildAreaSection(context, area, state.selectedBeneficio)),

                const SizedBox(height: 28),

                // STEP 2: SEARCH / SELECT ALUMNO
                if (state.selectedBeneficio != null) ...[
                  const Text(
                    '2. Busca o Selecciona al Alumno',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Buscar por Nombre o RUT...',
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
                  const SizedBox(height: 12),

                  if (state.isSearchingAlumnos)
                    const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()))
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
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          const Text('No se encontraron alumnos con ese criterio.'),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: () => _showManualRegisterModal(context),
                            icon: const Icon(Icons.person_add_alt_1),
                            label: const Text('Registrar Alumno Manualmente'),
                          ),
                        ],
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => _showManualRegisterModal(context),
                        icon: const Icon(Icons.person_add_alt_1),
                        label: const Text('¿El alumno no aparece? Alta Manual'),
                      ),
                    ),
                ],

                const SizedBox(height: 28),

                // STEP 3: CODE INPUT & SUBMIT (If Stockeable)
                if (state.selectedBeneficio != null && state.selectedAlumno != null) ...[
                  const Text(
                    '3. Confirmar Entrega',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  ),
                  const SizedBox(height: 12),
                  if (state.selectedBeneficio!.stockeable) ...[
                    const Text(
                      'Código de Serie / Barras (Obligatorio para beneficio stockeable):',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _codigoController,
                            decoration: const InputDecoration(
                              hintText: 'Ej: ABC-123',
                              prefixIcon: Icon(Icons.qr_code),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          onPressed: _openScanDialog,
                          icon: const Icon(Icons.qr_code_scanner),
                          tooltip: 'Escanear con Cámara',
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isSubmittingEntrega
                          ? null
                          : () {
                              final codigo = state.selectedBeneficio!.stockeable
                                  ? _codigoController.text.trim()
                                  : null;
                              context.read<EstablishmentDeliveryBloc>().add(
                                    SubmitEntrega(codigo: codigo),
                                  );
                            },
                      child: state.isSubmittingEntrega
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                            )
                          : Text('Registrar Entrega de ${state.selectedBeneficio!.nombre}'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      ),
    );
  }

  Widget _buildAreaSection(
    BuildContext context,
    BeneficioArea area,
    Beneficio? selectedBeneficio,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            area.nombre,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        ...area.beneficios.map((b) {
          final isSelected = selectedBeneficio?.id == b.id;
          final canBeSelected = b.canBeDelivered;

          return Card(
            color: isSelected
                ? AppColors.primaryBlue.withOpacity(0.08)
                : (canBeSelected ? Colors.white : Colors.grey.shade50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? AppColors.primaryBlue : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              onTap: !canBeSelected
                  ? null
                  : () {
                      context.read<EstablishmentDeliveryBloc>().add(SelectBeneficio(b));
                    },
              title: Text(
                b.nombre,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: canBeSelected ? AppColors.textMain : Colors.grey,
                ),
              ),
              subtitle: Text(
                b.stockeable
                    ? (b.isOutOfStock ? 'Sin stock disponible' : 'Stock disponible: ${b.stockActual ?? 0}')
                    : 'Sin límite (No entregable en establecimiento)',
                style: TextStyle(
                  color: canBeSelected ? AppColors.textSecondary : Colors.grey,
                ),
              ),
              trailing: !canBeSelected
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: b.isOutOfStock ? Colors.red.shade100 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        b.isOutOfStock ? 'SIN STOCK' : 'NO ENTREGABLE',
                        style: TextStyle(
                          color: b.isOutOfStock ? Colors.red.shade800 : Colors.grey.shade700,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Radio<int>(
                      value: b.id,
                      groupValue: selectedBeneficio?.id,
                      activeColor: AppColors.primaryBlue,
                      onChanged: (val) {
                        if (canBeSelected) {
                          context.read<EstablishmentDeliveryBloc>().add(SelectBeneficio(b));
                        }
                      },
                    ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSelectedAlumnoCard(BuildContext context, Alumno alumno) {
    return Card(
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alumno.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text('RUT: ${alumno.rut} • ${alumno.curso ?? 'Sin curso'}'),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        title: Text(alumno.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('RUT: ${alumno.rut}${alumno.curso != null ? " • ${alumno.curso}" : ""}'),
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
