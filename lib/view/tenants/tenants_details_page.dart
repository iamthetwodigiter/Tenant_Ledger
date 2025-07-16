import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/util/toast.dart';
import 'package:tenant_ledger/util/util_methods.dart';
import 'package:tenant_ledger/view/tenants/add_tenants_page.dart';
import 'package:url_launcher/url_launcher.dart';

class TenantsDetailsPage extends ConsumerStatefulWidget {
  final TenantData tenant;
  const TenantsDetailsPage({super.key, required this.tenant});

  @override
  ConsumerState<TenantsDetailsPage> createState() => _TenantsDetailsPageState();
}

class _TenantsDetailsPageState extends ConsumerState<TenantsDetailsPage> {
  void _callTenant(String phoneNumber) async {
    try {
      await launchUrl(Uri.parse('tel:+91$phoneNumber'));
    } catch (e) {
      if (mounted) {
        Toast(
          context: context,
          title: 'Error',
          description: 'Failed to make call: $e',
        );
      }
    }
  }

  Widget _detailTile({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          color: valueColor ?? AppTheme.primaryBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (trailing != null) trailing,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteTenant(TenantData tenant, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Tenant',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryRed,
          ),
        ),
        content: Text(
          "Are you sure you want to delete all the records of '${tenant.name}'?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Delete',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _viewFullImage(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text('Aadhar Image', style: TextStyle(color: Colors.white)),
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 4,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tenantDao = ref.watch(tenantDaoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tenant Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              _confirmDeleteTenant(widget.tenant, () {
                tenantDao.deleteTenant(widget.tenant.tenantID);
                Navigator.popUntil(context, (route) => route.isFirst);
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              // Profile Card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: AppTheme.primaryWhite,
                      child: Text(
                        widget.tenant.name.isNotEmpty
                            ? widget.tenant.name[0].toUpperCase()
                            : '',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.tenant.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {
                        _callTenant(widget.tenant.mobileNo);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.phone_android,
                              color: AppTheme.primaryWhite,
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              widget.tenant.mobileNo,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.primaryWhite,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    // Status Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatusBadge(
                          widget.tenant.agreementDone
                              ? 'Agreement Done'
                              : 'Agreement Pending',
                          widget.tenant.agreementDone
                              ? Colors.green
                              : Colors.orange,
                        ),
                        SizedBox(width: 8),
                        _buildStatusBadge(
                          widget.tenant.totalDueAmount > 0
                              ? 'Has Due'
                              : 'No Dues',
                          widget.tenant.totalDueAmount > 0
                              ? AppTheme.primaryRed
                              : Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Aadhar Images Section
              if (widget.tenant.aadharImages.isNotEmpty)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.image, color: AppTheme.primaryColor),
                          SizedBox(width: 8),
                          Text(
                            'Aadhar Images',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.tenant.aadharImages.length,
                          itemBuilder: (context, index) {
                            final imagePath = widget.tenant.aadharImages[index];
                            return GestureDetector(
                              onTap: () => _viewFullImage(context, imagePath),
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppTheme.primaryColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(File(imagePath)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 16),

              // Details Card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: AppTheme.primaryColor),
                          SizedBox(width: 8),
                          Text(
                            'Basic Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 1),

                    // Details List
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailTile(
                            icon: Icons.credit_card,
                            label: 'Aadhar Number',
                            value: widget.tenant.aadharNo,
                          ),
                          _detailTile(
                            icon: Icons.home,
                            label: 'Permanent Address',
                            value: widget.tenant.permanentAddress,
                          ),
                          _detailTile(
                            icon: Icons.phone,
                            label: 'Emergency Contact',
                            value: widget.tenant.emergencyContact,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Agreement Card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.description, color: AppTheme.primaryColor),
                          SizedBox(width: 8),
                          Text(
                            'Agreement Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 1),

                    // Agreement Details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailTile(
                            icon: Icons.calendar_today,
                            label: 'Agreement Period',
                            value: '${widget.tenant.agreementPeriod} months',
                          ),
                          _detailTile(
                            icon: Icons.calendar_month,
                            label: 'Month Entered',
                            value: formatDate(widget.tenant.monthEntered),
                          ),
                          _detailTile(
                            icon: Icons.exit_to_app,
                            label: 'Month Exit',
                            value: widget.tenant.monthExit != null
                                ? formatDate(widget.tenant.monthExit!)
                                : 'Not Exited',
                            valueColor: widget.tenant.monthExit != null
                                ? AppTheme.primaryRed
                                : Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Financial Card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Financial Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 1),

                    // Financial Details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailTile(
                            icon: Icons.attach_money,
                            label: 'Rent Per Month',
                            value:
                                '₹${widget.tenant.rentPerMonth.toStringAsFixed(0)}',
                          ),
                          _detailTile(
                            icon: Icons.money,
                            label: 'Advance Payment',
                            value:
                                '₹${widget.tenant.advancePayment.toStringAsFixed(0)}',
                          ),
                          _detailTile(
                            icon: Icons.warning,
                            label: 'Due Amount',
                            value:
                                '₹${widget.tenant.totalDueAmount.toStringAsFixed(0)}',
                            valueColor: widget.tenant.totalDueAmount > 0
                                ? AppTheme.primaryRed
                                : Colors.green.shade600,
                            trailing: widget.tenant.totalDueAmount > 0
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryRed.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Due',
                                      style: TextStyle(
                                        color: AppTheme.primaryRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          _detailTile(
                            icon: Icons.trending_up,
                            label: 'Per Year Increment',
                            value:
                                '${widget.tenant.perYearIncrement.toStringAsFixed(1)}% p.a.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Utilities Card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.electric_bolt,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Utility Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 1),

                    // Utility Details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailTile(
                            icon: Icons.electric_meter,
                            label: 'Meter Reading Initial',
                            value: widget.tenant.meterReadingInitial
                                .toStringAsFixed(1),
                          ),
                          if (widget.tenant.meterReadingFinal != null)
                            _detailTile(
                              icon: Icons.electric_meter,
                              label: 'Meter Reading Final',
                              value: widget.tenant.meterReadingFinal!
                                  .toStringAsFixed(1),
                            ),
                          _detailTile(
                            icon: Icons.flash_on,
                            label: 'Electricity Rate',
                            value:
                                '₹${widget.tenant.electricityRate.toStringAsFixed(1)}/unit',
                          ),
                          _detailTile(
                            icon: Icons.water_drop,
                            label: 'Water Charges',
                            value:
                                '₹${widget.tenant.waterCharges.toStringAsFixed(0)}/month',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),

              // Update Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text(
                    'Update Tenant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddTenantsPage(tenant: widget.tenant),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
