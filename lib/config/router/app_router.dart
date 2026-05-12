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
import 'package:tneapp/presentation/screens/profile_detail_screens.dart';
import 'package:tneapp/presentation/screens/movements_screen.dart';
import 'package:tneapp/presentation/screens/baes_movements_screen.dart';
import 'package:tneapp/presentation/screens/profile_sync_screen.dart';

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
      pageBuilder: (context, state) {
        final isPhysical = state.extra as bool? ?? false;
        return CustomTransitionPage(
          key: state.pageKey,
          child: RechargeScreen(isPhysical: isPhysical),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: '/movements',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MovementsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/baes-movements',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const BaesMovementsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/profile-sync-details',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProfileSyncScreen(),
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
      routes: [
        GoRoute(
          path: 'personal-data',
          builder: (context, state) => const PersonalDataScreen(),
        ),
        GoRoute(
          path: 'security',
          builder: (context, state) => const SecurityScreen(),
        ),
        GoRoute(
          path: 'pin',
          builder: (context, state) => const PinScreen(),
        ),
      ],
    ),
  ],
);
