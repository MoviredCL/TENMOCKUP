import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';

class AppTheme {

	AppTheme();

	ThemeData getThemeData(){
		return ThemeData(
			useMaterial3: true,
			colorSchemeSeed: Color(primaryColor),
			filledButtonTheme: FilledButtonThemeData(
			style: FilledButton.styleFrom(
				backgroundColor: Color(primaryColor), // Color de fondo del botón
				foregroundColor: Colors.white, // Color del texto/icono
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(0),
					),
				),
			),
			
		);
	}
}
