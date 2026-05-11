import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:tneapp/presentation/views/views.dart';
import 'package:tneapp/presentation/widgets/boton_clave_unica.dart';
import 'package:tneapp/presentation/widgets/boton_montos_saldo.dart';
import 'package:tneapp/presentation/widgets/primary_custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.mostrarNotificaciones) {
          showModalBottomSheet(
            useRootNavigator: true,
            context: context,
            isScrollControlled: true,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            builder: (context) => DraggableScrollableSheet(
              initialChildSize: 1.0,
              minChildSize: 1.0,
              maxChildSize: 1.0,
              builder: (_, controller) => const NotificacionView(),
            ),
          );
        }
        if (state.crearQR) {
          final appBloc = context.read<AppBloc>();
          showModalBottomSheet(
            useRootNavigator: true,
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => DraggableScrollableSheet(
              initialChildSize: 1.0,
              minChildSize: 1.0,
              maxChildSize: 1.0,
              builder: (_, controller) => _buildQrOverlay(context, controller),
            ),
          ).then((_) {
            appBloc.add(CrearQr(estado: false));
          });
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(primaryColor),
            appBar: AppBarCustom(),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: state.viewHome == 1
                  ? homeView(context, state)
                  : state.viewHome == 2
                      ? claveUnicaView(context, state)
                      : cargarSaldoView(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQrOverlay(BuildContext context, ScrollController controller) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Tu Pasaje Digital",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Image.asset("assets/images/qr.png"),
              ),
              const SizedBox(height: 48),
              _buildQrInfoTile(Icons.timer_outlined, "Vigencia", "120 minutos, tu pasaje no será \n descontado hasta que pases por \n un validador"),
              const SizedBox(height: 16),
              _buildQrInfoTile(Icons.info_outline, "Importante", "Pasaje único e intransferible"),
              const SizedBox(height: 60),
              _buildQrInfoTile(Icons.info_outline, "Beneficio QR", "Tu pasaje es aún más barato \n con QR"),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrInfoTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(secondaryColor), size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget homeView(BuildContext context, AppState state) {
    return BodyCustom(
      key: const ValueKey(1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "¡Hola, Emma!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 28,
                                  color: Color(neutralTextColor),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "¿A dónde vamos hoy?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(neutralTextColor).withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              _buildHeaderButton(
                                imagePath: "assets/images/boton_icono.png",
                                onPressed: () => context.read<AppBloc>().add(const MostrarNotificaciones(estado: true)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      if (!state.loginClaveUnica)
                        Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue.shade100, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10)
                                  ]
                                ),
                                child: Icon(Icons.location_on_rounded, color: Colors.blue.shade700, size: 18),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  "Tu ubicación está siendo compartida con tus padres",
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      _buildSectionTitle("Tus Tarjetas"),
                      const SizedBox(height: 16),
                      if (state.loginClaveUnica) ...[
                        _buildTneCard(
                          context: context,
                          title: "TNE Digital",
                          subtitle: !state.estadoTneQr ? "Pendiente de activar" : "Lista para usar",
                          balance: state.saldoActual,
                          imagePath: "assets/images/tne_qr.png",
                          isSecondary: false,
                          actionLabel: !state.estadoTneQr ? "Habilitar TNEQR" : "Cargar saldo",
                          onAction: () {
                            if (state.estadoTneQr) {
                              context.read<AppBloc>().add(const CambiarViewHome(view: 3));
                            } else {
                              context.read<AppBloc>().add(const CambiarViewHome(view: 2));
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                      _buildTneCard(
                        context: context,
                        title: state.isTarjetaEnrolada ? state.nombreTarjetaFisica : "Tarjeta Física",
                        subtitle: state.isTarjetaEnrolada ? "Nº ${state.numeroTarjetaFisica}" : "Enrola tu plástico",
                        balance: state.isTarjetaEnrolada ? state.saldoTarjetaFisica : -1,
                        imagePath: "assets/images/tarjeta_tne.png",
                        isSecondary: true,
                        actionLabel: state.isTarjetaEnrolada ? "Cargar saldo" : "Enrolar tarjeta",
                        onAction: () {
                          if (state.isTarjetaEnrolada) {
                            // Ir a carga para tarjeta física
                            context.read<AppBloc>().add(const CambiarViewHome(view: 3));
                          } else {
                            context.push("/enrolar");
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      _buildSectionTitle("Noticias y Beneficios de tu TNE"),
                      const SizedBox(height: 16),
                      _buildEventsSlider(context),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }



  Widget claveUnicaView(BuildContext context, AppState state) {
    return BodyCustom(
      key: const ValueKey(2),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onPressed: () => context.read<AppBloc>().add(const CambiarViewHome(view: 1)),
                ),
                const Text(
                  "Activación TNEQR",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 48), // Spacer
              ],
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                children: [
                  Image.asset("assets/images/imagen_clave_unica.png", width: 140),
                  const SizedBox(height: 32),
                  const Text(
                    "Valida tu identidad",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Para activar tu pase digital, necesitamos confirmar que eres tú a través de ClaveÚnica.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600, height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  BotonClaveUnica(
                    label: "Validar con ClaveÚnica",
                    onPressed: () {
                      context.read<AppBloc>().add(CambiarEstadoTneDigital(estado: true));
                      context.read<AppBloc>().add(const CambiarViewHome(view: 1));
                    },
                    size: double.infinity,
                    rounded: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget cargarSaldoView(BuildContext context, AppState state) {
    return BodyCustom(
      key: const ValueKey(3),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onPressed: () => context.read<AppBloc>().add(const CambiarViewHome(view: 1)),
                ),
                const Text(
                  "Cargar Saldo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                _buildHeaderButton(
                  imagePath: "assets/images/boton_icono.png",
                  onPressed: () => context.read<AppBloc>().add(MostrarNotificaciones(estado: true)),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildBalanceSummary(state),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Selecciona un monto",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            _buildMontoGrid(context, state),
            const SizedBox(height: 40),
            PrimaryCustomButton(
              label: "Confirmar Carga",
              onPressed: () {
                context.read<AppBloc>().add(const CambiarViewHome(view: 1));
                context.read<AppBloc>().add(SetearSaldoActual(saldo: state.seleccionarSaldo + state.saldoActual));
              },
              size: double.infinity,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSummary(AppState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(primaryColor), Color(primaryDarkColor)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Color(primaryColor).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tu saldo actual", style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            "\$${formatearMiles(state.saldoActual)}",
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),
          ),
          const Divider(color: Colors.white24, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Nueva carga", style: TextStyle(color: Colors.white70)),
              Text(
                "+\$${formatearMiles(state.seleccionarSaldo)}",
                style: TextStyle(color: Color(secondaryColor), fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMontoGrid(BuildContext context, AppState state) {
    final montos = [2000, 5000, 10000, 15000, 20000, 30000];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: montos.length,
      itemBuilder: (context, index) {
        final monto = montos[index];
        final isSelected = state.seleccionarSaldo == monto;
        return _buildMontoItem(context, monto, isSelected);
      },
    );
  }

  Widget _buildMontoItem(BuildContext context, int monto, bool isSelected) {
    return GestureDetector(
      onTap: () => context.read<AppBloc>().add(SeleccionarSaldo(seleccionarSaldo: monto)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Color(primaryColor) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Color(primaryColor) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: Color(primaryColor).withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))]
              : [],
        ),
        child: Center(
          child: Text(
            "\$${formatearMiles(monto)}",
            style: TextStyle(
              color: isSelected ? Colors.white : Color(neutralTextColor),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton({IconData? icon, String? imagePath, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: Color(primaryColor), size: 22)
              : Image.asset(imagePath!, scale: 1.5),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: 'Outfit',
          color: Color(neutralTextColor),
        ),
      ),
    );
  }

  Widget _buildEventsSlider(BuildContext context) {
    final List<Map<String, String>> events = [
      {
        "title": "Beneficios de la TNE",
        "tag": "EXCLUSIVO",
        "image": "assets/images/tne-card-1.png",
        "desc": "Conoce todos los beneficios académicos y de transporte que tienes por ser estudiante vigente."
      },
      {
        "title": "Descuentos con tu TNE",
        "tag": "DESCUENTOS",
        "image": "assets/images/tne-card-2.png",
        "desc": "Aprovecha descuentos en cine, alimentación, vestuario y mucho más solo presentando tu pase."
      },
    ];

    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return GestureDetector(
            onTap: () => _showEventModal(context, event),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: AssetImage(event["image"]!),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            event["tag"]!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          event["title"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEventModal(BuildContext context, Map<String, String> event) {
    final List<Map<String, dynamic>> benefits = [
      {"icon": Icons.directions_bus_filled_rounded, "title": "Transporte Rebajado", "desc": "Tarifa reducida en buses, Metro y Trenes a nivel nacional."},
      {"icon": Icons.museum_rounded, "title": "Cultura Gratis", "desc": "Entrada liberada a museos nacionales y galerías de arte."},
      {"icon": Icons.movie_filter_rounded, "title": "Cine 2x1", "desc": "Descuentos exclusivos en cadenas de cine seleccionadas."},
      {"icon": Icons.fastfood_rounded, "title": "Alimentación", "desc": "Promociones en locales de comida rápida y cafeterías."},
      {"icon": Icons.sports_soccer_rounded, "title": "Eventos Deportivos", "desc": "Entradas rebajadas para eventos masivos y estadios."},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Color(neutralBgColor),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            // Header Image with close button
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    image: DecorationImage(
                      image: AssetImage(event["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
                      child: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event["tag"]!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Color(primaryColor),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event["title"]!,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Outfit',
                        color: Color(neutralTextColor),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      event["desc"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(neutralTextColor).withOpacity(0.6),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Lista de Beneficios",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 16),
                    
                    // Benefits List
                    ...benefits.map((b) => Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(primaryColor).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(b["icon"], color: Color(primaryColor), size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  b["title"],
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                ),
                                Text(
                                  b["desc"],
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    
                    const SizedBox(height: 24),
                    PrimaryCustomButton(
                      label: "Ver todos los convenios",
                      onPressed: () => Navigator.pop(context),
                      size: double.infinity,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTneCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required int balance,
    required String imagePath,
    required bool isSecondary,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(color: Color(primaryColor).withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800, fontFamily: 'Outfit')),
                          Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                        ],
                      ),
                      if (balance >= 0)
                        Text(
                          "\$${formatearMiles(balance)}",
                          style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, fontFamily: 'Outfit'),
                        ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSecondary ? Colors.white.withOpacity(0.2) : Colors.white,
                        foregroundColor: isSecondary ? Colors.white : Color(primaryColor),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      onPressed: onAction,
                      child: Text(actionLabel, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatearMiles(int numero) {
    String numeroStr = numero.toString();
    String resultado = '';
    int contador = 0;
    for (int i = numeroStr.length - 1; i >= 0; i--) {
      resultado = numeroStr[i] + resultado;
      contador++;
      if (contador % 3 == 0 && i != 0) {
        resultado = '.$resultado';
      }
    }
    return resultado;
  }
}
