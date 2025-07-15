import 'package:drift/drift.dart';
import 'package:tenant_ledger/model/rent.dart';
import 'package:tenant_ledger/services/db_connection.dart';

part 'rent_dao.g.dart';

@DriftAccessor(tables: [Rent])
class RentDao extends DatabaseAccessor<AppDatabase> with _$RentDaoMixin {
  RentDao(super.db);

  Future<List<RentData>> getAllRents() => select(rent).get();

  Stream<List<RentData>> watchAllRents() => select(rent).watch();

  Future<int> insertRent(RentCompanion rentData) {
    return into(rent).insert(rentData);
  }

  Future<bool> updateRent(RentCompanion rentData) {
    return update(rent).replace(rentData);
  }

  Future<int> deleteRent(int id) =>
      (delete(rent)..where((tbl) => tbl.rentID.equals(id))).go();

  Future<RentData?> getRentById(int id) {
    return (select(
      rent,
    )..where((tbl) => tbl.rentID.equals(id))).getSingleOrNull();
  }

  Future<List<RentData>> getRentsByTenantId(int tenantID) {
    return (select(rent)..where((tbl) => tbl.tenantID.equals(tenantID))).get();
  }

  Stream<RentData?> watchRentByID(int id) {
    return (select(
      rent,
    )..where((tbl) => tbl.rentID.equals(id))).watchSingleOrNull();
  }

  Future<List<RentData>> getRentsForTenant(int tenantID) {
    return (select(rent)
          ..where((tbl) => tbl.tenantID.equals(tenantID))
          ..orderBy([(table) => OrderingTerm.desc(table.rentMonth)]))
        .get();
  }

  Future<RentData?> getLastUnpaidRentForTenant(int tenantID) {
    return (select(rent)
          ..where(
            (tbl) => tbl.tenantID.equals(tenantID) & tbl.rentPaid.equals(false),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.rentMonth)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<RentData?> getRentByMonthAndTenant(int tenantID, DateTime month) {
    return (select(rent)..where(
          (tbl) =>
              tbl.tenantID.equals(tenantID) &
              tbl.rentMonth.equals(DateTime(month.year, month.month)),
        ))
        .getSingleOrNull();
  }

  Future<List<RentData>> getUnpaidRentsForTenant(int tenantID) {
    return (select(rent)
          ..where(
            (tbl) => tbl.tenantID.equals(tenantID) & tbl.rentPaid.equals(false),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.rentMonth)]))
        .get();
  }

  Future<double> getTotalDueAmount(int tenantID) async {
    final rents =
        await (select(rent)
              ..where((table) => table.tenantID.equals(tenantID))
              ..orderBy([(table) => OrderingTerm.desc(table.rentMonth)])
              ..limit(1))
            .get();

    return rents.isNotEmpty ? rents.first.totalDueAmount : 0.0;
  }

  Future<void> addUnpaidAmountToTotalDue(
    int tenantID,
    double totalUnpaid,
  ) async {
    await (update(rent)..where((tbl) => tbl.tenantID.equals(tenantID))).write(
      RentCompanion(totalDueAmount: Value(totalUnpaid)),
    );
  }
}
