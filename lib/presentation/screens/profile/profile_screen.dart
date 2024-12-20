
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/core/router/router.dart';
import 'package:todo_mvvm/viewmodels/profile_view_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileViewModel = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: profileViewModel.when(
        data: (user) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(profileViewModelProvider.notifier).logout();
                   context.go("/login");
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}