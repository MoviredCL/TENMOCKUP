import 'package:flutter/material.dart';


class BotonMontosSaldo extends StatelessWidget {

	final String label;
    final VoidCallback onPressed;
    final int monto;
    final int montoFijo;

    const BotonMontosSaldo({super.key, required this.label, required this.onPressed, required this.monto, required this.montoFijo});


    @override
    Widget build(BuildContext context) {
        
      	return SizedBox(
			width: 160,
            height: 60,
            child: FilledButton(
                style: FilledButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Colors.white, // color de fondo
                    padding: EdgeInsets.only(left: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                            color: montoFijo==monto?Colors.orange:Colors.transparent,
                            width: 2
                        )
                    ),
                ),
                onPressed: onPressed, 
                child: Text(label, style: TextStyle(color: Colors.black, fontWeight: montoFijo==monto?FontWeight.bold:FontWeight.normal),) 
            ),
        );
    }
}