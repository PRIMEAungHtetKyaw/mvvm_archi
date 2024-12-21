// ignore_for_file: empty_catches
 
import 'package:riverpod_annotation/riverpod_annotation.dart';  
import '../domain/entities/item.dart';
import '../domain/repositories/item_repository.dart';
import '../providers/auth_providers.dart';
import '../providers/item_providers.dart';
class ItemListViewModel extends AsyncNotifier<List<Item>> {
  ItemRepository? _remoteRepository;
  ItemRepository? _localRepository;

  @override
  Future<List<Item>> build() async {
    // Initialize repositories lazily
    _remoteRepository ??= ref.read(remoteItemRepositoryProvider);
    _localRepository ??= ref.read(localItemRepositoryProvider);
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
     if (user == null) return [];
    await _syncFromFirestore(); // Sync Firestore data to Drift
    return fetchItems();
  }

  Future<List<Item>> fetchItems() async {
    state = const AsyncLoading();
    try {
      // Fetch data from the local repository (Drift)
      final items = await _localRepository!.fetchItems();
      state = AsyncData(items);
      return items;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return [];
    }
  }

  Future<void> addItem(Item item) async {
    try {
      // Add to local cache (Drift)
      await _localRepository!.addItem(item);

      // Push the change to Firestore
      await _remoteRepository!.addItem(item);

      await fetchItems(); // Refresh UI
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      // Delete from local cache (Drift)
      await _localRepository!.deleteItem(id);

      // Push the deletion to Firestore
      await _remoteRepository!.deleteItem(id);

      await fetchItems(); // Refresh UI
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      // Update local cache (Drift)
      await _localRepository!.updateItem(item);

      // Push the update to Firestore
      await _remoteRepository!.updateItem(item);

      await fetchItems(); // Refresh UI
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> _syncFromFirestore() async {
    try {
      // Fetch remote data from Firestore
      final remoteItems = await _remoteRepository!.fetchItems();

      // Sync Firestore data to local database (Drift)
      for (final item in remoteItems) {
        await _localRepository!.addItem(item);
      }
    } catch (e) {
      
    }
  }
}

