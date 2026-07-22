import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tneapp/config/router/app_router.dart';
import 'package:tneapp/config/theme/app_theme.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:tneapp/presentation/bloc/establishment/establishment_auth_bloc.dart';
import 'package:tneapp/presentation/bloc/establishment/establishment_delivery_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Bloquear orientación vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const AppStateProvider());
}

class AppStateProvider extends StatelessWidget {
  const AppStateProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppBloc()),
        BlocProvider(create: (_) => EstablishmentAuthBloc()..add(CheckAuthStatus())),
        BlocProvider(create: (_) => EstablishmentDeliveryBloc()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Junaeb App',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme().getThemeData(),
    );
  }
}
