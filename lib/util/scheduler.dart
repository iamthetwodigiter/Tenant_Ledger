import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/services/notification.dart';

class Scheduler {
  final Ref ref;
  Scheduler(this.ref);
  final NotificationService _notificationService = NotificationService();

  Future<void> generateMonthlyReport() async {
    final today = DateTime.now();

    if (today.day == 1) {
      final tenantDao = ref.read(tenantDaoProvider);
      final rentDao = ref.read(rentDaoProvider);

      final tenants = await tenantDao.getAllTenants();

      for (final tenant in tenants) {
        final lastUnpaidRentRecord = await rentDao.getLastUnpaidRentForTenant(
          tenant.tenantID,
        );
        final lastMeterReading =
            lastUnpaidRentRecord?.meterReadingThisMonth ??
            tenant.meterReadingInitial;

        if (lastUnpaidRentRecord == null) {
          continue;
        }
        double totalDue = 0;
        double totalBill = 0;

        if (lastUnpaidRentRecord.rentPaid == false) {
          totalDue += lastUnpaidRentRecord.totalDueAmount;
        }

        totalBill += totalDue + tenant.rentPerMonth;

        final newRent = RentCompanion(
          tenantID: Value(tenant.tenantID),
          rentPerMonth: Value(tenant.rentPerMonth),
          electricityRate: Value(tenant.electricityRate),
          rentPaid: Value(false),
          currentDueAmount: Value(0),
          totalDueAmount: Value(totalDue),
          meterReadingLastMonth: Value(lastMeterReading),
          meterReadingThisMonth: Value(lastMeterReading),
          totalRentForMonth: Value(totalBill),
          rentMonth: Value(DateTime(today.year, today.month)),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        );
        await rentDao.insertRent(newRent);
        _notificationService.showNotification(
          title: 'Monthly Rent Record',
          body:
              'Rent Record for ${tenant.name} has been generated for ${today.month}/${today.year}.',
        );
      }
    }
  }
}
