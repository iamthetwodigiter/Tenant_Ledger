import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/services/pdf_service.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/util/toast.dart';
import 'package:tenant_ledger/util/util_methods.dart';
import 'package:tenant_ledger/view/rent/add_rent_page.dart';

class RentDetailsPage extends ConsumerStatefulWidget {
  final int rentID;
  const RentDetailsPage({super.key, required this.rentID});

  @override
  ConsumerState<RentDetailsPage> createState() => _RentDetailsPageState();
}

class _RentDetailsPageState extends ConsumerState<RentDetailsPage> {
  final PdfService _pdfService = PdfService();

  void _confirmDeleteRent(RentData rent, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Rent Record',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryRed,
          ),
        ),
        content: Text(
          "Are you sure you want to delete records of '${formatDate(rent.rentMonth)}'?",
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

  @override
  Widget build(BuildContext context) {
    final rentAsyncValue = ref.watch(rentByIdProvider(widget.rentID));
    final rentDao = ref.watch(rentDaoProvider);
    final tenantDao = ref.watch(tenantDaoProvider);
    final ownerDao = ref.watch(ownerDaoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rent Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
              rentAsyncValue.whenData((rentData) {
                if (rentData != null) {
                  _confirmDeleteRent(rentData, () {
                    rentDao.deleteRent(rentData.rentID);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: rentAsyncValue.when(
        data: (rent) {
          if (rent == null) {
            return Center(child: Text('Rent record not found'));
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Card
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 24),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          rent.rentPaid
                              ? Colors.green.shade400
                              : AppTheme.primaryRed.withValues(alpha: 0.8),
                          rent.rentPaid
                              ? Colors.green.shade600
                              : AppTheme.primaryRed,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: (rent.rentPaid
                              ? Colors.green.shade200
                              : AppTheme.primaryRed.withValues(alpha: 0.3)),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDate(rent.rentMonth),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                rent.rentPaid ? 'PAID' : 'UNPAID',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '₹${rent.totalRentForMonth.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (rent.totalDueAmount > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Due Amount',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '₹${rent.totalDueAmount.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        if (rent.amountPaidOn != null) ...[
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white.withValues(alpha: 0.8),
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Paid on: ${formatDate(rent.amountPaidOn!)}',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Electricity Section
                  _buildSectionCard(
                    title: 'Electricity Details',
                    icon: Icons.bolt,
                    children: [
                      _infoRow(
                        'This Month Meter Reading',
                        '${rent.meterReadingThisMonth} units',
                      ),
                      _infoRow(
                        'Last Month Meter Reading',
                        '${rent.meterReadingLastMonth} units',
                      ),
                      _infoRow(
                        'Units Consumed',
                        '${(rent.meterReadingThisMonth - rent.meterReadingLastMonth).toStringAsFixed(1)} units',
                        valueColor: AppTheme.primaryColor,
                        valueBold: true,
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  FutureBuilder<TenantData?>(
                    future: tenantDao.getTenantByID(rent.tenantID),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppTheme.primaryColor,
                          ),
                        );
                      }

                      final tenant = snapshot.data;
                      if (tenant == null) {
                        return Center(
                          child: Text(
                            'Tenant details not available',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }

                      final unitsConsumed =
                          rent.meterReadingThisMonth -
                          rent.meterReadingLastMonth;
                      final electricityBill =
                          unitsConsumed * tenant.electricityRate;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tenant Info
                          _buildSectionCard(
                            title: 'Tenant Information',
                            icon: Icons.person,
                            children: [
                              _infoRow('Name', tenant.name),
                              _infoRow('Phone', tenant.mobileNo),
                              _infoRow(
                                'Electricity Rate',
                                '₹${tenant.electricityRate}/unit',
                              ),
                              _infoRow(
                                'Electricity Bill',
                                '₹${electricityBill.toStringAsFixed(2)}',
                                valueColor: AppTheme.primaryColor,
                                valueBold: true,
                              ),
                            ],
                          ),

                          SizedBox(height: 16),

                          // Rent Breakdown
                          _buildSectionCard(
                            title: 'Rent Breakdown',
                            icon: Icons.receipt_long,
                            children: [
                              _breakdownItem(
                                'Base Monthly Rent',
                                '₹${tenant.rentPerMonth}',
                              ),
                              _breakdownItem(
                                'Water Charges',
                                '₹${tenant.waterCharges}',
                              ),
                              Divider(height: 16, thickness: 0.5),
                              _breakdownItem(
                                'Electricity Usage',
                                '${(rent.meterReadingThisMonth - rent.meterReadingLastMonth).toStringAsFixed(1)} units',
                              ),
                              _breakdownItem(
                                'Electricity Rate',
                                '₹${tenant.electricityRate}/unit',
                              ),
                              _breakdownItem(
                                'Electricity Bill',
                                '₹${electricityBill.toStringAsFixed(2)}',
                              ),
                              Divider(height: 16, thickness: 0.5),
                              _breakdownItem(
                                'Previous Due Amount',
                                '₹${rent.totalDueAmount}',
                                textColor: rent.totalDueAmount > 0
                                    ? AppTheme.primaryRed
                                    : null,
                              ),
                              Divider(height: 16, thickness: 1),
                              _breakdownItem(
                                'Total Amount',
                                '₹${rent.totalRentForMonth}',
                                isBold: true,
                              ),
                              if (rent.totalDueAmount > 0)
                                _breakdownItem(
                                  'Remaining Due',
                                  '₹${rent.totalDueAmount}',
                                  textColor: AppTheme.primaryRed,
                                  isBold: true,
                                ),
                              if (rent.totalDueAmount == 0 && rent.rentPaid)
                                _breakdownItem(
                                  'Status',
                                  'PAID',
                                  textColor: Colors.green.shade700,
                                  isBold: true,
                                ),
                            ],
                          ),

                          SizedBox(height: 16),

                          // Payment Info
                          _buildSectionCard(
                            title: 'Payment Information',
                            icon: Icons.payment,
                            children: [
                              _infoRow(
                                'Payment Mode',
                                rent.paymentMode?.toUpperCase() ?? 'Not Paid Yet',
                                valueColor: rent.paymentMode != null
                                    ? null
                                    : AppTheme.primaryRed,
                              ),
                              _infoRow('Month', formatDate(rent.rentMonth)),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 16),

                  // Document Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final tenant = await tenantDao.getTenantByID(
                              rentAsyncValue.value!.tenantID,
                            );
                            final owner = await ownerDao.getAllOwners();
                            if (owner.isEmpty) {
                              Toast(
                                context: context,
                                title: 'No Owner Data found',
                                description:
                                    'Add an owner first to generate invoice',
                              );
                              return;
                            }
                            final file = await _pdfService.generateRentInvoice(
                              rent,
                              tenant!,
                              owner.first,
                            );
                            _pdfService.openPDF(file);
                          },
                          icon: Icon(
                            Icons.receipt_long,
                            size: 20,
                            color: AppTheme.primaryWhite,
                          ),
                          label: Text(
                            'Generate Invoice',
                            style: TextStyle(color: AppTheme.primaryWhite),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor.withValues(
                              alpha: 0.8,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: rent.rentPaid
                              ? () async {
                                  final tenant = await tenantDao.getTenantByID(
                                    rentAsyncValue.value!.tenantID,
                                  );
                                  final owner = await ownerDao.getAllOwners();
                                  if (owner.isEmpty) {
                                    Toast(
                                      context: context,
                                      title: 'No Owner Data found',
                                      description:
                                          'Add an owner first to generate invoice',
                                    );
                                    return;
                                  }
                                  final file = await _pdfService
                                      .generatePaymentReceipt(
                                        rent,
                                        tenant!,
                                        owner.first,
                                      );
                                  _pdfService.openPDF(file);
                                }
                              : null,
                          icon: Icon(
                            Icons.payment,
                            size: 20,
                            color: AppTheme.primaryWhite,
                          ),
                          label: Text(
                            'Payment Receipt',
                            style: TextStyle(color: AppTheme.primaryWhite),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Share Actions
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final tenant = await tenantDao.getTenantByID(
                              rentAsyncValue.value!.tenantID,
                            );
                            final owner = await ownerDao.getAllOwners();
                            if (owner.isEmpty) {
                              Toast(
                                context: context,
                                title: 'No Owner Data found',
                                description:
                                    'Add an owner first to generate invoice',
                              );
                              return;
                            }
                            final file = await _pdfService.generateRentInvoice(
                              rent,
                              tenant!,
                              owner.first,
                            );
                            _pdfService.sharePDF(
                              file,
                              'Rent Invoice for ${tenant.name}',
                            );
                          },
                          icon: Icon(
                            Icons.share,
                            size: 20,
                            color: AppTheme.primaryColor,
                          ),
                          label: Text(
                            'Share Invoice',
                            style: TextStyle(color: AppTheme.primaryColor),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: rent.rentPaid
                              ? () async {
                                  final tenant = await tenantDao.getTenantByID(
                                    rentAsyncValue.value!.tenantID,
                                  );
                                  final owner = await ownerDao.getAllOwners();

                                  if (owner.isEmpty) {
                                    Toast(
                                      context: context,
                                      title: 'No Owner Data found',
                                      description:
                                          'Add an owner first to generate invoice',
                                    );
                                    return;
                                  }
                                  final file = await _pdfService
                                      .generatePaymentReceipt(
                                        rent,
                                        tenant!,
                                        owner.first,
                                      );
                                  _pdfService.sharePDF(
                                    file,
                                    'Payment Receipt for ${tenant.name}',
                                  );
                                }
                              : null,
                          icon: Icon(
                            Icons.share,
                            size: 20,
                            color: rent.rentPaid
                                ? AppTheme.primaryColor
                                : Colors.grey,
                          ),
                          label: Text(
                            'Share Receipt',
                            style: TextStyle(
                              color: rent.rentPaid
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Update Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddRentPage(rent: rent),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: AppTheme.primaryWhite,
                      ),
                      label: Text(
                        'Update Rent',
                        style: TextStyle(
                          color: AppTheme.primaryWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppTheme.primaryColor),
              SizedBox(height: 16),
              Text(
                'Loading rent details...',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppTheme.primaryRed),
              SizedBox(height: 16),
              Text(
                'Error loading rent details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryRed,
                ),
              ),
              SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
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
          // Section Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppTheme.primaryColor, size: 20),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // Section Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value, {
    Color? valueColor,
    bool valueBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: valueColor ?? AppTheme.primaryBlack,
                fontWeight: valueBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakdownItem(
    String label,
    String amount, {
    bool isBold = false,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: textColor ?? Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
