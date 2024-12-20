
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/viewmodels/register_view_model.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                ref.read(registerViewModelProvider.notifier).email = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                ref.read(registerViewModelProvider.notifier).password = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              onChanged: (value) {
                ref.read(registerViewModelProvider.notifier).confirmPassword = value;
              },
            ),
            const SizedBox(height: 16),
             ElevatedButton(
              onPressed: () async {
                await ref.read(registerViewModelProvider.notifier).register();

                // Check the current state of the registration process
                ref.read(registerViewModelProvider).when(
                  data: (isSuccess) {
                    if (isSuccess) {
                      // Navigate to the login screen
                     context.go('/');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration failed')),
                      );
                    }
                  },
                  loading: () {
                    // Optionally handle loading state here
                  },
                  error: (error, stackTrace) {
                    // Show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  },
                );
              },
              child: registerState is AsyncLoading
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}