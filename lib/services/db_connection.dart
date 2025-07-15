import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tenant_ledger/model/owner.dart';
import 'package:tenant_ledger/model/rent.dart';
import 'package:tenant_ledger/model/tenant.dart';

part 'db_connection.g.dart';

@DriftDatabase(tables: [Rent, Tenant, Owner])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());


  @override
  int get schemaVersion => 1;
  
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'tenant_ledger',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}