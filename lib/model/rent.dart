import 'package:drift/drift.dart';
import 'package:tenant_ledger/model/tenant.dart';

class Rent extends Table {
  IntColumn get rentID => integer().autoIncrement()();
  IntColumn get tenantID =>
      integer().references(Tenant, #tenantID)();
  RealColumn get rentPerMonth => real().references(Tenant, #rentPerMonth)();
  RealColumn get electricityRate => real().references(Tenant, #electricityRate)();
  BoolColumn get rentPaid => boolean().withDefault(const Constant(false))();
  RealColumn get currentDueAmount => real().withDefault(const Constant(0.0))();
  RealColumn get totalDueAmount => real().references(Tenant, #totalDueAmount)();
  DateTimeColumn get amountPaidOn => dateTime().nullable()();
  RealColumn get meterReadingLastMonth => real()();
  RealColumn get meterReadingThisMonth => real()();
  TextColumn get paymentMode => text().nullable()();
  RealColumn get totalRentForMonth => real()();
  DateTimeColumn get rentMonth => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {rentID};
  @override
  String get tableName => 'rent';
}