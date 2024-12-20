 
import 'package:riverpod/riverpod.dart';

import '../domain/entities/user.dart';
import '../domain/repositories/auth_repository.dart';
import 'login_view_model.dart';
class ProfileViewModel extends AsyncNotifier<User> {
  late final AuthRepository _authRepository;

  @override
  Future<User> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    final user = await _authRepository.getCurrentUser();
    if (user == null) {
      throw Exception('No user is logged in.');
    }
    return user;
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      state = AsyncError(Exception('Logged out'), StackTrace.current); // Fix: Provide both arguments
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // Correct AsyncError instantiation
    }
  }
}

// Provider for ProfileViewModel
final profileViewModelProvider =
    AsyncNotifierProvider<ProfileViewModel, User>(ProfileViewModel.new);