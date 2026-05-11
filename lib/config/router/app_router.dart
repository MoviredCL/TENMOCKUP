import 'package:flutter/material.dart';
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
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/recharge',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const RechargeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/baes-qr',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const BaesQrScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/benefits',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const BenefitsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/applications',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ApplicationsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/tne-module',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const TneModuleScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
  ],
);
