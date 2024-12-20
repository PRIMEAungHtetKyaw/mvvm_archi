import 'package:drift/drift.dart';
import 'database.dart';
import 'item_table.dart';

part 'item_dao.g.dart';

@DriftAccessor(tables: [Items])
class ItemDao extends DatabaseAccessor<AppDatabase> with _$ItemDaoMixin {
  ItemDao(AppDatabase db) : super(db);

  Future<List<ItemEntity>> getAllItems() => select(items).get();

  Future<void> insertItem(ItemEntity item) => into(items).insert(item);

  Future<void> updateItem(ItemEntity item) => update(items).replace(item);

  Future<void> deleteItem(String id) =>
      (delete(items)..where((tbl) => tbl.id.equals(id))).go();
}
