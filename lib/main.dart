import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/config/router/app_router.dart';
import 'package:tneapp/config/theme/app_theme.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';

Future<void> main() async {
    runApp(MultiBlocProvider(
        providers: [
            BlocProvider(create: (_) => AppBloc())
        ],
        child: const MainApp(),
    ));
}


class MainApp extends StatelessWidget{
	const MainApp({super.key});

	@override
	Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Color(primaryColor), // Color de la barra de estado
            statusBarIconBrightness: Brightness.light, // Iconos en la barra (claro u oscuro)
            statusBarBrightness: Brightness.dark, // Esto cambia el color del texto de la barra (en Android)
        ));
		return MaterialApp.router(
			routerConfig: appRouter,
			debugShowCheckedModeBanner: false,
            theme: AppTheme().getThemeData(),
		);
	}
}

