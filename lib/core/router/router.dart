import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_mvvm/presentation/screens/auth/register_screen.dart';
import 'package:todo_mvvm/presentation/screens/main/main_screen.dart';
import 'package:todo_mvvm/presentation/screens/profile/profile_screen.dart';

import '../../domain/entities/item.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/todo/add_upd_todo_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return _buildSlideTransition(context, const SplashScreen());
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return _buildSlideTransition(context, const LoginScreen());
      },
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return _buildSlideTransition(context, const RegisterScreen());
      },
    ),
    GoRoute(
      path: '/main',
      pageBuilder: (context, state) {
        return _buildSlideTransition(context, const MainScreen());
      },
    ),
    GoRoute(
      path: '/add',
      pageBuilder: (context, state) {
        return _buildSlideTransition(context, const AddUpdateTodoScreen());
      },
    ),
    GoRoute(
      path: '/edit',
      pageBuilder: (context, state) {
        final item = state.extra as Item;
        return _buildSlideTransition(context, AddUpdateTodoScreen(item: item));
      },
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) {
        return _buildSlideTransition(context, const ProfileScreen());
      },
    ),
  ],
);

/// Custom slide transition builder
Page _buildSlideTransition(BuildContext context, Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide in from the right
      const end = Offset.zero; // To center
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}