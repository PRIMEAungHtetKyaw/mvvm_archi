import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/data/repositories/auth_repository.dart';
import 'package:todo_mvvm/domain/repositories/auth_repository.dart';
import 'package:todo_mvvm/viewmodels/login_view_model.dart';
import 'package:todo_mvvm/viewmodels/register_view_model.dart';

final loginViewModelProvider =
    AsyncNotifierProvider<LoginViewModel, bool>(LoginViewModel.new);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
});


// Provider for RegisterViewModel
final registerViewModelProvider =
    AsyncNotifierProvider<RegisterViewModel, bool>(RegisterViewModel.new);

