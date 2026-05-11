import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/views/appbar_custom.dart';
import 'package:tneapp/presentation/widgets/boton_clave_unica.dart';
import 'package:tneapp/presentation/widgets/primary_custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(),
        body: Container(
            color: Color(primaryDarkColor),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    color: Color(neutralBgColor),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            const SizedBox(height: 20),
                            Text(
                              "¡Hola!", 
                              style: TextStyle(
                                fontSize: 32, 
                                fontWeight: FontWeight.w800,
                                color: Color(neutralTextColor),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                                "Bienvenido a la nueva forma de\nmoverte con tu App TNE Digital",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18, 
                                  color: Color(neutralTextColor).withOpacity(0.7),
                                  height: 1.4,
                                ),
                            ),

                            const SizedBox(height: 48),

                            PrimaryCustomButton(
                                label: "Crear cuenta",
                                onPressed: () {
                                    context.push("/crear_cuenta");
                                },
                                icono: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 20,
                                ),
                                size: double.infinity,
                            ),

                            const SizedBox(height: 16),

                            BotonClaveUnica(
                                label: "Crear cuenta con ClaveÚnica",
                                onPressed: () {
                                    context.push("/clave_unica");
                                },
                                size: double.infinity,
                                rounded: true,
                            ),

                            const Spacer(),

                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                ),
                                child: Column(
                                    children: [
                                        Text(
                                            "¿Ya tienes cuenta?",
                                            style: TextStyle(
                                              fontSize: 16, 
                                              color: Color(neutralTextColor).withOpacity(0.6),
                                            ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            "Inicia sesión",
                                            style: TextStyle(
                                              fontSize: 20, 
                                              fontWeight: FontWeight.w700,
                                              color: Color(neutralTextColor),
                                            ),
                                        ),

                                        const SizedBox(height: 24),

                                        SizedBox(
                                            width: double.infinity,
                                            height: 52,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(color: Color(primaryColor), width: 1.5),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  foregroundColor: Color(primaryColor),
                                              ),
                                              onPressed: () {
                                                  context.push("/iniciar_sesion");
                                              },
                                              child: const Text(
                                                "Ingresar", 
                                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                              ),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(width: 180, child: Image.asset("assets/images/branding2.png", fit: BoxFit.contain)),
                            const SizedBox(height: 10),
                        ],
                    ),
                ),
            ),
        ),
    );
  }
}
