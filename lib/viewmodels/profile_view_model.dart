 
import 'package:riverpod/riverpod.dart';
import 'package:todo_mvvm/providers/profile_providers.dart';

import '../domain/entities/user.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/item_repository.dart';
import '../providers/auth_providers.dart';
import '../providers/item_providers.dart'; 
import 'register_view_model.dart';

class ProfileViewModel extends AsyncNotifier<User> {
  AuthRepository? _authRepository;
  ItemRepository? _localRepository;
  ItemRepository? _remoteRepository;

  @override
  Future<User> build() async {
    // Initialize repositories lazily
    _authRepository ??= ref.watch(authRepositoryProvider);
    _localRepository ??= ref.watch(localItemRepositoryProvider);
    _remoteRepository ??= ref.watch(remoteItemRepositoryProvider);

    // Fetch the current user
    final user = await _authRepository?.getCurrentUser();
    if (user == null) {
      throw Exception('No user is logged in.');
    }
    return user;
  }

  Future<void> logout() async {
    try {
      // Clear local and remote items and logout
      await _localRepository?.clearItems();
      await _authRepository?.logout();

      // Invalidate related providers
      ref.invalidate(itemListViewModelProvider);
      ref.invalidate(profileViewModelProvider);
       ref.invalidate(registerViewModelProvider);
      // Set the state to null (logged out state)
      state = AsyncError(Exception('Logged out'), StackTrace.current);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> deleteAccount() async {
    try {
      // Clear Firestore and local database
      await _remoteRepository?.clearItems();
      await _localRepository?.clearItems();

      // Delete the user account
      await _authRepository?.deleteAccount();
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
