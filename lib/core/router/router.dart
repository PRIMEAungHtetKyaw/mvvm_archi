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
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddUpdateTodoScreen(),
    ),

    GoRoute(
      path: '/edit',
      builder: (context, state) {
        final item = state.extra as Item;
        return AddUpdateTodoScreen(item: item);
      },
    ),
     GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);