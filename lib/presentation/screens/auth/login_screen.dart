// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_mvvm/core/assets/assets_constants.dart';
import 'package:todo_mvvm/core/theme/colors.dart';
import 'package:todo_mvvm/viewmodels/login_view_model.dart';

import 'package:go_router/go_router.dart';

import '../../widgets/common_textfield.dart';

final loginEmailController = TextEditingController();
final loginPwdController = TextEditingController();

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);
    final formKey = GlobalKey<FormState>(); // Add a GlobalKey for the Form

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50),
                  Lottie.asset(
                    width: 200,
                    height: 200,
                    AssetsConstants.authImg,
                  ),
                  const Gap(20),
                  CommonTextFormField(
                    controller: loginEmailController,
                    hintText: 'Email ID',
                    prefixIcon: Icons.alternate_email,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Basic email format validation
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      ref.read(loginViewModelProvider.notifier).email = value;
                    },
                  ),
                  const Gap(10),
                  CommonTextFormField(
                    controller: loginPwdController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      ref.read(loginViewModelProvider.notifier).password = value;
                    },
                  ),
                  const Gap(20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await ref.read(loginViewModelProvider.notifier).login();
                          final state = ref.read(loginViewModelProvider);

                          if (state is AsyncData && state.value != null) {
                            // Navigate to the main screen using GoRouter
                            loginEmailController.text ="";
                            loginPwdController.text = "";
                            context.go('/main');
                          } else if (state is AsyncError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${state.error}')),
                            );
                          }
                        }
                      },
                      child: loginState is AsyncLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5 ),
                              child: CircularProgressIndicator(color: AppColors.whiteColor,),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              child: Text('Login'),
                            ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  context.go("/register");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "New to Master?",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                    ),
                    const Gap(10),
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.primaryLight,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
