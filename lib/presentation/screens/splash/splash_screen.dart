
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/viewmodels/login_view_model.dart'; 

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> checkAuthentication() async {
      final authVM = ref.read(authRepositoryProvider);
      final user = await authVM.getCurrentUser();

      if (user != null) {
        context.go('/main'); // Navigate to the main screen
      } else {
        context.go('/login'); // Navigate to the login screen
      }
    }

    checkAuthentication();

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}