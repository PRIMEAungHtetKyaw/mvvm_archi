
// Define the provider for ItemListViewModel
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/data/local/database.dart';
import 'package:todo_mvvm/data/repositories/drift_item_repository.dart';
import 'package:todo_mvvm/data/repositories/item_repository.dart';
import 'package:todo_mvvm/domain/entities/item.dart';
import 'package:todo_mvvm/domain/repositories/item_repository.dart';
import 'package:todo_mvvm/viewmodels/item_list_view_model.dart';

final itemListViewModelProvider =
    AsyncNotifierProvider<ItemListViewModel, List<Item>>(ItemListViewModel.new);
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// Drift repository for local caching
final localItemRepositoryProvider = Provider<ItemRepository>((ref) {
  final database = ref.read(databaseProvider);
  return DriftItemRepository(database);
});

// Firestore repository for remote operations
final remoteItemRepositoryProvider = Provider<ItemRepository>((ref) {
  return FirestoreItemRepository(FirebaseFirestore.instance, FirebaseAuth.instance);
});