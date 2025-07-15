import 'package:drift/drift.dart';
import 'package:tenant_ledger/model/tenant.dart';
import 'package:tenant_ledger/services/db_connection.dart';

part 'tenant_dao.g.dart';

@DriftAccessor(tables: [Tenant])
class TenantDao extends DatabaseAccessor<AppDatabase> with _$TenantDaoMixin {
  TenantDao(super.db);

  Future<List<TenantData>> getAllTenants() => select(tenant).get();

  Stream<List<TenantData>> watchAllTenants() => select(tenant).watch();

  Future<int> insertTenant(TenantCompanion tenantCompanion) {
    return into(tenant).insert(tenantCompanion);
  }

  Future<bool> updateTenant(TenantCompanion tenantData) {
    return update(tenant).replace(tenantData);
  }

  Future<int> deleteTenant(int id) {
    return (delete(tenant)..where((t) => t.tenantID.equals(id))).go();
  }

  Future<TenantData?> getTenantByID(int id) {
    return (select(tenant)..where((t) => t.tenantID.equals(id))).getSingleOrNull();
  }

  Stream<TenantData?> watchTenantByID(int id) {
    return (select(tenant)..where((t) => t.tenantID.equals(id))).watchSingleOrNull();
  }
}
