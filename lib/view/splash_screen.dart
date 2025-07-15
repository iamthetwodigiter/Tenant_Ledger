import 'package:flutter/material.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/view/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 5),
              Image.asset('assets/images/logo.png', height: 150),
              Spacer(flex: 6),
              CircularProgressIndicator.adaptive(),
              Spacer(flex: 6),
              Text(
                'Made with ❤️  by',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFPro',
                ),
              ),
              Text(
                'thetwodigiter',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFPro',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
