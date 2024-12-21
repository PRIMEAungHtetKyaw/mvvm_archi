 
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_mvvm/providers/item_providers.dart';
import 'package:todo_mvvm/providers/profile_providers.dart'; 
import '../domain/repositories/auth_repository.dart';
import '../providers/auth_providers.dart';  
 

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
      // Invalidate related providers to reset their state
      ref.invalidate(profileViewModelProvider);
      ref.invalidate(itemListViewModelProvider);
 
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

