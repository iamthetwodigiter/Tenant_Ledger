import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/util/util_methods.dart';
import 'package:tenant_ledger/view/rent/add_rent_page.dart';
import 'package:tenant_ledger/view/rent/rent_details_page.dart';

class RentPage extends ConsumerStatefulWidget {
  const RentPage({super.key});

  @override
  ConsumerState<RentPage> createState() => _RentPageState();
}

class _RentPageState extends ConsumerState<RentPage> {
  bool _groupByTenant = false;

  Widget _buildChronologicalList(List<RentData> rents) {
    final sortedRents = [...rents]
      ..sort((a, b) => b.rentMonth.compareTo(a.rentMonth));

    return ListView.builder(
      itemCount: sortedRents.length,
      itemBuilder: (context, index) {
        final rent = sortedRents[index];
        return _buildRentListItem(rent);
      },
    );
  }

  Widget _buildTenantGroupedList(List<RentData> rents) {
    final Map<int, List<RentData>> tenantGroups = {};

    for (var rent in rents) {
      if (!tenantGroups.containsKey(rent.tenantID)) {
        tenantGroups[rent.tenantID] = [];
      }
      tenantGroups[rent.tenantID]!.add(rent);
    }

    return ListView.builder(
      itemCount: tenantGroups.length,
      itemBuilder: (context, index) {
        final tenantId = tenantGroups.keys.elementAt(index);
        final tenantRents = tenantGroups[tenantId]!
          ..sort((a, b) => b.rentMonth.compareTo(a.rentMonth));

        final tenantAsyncValue = ref.watch(tenantByIdProvider(tenantId));

        return tenantAsyncValue.when(
          data: (tenant) {
            return ExpansionTile(
              initiallyExpanded: tenantRents.any((rent) => !rent.rentPaid),
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor,
                child: Text(
                  tenant?.name.isNotEmpty == true
                      ? tenant!.name[0].toUpperCase()
                      : 'T',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                tenant?.name ?? 'Tenant ID: $tenantId',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              subtitle: Text(
                '${tenantRents.length} rent records',
                style: TextStyle(fontSize: 12),
              ),
              trailing: tenantRents.any((rent) => !rent.rentPaid)
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.primaryRed.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        'Has unpaid rent',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
              children: tenantRents
                  .map((rent) => _buildRentListItem(rent))
                  .toList(),
            );
          },
          loading: () => ListTile(title: Text('Loading...')),
          error: (_, __) => ListTile(title: Text('Error loading tenant')),
        );
      },
    );
  }

  Widget _buildRentListItem(RentData rent) {
    final rentMonth = formatDate(rent.rentMonth);
    final isPaid = rent.rentPaid;
    final paidDate = rent.amountPaidOn != null
        ? formatDate(rent.amountPaidOn!)
        : 'Not paid';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isPaid
                ? Colors.transparent
                : AppTheme.primaryRed.withValues(alpha: 0.5),
            width: isPaid ? 0 : 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RentDetailsPage(rentID: rent.rentID),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            rentMonth,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPaid
                            ? Colors.green.shade50
                            : AppTheme.primaryRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPaid ? Icons.check_circle : Icons.cancel,
                            size: 16,
                            color: isPaid ? Colors.green : AppTheme.primaryRed,
                          ),
                          SizedBox(width: 4),
                          Text(
                            isPaid ? 'PAID' : 'UNPAID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: isPaid
                                  ? Colors.green
                                  : AppTheme.primaryRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(
                            icon: Icons.payments_outlined,
                            label: 'Rent',
                            value: '₹${rent.rentPerMonth.toStringAsFixed(0)}',
                          ),
                          SizedBox(height: 6),
                          _infoRow(
                            icon: Icons.electric_bolt,
                            label: 'Electricity',
                            value:
                                '${(rent.meterReadingThisMonth - rent.meterReadingLastMonth).toStringAsFixed(1)} units',
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(
                          icon: Icons.account_balance_wallet,
                          label: 'Total Bill',
                          value:
                              '₹${rent.totalRentForMonth.toStringAsFixed(0)}',
                          valueColor: AppTheme.primaryColor,
                          valueBold: true,
                        ),
                        SizedBox(height: 6),
                        _infoRow(
                          icon: Icons.warning_amber,
                          label: 'Due',
                          value: '₹${rent.totalDueAmount.toStringAsFixed(0)}',
                          valueColor: rent.totalDueAmount > 0
                              ? AppTheme.primaryRed
                              : Colors.grey.shade700,
                          valueBold: rent.totalDueAmount > 0,
                        ),
                      ],
                    ),
                  ],
                ),
                if (isPaid) ...[
                  Divider(height: 16),
                  _infoRow(
                    icon: Icons.event,
                    label: 'Paid on',
                    value: paidDate,
                    valueColor: Colors.green.shade700,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    bool valueBold = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.grey.shade600),
        SizedBox(width: 4),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: valueBold ? FontWeight.bold : FontWeight.normal,
            color: valueColor ?? Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final rentsAsyncValue = ref.watch(rentsProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Rent Management',
          style: TextStyle(
            color: AppTheme.primaryWhite,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildViewToggleButton(
                  title: 'All Records',
                  isSelected: !_groupByTenant,
                  onTap: () => setState(() => _groupByTenant = false),
                ),
                _buildViewToggleButton(
                  title: 'By Tenant',
                  isSelected: _groupByTenant,
                  onTap: () => setState(() => _groupByTenant = true),
                ),
              ],
            ),
          ),
          Expanded(
            child: rentsAsyncValue.when(
              data: (rents) {
                if (rents.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 80,
                          color: AppTheme.primaryColor.withValues(alpha: 0.5),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No rent records found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap the + button to add your first rent record',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (_groupByTenant) {
                  return _buildTenantGroupedList(rents);
                } else {
                  return _buildChronologicalList(rents);
                }
              },
              loading: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading rent records...',
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
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: AppTheme.primaryRed,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryRed,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRentPage()),
          );
        },
        elevation: 4,
        shape: CircleBorder(),
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.attach_money, size: 30, color: AppTheme.primaryWhite),
      ),
    );
  }

  Widget _buildViewToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? AppTheme.primaryWhite : AppTheme.primaryBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
