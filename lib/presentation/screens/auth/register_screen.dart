
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_mvvm/core/assets/assets_constants.dart';
import 'package:todo_mvvm/core/theme/colors.dart';
import 'package:todo_mvvm/presentation/widgets/common_textfield.dart';
import 'package:todo_mvvm/providers/auth_providers.dart'; 
final regEmailController = TextEditingController();
final regPwdController = TextEditingController();
final regConfirmPwdController = TextEditingController();

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerViewModelProvider);
    final formKey = GlobalKey<FormState>(); // Add a GlobalKey for the Form

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(50),
                Lottie.asset(
                  width: 200,
                  height: 200,
                  AssetsConstants.authImg,
                ),
                const Gap(20),
                CommonTextFormField(
                  controller: regEmailController,
                  hintText: 'Email ID',
                  prefixIcon: Icons.alternate_email,
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(registerViewModelProvider.notifier).email = value;
                  },
                ),
                const Gap(10),
                CommonTextFormField(
                  controller: regPwdController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(registerViewModelProvider.notifier).password = value;
                  },
                ),
                const Gap(10),
                CommonTextFormField(
                  controller: regConfirmPwdController,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != regPwdController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(registerViewModelProvider.notifier).confirmPassword = value;
                  },
                ),
                const Gap(20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ref.read(registerViewModelProvider.notifier).register();

                        // Check the current state of the registration process
                        ref.read(registerViewModelProvider).when(
                              data: (isSuccess) {
                                if (isSuccess) {
                                  regEmailController.text = "";
                                  regPwdController.text = "";
                                  regConfirmPwdController.text = "";
                                  context.go('/'); // Navigate to the login screen
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Registration failed')),
                                  );
                                }
                              },
                              loading: () {},
                              error: (error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $error')),
                                );
                              },
                            );
                      }
                    },
                    child: registerState is AsyncLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 5  ),
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            child: Text('Register'),
                          ),
                  ),
                ),
                const Gap(20),
                InkWell(
                  onTap: () {
                    context.go("/login");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Joined us before?",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                      ),
                      const Gap(10),
                      Text(
                        "Login",
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
      ),
    );
  }
}
