import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart'; 
import 'package:todo_mvvm/viewmodels/profile_view_model.dart';

import '../../../core/assets/assets_constants.dart';
import '../../../core/theme/theme_controller.dart'; 

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileViewModel = ref.watch(profileViewModelProvider);
    final themeMode = ref.watch(themeControllerProvider); // Watch current ThemeMode
    final themeController = ref.read(themeControllerProvider.notifier); // Access the controller

    return Scaffold(
      body: profileViewModel.when(
        data: (user) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back Icon and Profile Image
                    Stack(
                      children: [
                        Center(
                          child: Lottie.asset(
                            width: 200,
                            height: 200,
                            AssetsConstants.profileIMG,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                            child: Icon(Icons.arrow_back_outlined),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // User Email
                    Text(
                      'Email: ${user.email}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),

                    // Theme Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dark Mode:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: themeMode == ThemeMode.dark,
                          onChanged: (isDarkMode) {
                            themeController.setThemeMode(
                              isDarkMode ? AppThemeMode.dark : AppThemeMode.light,
                            ); // Update the theme
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Logout Button
              SizedBox(
                width: double.infinity,  
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(profileViewModelProvider.notifier).logout();
                    context.go('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Error: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
    );
  }
}
