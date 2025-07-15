import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/view/owner/owner_details_page.dart';
import 'package:tenant_ledger/view/rent/rent_page.dart';
import 'package:tenant_ledger/view/tenants/tenants_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [TenantsPage(), RentPage(), OwnerDetailsPage()],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SalomonBottomBar(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.primaryBlack,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.business),
              title: Text('Tenants'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.attach_money),
              title: Text('Rent'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text('Owners'),
            ),
          ],
        ),
      ),
    );
  }
}
