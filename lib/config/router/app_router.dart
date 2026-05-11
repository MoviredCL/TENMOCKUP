import 'package:go_router/go_router.dart';
import 'package:tneapp/presentation/screens/home_screen.dart';
import 'package:tneapp/presentation/screens/login_screen.dart';
import 'package:tneapp/presentation/screens/recharge_screen.dart';
import 'package:tneapp/presentation/screens/baes_qr_screen.dart';
import 'package:tneapp/presentation/screens/benefits_screen.dart';
import 'package:tneapp/presentation/screens/applications_screen.dart';
import 'package:tneapp/presentation/screens/tne_module_screen.dart';
import 'package:tneapp/presentation/screens/profile_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/recharge',
      builder: (context, state) => const RechargeScreen(),
    ),
    GoRoute(
      path: '/baes-qr',
      builder: (context, state) => const BaesQrScreen(),
    ),
    GoRoute(
      path: '/benefits',
      builder: (context, state) => const BenefitsScreen(),
    ),
    GoRoute(
      path: '/applications',
      builder: (context, state) => const ApplicationsScreen(),
    ),
    GoRoute(
      path: '/tne-module',
      builder: (context, state) => const TneModuleScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
