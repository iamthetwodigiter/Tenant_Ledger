import 'package:drift/drift.dart';
import 'package:tenant_ledger/model/owner.dart';
import 'package:tenant_ledger/services/db_connection.dart';

part 'owner_dao.g.dart';

@DriftAccessor(tables: [Owner])
class OwnerDao extends DatabaseAccessor<AppDatabase> with _$OwnerDaoMixin {
  OwnerDao(super.db);

  Future<List<OwnerData>> getAllOwners() => select(owner).get();
  Stream<List<OwnerData>> watchAllOwners() => select(owner).watch();

  Future<int> insertOwner(OwnerCompanion ownerData) {
    return into(owner).insert(ownerData);
  }

  Future<bool> updateOwner(OwnerCompanion ownerData) {
    return update(owner).replace(ownerData);
  }

  Future<int> deleteOwner(int id) =>
      (delete(owner)..where((tbl) => tbl.ownerID.equals(id))).go();

  Future<OwnerData?> getOwnerById(int id) {
    return (select(
      owner,
    )..where((tbl) => tbl.ownerID.equals(id))).getSingleOrNull();
  }

  Stream<OwnerData?> watchOwnerByID(int id) {
    return (select(
      owner,
    )..where((tbl) => tbl.ownerID.equals(id))).watchSingleOrNull();
  }
}
