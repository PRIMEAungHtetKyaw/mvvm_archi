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
  _authRepository = ref.watch(authRepositoryProvider);

  // Skip reinitializing if the user is already logged out
  final user = await _authRepository.getCurrentUser();
  if (user == null) return false;

  return false;
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

   Future<void> reauthenticate(String email, String password) async {
    try {
      await _authRepository.reauthenticate(email, password);
    } catch (e) {
      throw Exception('Reauthentication failed: $e');
    }
  }
}

final loginViewModelProvider =
    AsyncNotifierProvider<LoginViewModel, bool>(LoginViewModel.new);


    final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
});