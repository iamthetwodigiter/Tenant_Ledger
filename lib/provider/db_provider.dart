import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_ledger/dao/owner_dao.dart';
import 'package:tenant_ledger/dao/rent_dao.dart';
import 'package:tenant_ledger/dao/tenant_dao.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/util/scheduler.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final tenantDaoProvider = Provider<TenantDao>((ref) {
  final db = ref.watch(databaseProvider);
  return TenantDao(db);
});

final tenantsProvider = StreamProvider((ref) {
  final tenantDao = ref.watch(tenantDaoProvider);
  return tenantDao.watchAllTenants();
});

final rentDaoProvider = Provider<RentDao>((ref) {
  final db = ref.watch(databaseProvider);
  return RentDao(db);
});

final rentsProvider = StreamProvider((ref) {
  final rentDao = ref.watch(rentDaoProvider);
  return rentDao.watchAllRents();
});

final ownerDaoProvider = Provider<OwnerDao>((ref) {
  final db = ref.watch(databaseProvider);
  return OwnerDao(db);
});

final allOwnersProvider = StreamProvider<List<OwnerData>>((ref) {
  return ref.watch(ownerDaoProvider).watchAllOwners();
});

final tenantByIdProvider = StreamProvider.family<TenantData?, int>((ref, id) {
  final tenantDao = ref.watch(tenantDaoProvider);
  return tenantDao.watchTenantByID(id);
});

final rentByIdProvider = StreamProvider.family<RentData?, int>((ref, id) {
  final rentDao = ref.watch(rentDaoProvider);
  return rentDao.watchRentByID(id);
});

final scheduleTaskProvider = Provider<Scheduler>((ref) {
  return Scheduler(ref);
});
