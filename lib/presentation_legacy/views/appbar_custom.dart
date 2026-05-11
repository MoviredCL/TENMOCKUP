import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';


class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
    @override
    final Size preferredSize;

    AppBarCustom({super.key}) : preferredSize = Size.fromHeight(150);

    @override
    Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
	    double imageWidth = screenWidth * 0.8; // 50% del ancho de la pantalla

        return Container(
			color: Color(primaryColor),
			height: 150,
			child: Container(
				color: Color(primaryColor),
				child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Center(
                                    child: Image.asset("assets/images/appbar.png", width: imageWidth,),
                                  ),
                                )
			)
		);
    }
}