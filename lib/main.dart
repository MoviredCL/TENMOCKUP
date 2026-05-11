import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tneapp/config/router/app_router.dart';
import 'package:tneapp/config/theme/app_theme.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';

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
      title: 'TNE Digital',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme().getThemeData(),
    );
  }
}
