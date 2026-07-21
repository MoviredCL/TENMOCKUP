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
import 'package:tneapp/presentation/screens/scholarship_application_screen.dart';
import 'package:tneapp/presentation/screens/application_success_screen.dart';

// Login Screens
import 'package:tneapp/presentation/screens/student_login_screen.dart';
import 'package:tneapp/presentation/screens/establishment_login_screen.dart';
import 'package:tneapp/presentation/screens/parent_login_screen.dart';

// Home Screens
import 'package:tneapp/presentation/screens/establishment_home_screen.dart';
import 'package:tneapp/presentation/screens/establishment_delivery_screen.dart';
import 'package:tneapp/presentation/screens/establishment_assign_benefit_screen.dart';
import 'package:tneapp/models/beneficio.dart';
import 'package:tneapp/presentation/screens/parent_home_screen.dart';
import 'package:tneapp/presentation/screens/parent_profile_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/login-student',
      builder: (context, state) => const StudentLoginScreen(),
    ),
    GoRoute(
      path: '/login-establishment',
      builder: (context, state) => const EstablishmentLoginScreen(),
    ),
    GoRoute(
      path: '/login-parent',
      builder: (context, state) => const ParentLoginScreen(),
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
      path: '/establishment-home',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const EstablishmentHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/establishment-delivery',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const EstablishmentDeliveryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/establishment-assign-benefit',
      pageBuilder: (context, state) {
        final beneficio = state.extra as Beneficio;
        return CustomTransitionPage(
          key: state.pageKey,
          child: EstablishmentAssignBenefitScreen(beneficio: beneficio),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: '/parent-home',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ParentHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/parent-profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ParentProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
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
    GoRoute(
      path: '/scholarship-application',
      pageBuilder: (context, state) {
        final scholarshipName = state.extra as String? ?? 'Beca';
        return CustomTransitionPage(
          key: state.pageKey,
          child: ScholarshipApplicationScreen(scholarshipName: scholarshipName),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: '/application-success',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ApplicationSuccessScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
  ],
);
