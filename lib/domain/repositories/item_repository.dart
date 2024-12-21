import '../entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> fetchItems();
  Future<void> addItem(Item item);
  Future<void> deleteItem(String id);
  Future<void> updateItem(Item item);  
   Future<void> clearItems();
}