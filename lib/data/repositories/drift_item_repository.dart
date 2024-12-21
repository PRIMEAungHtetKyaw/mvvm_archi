import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../local/database.dart'; 

class DriftItemRepository implements ItemRepository {
  final AppDatabase _db;

  DriftItemRepository(this._db);

  @override
  Future<List<Item>> fetchItems() async {
    final entities = await _db.select(_db.items).get();
    return entities
        .map((e) => Item(id: e.id, title: e.title, description: e.description))
        .toList();
  }

  @override
  Future<void> addItem(Item item) async {
    await _db.into(_db.items).insert(ItemEntity(
      id: item.id,
      title: item.title,
      description: item.description,
    ));
  }

  @override
  Future<void> updateItem(Item item) async {
    await _db.update(_db.items).replace(ItemEntity(
      id: item.id,
      title: item.title,
      description: item.description,
    ));
  }

  @override
  Future<void> deleteItem(String id) async {
    await (_db.delete(_db.items)..where((tbl) => tbl.id.equals(id))).go();
  }
   @override
  Future<void> clearItems() async {
    await _db.delete(_db.items).go();  
  }
}