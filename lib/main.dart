import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/notification.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().initialize();

  final container = ProviderContainer();

  await container.read(scheduleTaskProvider).generateMonthlyReport();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    UncontrolledProviderScope(container: container, child: TenantLedger()),
  );
}

class TenantLedger extends StatefulWidget {
  const TenantLedger({super.key});

  @override
  State<TenantLedger> createState() => _TenantLedgerState();
}

class _TenantLedgerState extends State<TenantLedger> {
  @override
  void initState() {
    super.initState();
    _requestNotification();
  }

  void _requestNotification() async {
    if (await Permission.notification.status.isDenied) {
      await Permission.notification.request();
    }

    if(await Permission.storage.status.isDenied) {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      await getExternalStorageDirectories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
