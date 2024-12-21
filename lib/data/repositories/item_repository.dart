import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';

class FirestoreItemRepository implements ItemRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirestoreItemRepository(this._firestore, this._auth);

  // Helper to get the current user's collection
  CollectionReference get _userItemsCollection {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user is currently logged in.');
    }
    return _firestore.collection('users').doc(user.uid).collection('items');
  }

  @override
  Future<List<Item>> fetchItems() async {
    final snapshot = await _userItemsCollection.get();
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
    await _userItemsCollection.doc(item.id).set({
      'title': item.title,
      'description': item.description,
    });
  }

  @override
  Future<void> deleteItem(String id) async {
    await _userItemsCollection.doc(id).delete();
  }

  @override
  Future<void> updateItem(Item item) async {
    await _userItemsCollection.doc(item.id).update({
      'title': item.title,
      'description': item.description,
    });
  }
  
  @override
  Future<void> clearItems() async{
     final snapshot = await _userItemsCollection.get();

  for (final doc in snapshot.docs) {
    await doc.reference.delete(); // Delete each document
  }
  }
}