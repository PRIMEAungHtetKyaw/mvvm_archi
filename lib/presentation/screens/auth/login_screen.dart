import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/viewmodels/login_view_model.dart';

 
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the state of the ViewModel
    final loginState = ref.watch(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                // Update email field in ViewModel
                ref.read(loginViewModelProvider.notifier).email = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                // Update password field in ViewModel
                ref.read(loginViewModelProvider.notifier).password = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await ref.read(loginViewModelProvider.notifier).login();
                final state = ref.read(loginViewModelProvider);

                if (state is AsyncData && state.value != null) {
                  // Navigate to the main screen using GoRouter
                  context.go('/main');
                } else if (state is AsyncError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.error}')),
                  );
                }
              },
              child: loginState is AsyncLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the register screen using GoRouter
                context.go('/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
