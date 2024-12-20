import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_mvvm/data/repositories/auth_repository.dart';
import '../domain/repositories/auth_repository.dart';
 

class LoginViewModel extends AsyncNotifier<bool> {
  late final AuthRepository _authRepository;

  String email = '';
  String password = '';

  @override
  Future<bool> build() async {
    // Initialize AuthRepository here
    _authRepository = ref.read(authRepositoryProvider); // Use your DI setup
    return false; // Default state: not logged in
  }

  Future<void> login() async {
    state = const AsyncLoading(); // Set loading state
    try {
      await _authRepository.login(email, password);
      state = const AsyncData(true); // Login successful
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // Login failed
    }
  }
}

final loginViewModelProvider =
    AsyncNotifierProvider<LoginViewModel, bool>(LoginViewModel.new);


    final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
});