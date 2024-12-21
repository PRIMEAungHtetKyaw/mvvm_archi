
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_mvvm/core/assets/assets_constants.dart';
import 'package:todo_mvvm/core/theme/colors.dart';
import 'package:todo_mvvm/presentation/widgets/common_textfield.dart';
import 'package:todo_mvvm/providers/auth_providers.dart'; 
 
final reauthPwdController = TextEditingController();

class ReauthenticateScreen extends ConsumerWidget {
  const ReauthenticateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>(); // Form key for validation
    final loginState = ref.watch(loginViewModelProvider);

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
                  Stack(
                    children: [
                      Center(
                        child: Lottie.asset(
                          width: 200,
                          height: 200,
                          AssetsConstants.authImg,
                        ),
                      ),
                       InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Icon(Icons.arrow_back_outlined),
                          ),
                        ),
                    ],
                  ),
                  const Gap(20),
                   
                  CommonTextFormField(
                    controller: reauthPwdController,
                    hintText: 'Confrim Password',
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
                  ),
                  const Gap(20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await ref
                                .read(loginViewModelProvider.notifier)
                                .reauthenticate(
                                  FirebaseAuth.instance.currentUser?.email ?? "" ,
                                  reauthPwdController.text,
                                );

                            // On success, navigate back to the profile screen and delete the account
                            context.pop(true); // Pass success flag back
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                      child: loginState is AsyncLoading
                          ? const CircularProgressIndicator(color: AppColors.whiteColor)
                          : const Text('Reauthenticate'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}