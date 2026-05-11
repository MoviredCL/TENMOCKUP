import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';

class PrimaryCustomButton extends StatelessWidget {

    final String label;
    final VoidCallback onPressed;
    final Icon? icono;
    final double size;

    const PrimaryCustomButton({super.key, required this.label, required this.onPressed, required this.size, this.icono});

    

    @override
    Widget build(BuildContext context) {
        Widget child;
        if(icono != null){
            child = IntrinsicWidth(
                stepWidth: size,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        icono!,
                        SizedBox(
                            width: 10,
                        ),
                        Text(
                            label, 
                        )
                    ],
                ),
            );
        }else{
            child = Text(label, style: TextStyle(fontWeight: FontWeight.w700),);
        }

        return SizedBox(
            width: size,
            height: 56, // Modern height
            child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Color(primaryColor),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                    ),
                ),
                onPressed: onPressed, 
                child: child 
            ),
        );
    }
}