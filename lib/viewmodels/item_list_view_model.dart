import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; 
import '../data/repositories/item_repository.dart';
import '../domain/entities/item.dart';
import '../domain/repositories/item_repository.dart';

 
class ItemListViewModel extends AsyncNotifier<List<Item>> {
  late final ItemRepository _itemRepository;

  @override
  Future<List<Item>> build() async {
    _itemRepository = ref.read(itemRepositoryProvider); // Use your DI setup
    return fetchItems(); // Initial fetch
  }

  Future<List<Item>> fetchItems() async {
    state = const AsyncLoading(); // Set loading state
    try {
      final items = await _itemRepository.fetchItems();
      state = AsyncData(items); // Fetch successful
      return items;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // Fetch failed
      return [];
    }
  }

  Future<void> addItem(Item item) async {
    try {
      await _itemRepository.addItem(item);
      await fetchItems(); // Refresh after adding
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _itemRepository.deleteItem(id);
      await fetchItems(); // Refresh after deletion
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      await _itemRepository.updateItem(item); // Call repository to update item
      await fetchItems(); // Refresh after updating
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

// Define the provider for ItemListViewModel
final itemListViewModelProvider =
    AsyncNotifierProvider<ItemListViewModel, List<Item>>(ItemListViewModel.new);

// Define the repository provider
final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return FirestoreItemRepository(FirebaseFirestore.instance);
});