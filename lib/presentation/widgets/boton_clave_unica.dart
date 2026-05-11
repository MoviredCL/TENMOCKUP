import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';


class BotonClaveUnica extends StatelessWidget {

	final String label;
    final VoidCallback onPressed;
	final double size;
    final bool rounded;
    final bool logo;

    const BotonClaveUnica({super.key, required this.label, required this.onPressed, required this.size, this.rounded = false, this.logo = true});


    @override
    Widget build(BuildContext context) {
		Widget child;
        child = Row(
            children: [
                if(logo)Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset("assets/images/icono_clave_unica.png", width: 20, height: 20,),
                ),
                if(logo)SizedBox(width: 10,),
                Expanded(
                    child: Center(
                        child: Text(
                            label, 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                    ),
                )
            ],
        );
            


      	return SizedBox(
			width: size,
            height: 42,
            child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Color(claveunicaColor), // color de fondo
                    padding: EdgeInsets.only(left: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: rounded?BorderRadius.all(Radius.circular(10)):BorderRadius.circular(0),
                    ),
                ),
                onPressed: onPressed, 
                child: child 
            ),
        );
    }
}