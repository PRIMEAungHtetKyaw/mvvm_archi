// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_mvvm/core/assets/assets_constants.dart';
import 'package:todo_mvvm/core/theme/colors.dart';
import 'package:todo_mvvm/providers/auth_providers.dart'; 

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> checkAuthentication() async {
      Future.delayed(const Duration(milliseconds: 3000), () async {
        final authVM = ref.read(authRepositoryProvider);
        final user = await authVM.getCurrentUser();

        if (user != null) {
          context.go('/main'); // Navigate to the main screen
        } else {
          context.go('/login'); // Navigate to the login screen
        }
      });
    }

    checkAuthentication();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
          child: Lottie.asset(
        width: 200,
        AssetsConstants.welcomeImg,
      )),
    );
  }
}
