import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';

class BodyCustom extends StatelessWidget {
    final Widget child;
    const BodyCustom({required this.child, super.key});

    @override
    Widget build(BuildContext context) {
        return 
             Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity, // Ocupa todo el alto disponible
                decoration: BoxDecoration(
                    color: Color(primaryColor),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                        ),
                        color: Color(neutralBgColor),
                    ),
                    child: child
                ),
            );
        
    }
}