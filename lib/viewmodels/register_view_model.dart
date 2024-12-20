 
import 'package:riverpod/riverpod.dart';
import 'package:todo_mvvm/viewmodels/login_view_model.dart';

import '../domain/repositories/auth_repository.dart';

class RegisterViewModel extends AsyncNotifier<bool> {
  late final AuthRepository _authRepository;

  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Future<bool> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    return false; // Initial state: not registered
  }

  Future<void> register() async {
    if (password != confirmPassword) {
      // Handle password mismatch
      state = AsyncError(Exception('Passwords do not match'), StackTrace.current);
      return;
    }

    state = const AsyncLoading(); // Set loading state
    try {
      await _authRepository.register(email, password);
      state = const AsyncData(true); // Registration successful
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // Registration failed
    }
  }
}

// Provider for RegisterViewModel
final registerViewModelProvider =
    AsyncNotifierProvider<RegisterViewModel, bool>(RegisterViewModel.new);