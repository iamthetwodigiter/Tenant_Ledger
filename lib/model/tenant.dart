import 'package:drift/drift.dart';
import 'dart:convert';

// Custom TypeConverter for List<String>
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return List<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

class Tenant extends Table {
  IntColumn get tenantID => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get mobileNo => text()();
  TextColumn get aadharNo => text()();
  TextColumn get permanentAddress => text()();
  TextColumn get emergencyContact => text()();
  IntColumn get agreementPeriod => integer()();
  TextColumn get aadharImages => text().map(const StringListConverter()).withDefault(const Constant('[]'))();
  BoolColumn get agreementDone => boolean()();
  RealColumn get rentPerMonth => real()();
  RealColumn get advancePayment => real()();
  RealColumn get totalDueAmount => real()();
  DateTimeColumn get monthEntered => dateTime()();
  DateTimeColumn get monthExit => dateTime().nullable()();
  RealColumn get meterReadingInitial => real()();
  RealColumn get meterReadingFinal => real().nullable()();
  RealColumn get electricityRate => real()();
  RealColumn get waterCharges => real()();
  RealColumn get perYearIncrement => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {tenantID};
  @override
  String get tableName => 'tenant';
}
