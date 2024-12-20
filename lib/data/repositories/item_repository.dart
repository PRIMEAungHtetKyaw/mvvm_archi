import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';

class FirestoreItemRepository implements ItemRepository {
  final FirebaseFirestore _firestore;

  FirestoreItemRepository(this._firestore);

  @override
  Future<List<Item>> fetchItems() async {
    final snapshot = await _firestore.collection('items').get();
    return snapshot.docs.map((doc) {
      return Item(
        id: doc.id,
        title: doc['title'],
        description: doc['description'],
      );
    }).toList();
  }

  @override
  Future<void> addItem(Item item) async {
    await _firestore.collection('items').add({
      'title': item.title,
      'description': item.description,
    });
  }

  @override
  Future<void> deleteItem(String id) async {
    await _firestore.collection('items').doc(id).delete();
  }

  @override
  Future<void> updateItem(Item item) async {
    await _firestore.collection('items').doc(item.id).update({
      'title': item.title,
      'description': item.description,
    });
  }
}