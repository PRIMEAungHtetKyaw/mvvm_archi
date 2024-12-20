import 'package:drift/drift.dart';

@DataClassName('ItemEntity')
class Items extends Table {
  TextColumn get id => text()(); // Unique ID
  TextColumn get title => text()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}