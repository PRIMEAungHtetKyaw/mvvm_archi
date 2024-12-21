 
import 'package:riverpod/riverpod.dart';

import '../domain/entities/user.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/item_repository.dart';
import 'item_list_view_model.dart';
import 'login_view_model.dart';
class ProfileViewModel extends AsyncNotifier<User> {
  late final AuthRepository _authRepository;
  late final ItemRepository _localRepository;
  late final ItemRepository _remoteRepository;

  @override
  Future<User> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    _localRepository = ref.read(localItemRepositoryProvider);
    _remoteRepository = ref.read(remoteItemRepositoryProvider);

    final user = await _authRepository.getCurrentUser();
    if (user == null) {
      throw Exception('No user is logged in.');
    }
    return user;
  }

  Future<void> logout() async {
    try {
       await _localRepository.clearItems();
      await _authRepository.logout();
      ref.invalidate(itemListViewModelProvider);   
      state = AsyncError(Exception('Logged out'), StackTrace.current); // Fix: Provide both arguments
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // Correct AsyncError instantiation
    }
  }

      Future<void> deleteAccount() async {
    try {
      // Clear Firestore data
      await _remoteRepository.clearItems();

      // Clear local database
      await _localRepository.clearItems();

      // Delete the user account
      await _authRepository.deleteAccount();
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

// Provider for ProfileViewModel
final profileViewModelProvider =
    AsyncNotifierProvider<ProfileViewModel, User>(ProfileViewModel.new);