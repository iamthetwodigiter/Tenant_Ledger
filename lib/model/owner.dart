import 'package:drift/drift.dart';

class Owner extends Table {
  IntColumn get ownerID => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get phone => text()();
  TextColumn get propertyName => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  TextColumn get state => text()();
  TextColumn get pinCode => text()();
  TextColumn get upiID => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {ownerID};
  @override
  String get tableName => 'owner';
}
