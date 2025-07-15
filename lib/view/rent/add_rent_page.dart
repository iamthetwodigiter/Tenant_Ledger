import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/services/pdf_service.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/util/toast.dart';
import 'package:tenant_ledger/util/util_methods.dart';
import 'package:toastification/toastification.dart';

class AddRentPage extends ConsumerStatefulWidget {
  final RentData? rent;
  const AddRentPage({super.key, this.rent});

  @override
  ConsumerState<AddRentPage> createState() => _AddRentPageState();
}

class _AddRentPageState extends ConsumerState<AddRentPage> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedTenantId;
  bool _rentPaid = false;
  DateTime? _amountPaidOn;
  String? _paymentMode = 'cash';
  DateTime _rentMonth = DateTime.now();

  late final TextEditingController _currentDueController;
  late final TextEditingController _totalDueAmountController;
  late final TextEditingController _meterLastController;
  late final TextEditingController _meterThisController;
  late final TextEditingController _totalRentController;

  final PdfService _pdfService = PdfService();

  @override
  void initState() {
    super.initState();
    _currentDueController = TextEditingController();
    _totalDueAmountController = TextEditingController();
    _meterLastController = TextEditingController();
    _meterThisController = TextEditingController();
    _totalRentController = TextEditingController();

    if (widget.rent != null) {
      _selectedTenantId = widget.rent!.tenantID;
      _rentPaid = widget.rent!.rentPaid;
      _amountPaidOn = widget.rent!.amountPaidOn;
      _paymentMode = widget.rent!.paymentMode;
      _rentMonth = widget.rent!.rentMonth;

      _currentDueController.text = widget.rent!.currentDueAmount.toString();
      _totalDueAmountController.text = widget.rent!.totalDueAmount.toString();
      _meterLastController.text = widget.rent!.meterReadingLastMonth.toString();
      _meterThisController.text = widget.rent!.meterReadingThisMonth.toString();
      _totalRentController.text = widget.rent!.totalRentForMonth.toString();
    }
  }

  @override
  void dispose() {
    _currentDueController.dispose();
    _totalDueAmountController.dispose();
    _meterLastController.dispose();
    _meterThisController.dispose();
    _totalRentController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
    int? maxLength,
    bool enabled = true,
    Function(String)? onChanged,
    IconData? prefixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        cursorColor: AppTheme.primaryColor,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          labelStyle: TextStyle(
            color: AppTheme.primaryBlack.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppTheme.primaryColor, size: 20)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primaryRed),
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          fillColor: enabled ? Colors.transparent : Colors.grey.shade50,
          filled: !enabled,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: enabled,
        onChanged: onChanged,
        style: TextStyle(
          color: enabled ? AppTheme.primaryBlack : Colors.grey.shade700,
        ),
      ),
    );
  }

  Future<void> _fetchLastRentAndTenant(int tenantId) async {
    final tenantDao = ref.read(tenantDaoProvider);
    final rentDao = ref.read(rentDaoProvider);

    final tenant = await tenantDao.getTenantByID(tenantId);
    if (tenant == null) return;

    final lastUnpaidRent = await rentDao.getLastUnpaidRentForTenant(tenantId);

    double totalDue = tenant.totalDueAmount;
    _totalDueAmountController.text = totalDue.toString();

    if (lastUnpaidRent != null) {
      _meterLastController.text = lastUnpaidRent.meterReadingThisMonth
          .toString();
    } else {
      _meterLastController.text = tenant.meterReadingInitial.toString();
    }
    _calculateTotalRent(tenant);
  }

  void _calculateTotalRent(TenantData tenant) {
    double lastReading = double.tryParse(_meterLastController.text) ?? 0.0;
    double thisReading = double.tryParse(_meterThisController.text) ?? 0.0;
    double unitsConsumed = thisReading - lastReading;
    if (unitsConsumed < 0) unitsConsumed = 0;
    double electricityBill = unitsConsumed * tenant.electricityRate;

    double totalDue = double.tryParse(_totalDueAmountController.text) ?? 0.0;
    double currentDue = double.tryParse(_currentDueController.text) ?? 0.0;
    double currentMonthBill =
        tenant.rentPerMonth + electricityBill + totalDue - currentDue;

    setState(() {
      _totalRentController.text = currentMonthBill.toString();
    });
  }

  Future<void> _saveRent() async {
    if (!_formKey.currentState!.validate() || _selectedTenantId == null) {
      Toast(
        context: context,
        title: 'Validation Error',
        description: 'Please fill all the required fields.',
        type: ToastificationType.error,
      );
      return;
    }

    try {
      final rentDao = ref.read(rentDaoProvider);
      final tenantDao = ref.read(tenantDaoProvider);

      final tenant = await tenantDao.getTenantByID(_selectedTenantId!);
      if (tenant == null) return;

      double meterLastMonth = double.parse(_meterLastController.text);
      double meterThisMonth = double.parse(_meterThisController.text);
      if (meterThisMonth < meterLastMonth) {
        if (mounted) {
          Toast(
            context: context,
            title: 'Invalid Meter Reading',
            description: 'This month reading cannot be less than last month.',
            type: ToastificationType.error,
          );
          return;
        }
      }

      double totalRentForMonth = double.parse(_totalRentController.text);
      double currentDueAmount =
          double.tryParse(_currentDueController.text) ?? 0;
      double newTotalDueAmount;

      if (_rentPaid) {
        newTotalDueAmount = currentDueAmount;
      } else {
        newTotalDueAmount = totalRentForMonth;
      }

      final rentCompanion = RentCompanion(
        tenantID: Value(_selectedTenantId!),
        rentPerMonth: Value(tenant.rentPerMonth),
        electricityRate: Value(tenant.electricityRate),
        rentPaid: Value(_rentPaid),
        currentDueAmount: Value(currentDueAmount),
        totalDueAmount: Value(newTotalDueAmount),
        amountPaidOn: Value(_amountPaidOn),
        meterReadingLastMonth: Value(meterLastMonth),
        meterReadingThisMonth: Value(meterThisMonth),
        paymentMode: Value(_paymentMode),
        totalRentForMonth: Value(totalRentForMonth),
        rentMonth: Value(DateTime(_rentMonth.year, _rentMonth.month)),
      );

      if (widget.rent == null) {
        await rentDao.insertRent(rentCompanion);
      } else {
        await rentDao.updateRent(
          rentCompanion.copyWith(rentID: Value(widget.rent!.rentID)),
        );
      }

      await tenantDao.updateTenant(
        tenant.copyWith(totalDueAmount: newTotalDueAmount).toCompanion(true),
      );

      if (mounted) {
        Toast(
          context: context,
          title: 'Success!',
          description: 'Rent Record Saved Successfully',
          type: ToastificationType.success,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        Toast(
          context: context,
          title: 'Error Saving Rent',
          description: e.toString(),
          type: ToastificationType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tenantsAsyncValue = ref.watch(tenantsProvider);
    final ownerDao = ref.watch(ownerDaoProvider);
    final isUpdate = widget.rent != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${isUpdate ? 'Update' : 'Add'} Rent Record',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: tenantsAsyncValue.when(
        data: (tenants) {
          return SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(16),
                      children: [
                        // Header Card
                        Card(
                          color: AppTheme.primaryWhite,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tenant & Payment Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 16),

                                // Tenant Dropdown
                                DropdownButtonFormField<int>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Tenant',
                                    hintText: 'Choose a tenant',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: AppTheme.primaryColor,
                                      size: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.primaryColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.primaryRed,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                  menuMaxHeight: 300,
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: AppTheme.primaryColor,
                                  ),
                                  dropdownColor: Colors.white,
                                  value: _selectedTenantId,
                                  items: tenants.map((tenant) {
                                    return DropdownMenuItem<int>(
                                      value: tenant.tenantID,
                                      child: Text(
                                        tenant.name,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: isUpdate
                                      ? null
                                      : (val) async {
                                          setState(
                                            () => _selectedTenantId = val,
                                          );
                                          if (val != null) {
                                            await _fetchLastRentAndTenant(val);
                                          }
                                        },
                                  validator: (val) =>
                                      val == null ? 'Select tenant' : null,
                                ),

                                SizedBox(height: 16),

                                // Payment Status
                                Container(
                                  decoration: BoxDecoration(
                                    color: _rentPaid
                                        ? Colors.green.withValues(alpha: 0.1)
                                        : AppTheme.primaryRed.withValues(
                                            alpha: 0.1,
                                          ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _rentPaid
                                          ? Colors.green.withValues(alpha: 0.3)
                                          : AppTheme.primaryRed.withValues(
                                              alpha: 0.3,
                                            ),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  child: SwitchListTile(
                                    title: Text(
                                      'Payment Status',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    subtitle: Text(
                                      _rentPaid ? 'Paid' : 'Unpaid',
                                      style: TextStyle(
                                        color: _rentPaid
                                            ? Colors.green
                                            : AppTheme.primaryRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    value: _rentPaid,
                                    activeColor: Colors.green,
                                    inactiveTrackColor: AppTheme.primaryRed
                                        .withValues(alpha: 0.3),
                                    inactiveThumbColor: Colors.white,
                                    onChanged: (val) => setState(() {
                                      _rentPaid = val;
                                      if (val) {
                                        _amountPaidOn = DateTime.now();
                                        _currentDueController.text = "0.0";
                                      } else {
                                        _amountPaidOn = null;
                                        if (_selectedTenantId != null) {
                                          final tenants =
                                              ref.read(tenantsProvider).value ??
                                              [];
                                          final tenant = tenants.firstWhere(
                                            (t) =>
                                                t.tenantID == _selectedTenantId,
                                            orElse: () => tenants.first,
                                          );
                                          _calculateTotalRent(tenant);
                                        }
                                      }
                                    }),
                                  ),
                                ),

                                SizedBox(height: 16),

                                // Rent Month Selector
                                InkWell(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: _rentMonth,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: AppTheme.primaryColor,
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      setState(() => _rentMonth = picked);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: AppTheme.primaryColor,
                                          size: 20,
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Rent Month',
                                                style: TextStyle(
                                                  color: AppTheme.primaryBlack
                                                      .withValues(alpha: 0.7),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                formatDate(_rentMonth),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                if (_rentPaid) ...[
                                  SizedBox(height: 16),

                                  // Payment Details
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            final picked = await showDatePicker(
                                              context: context,
                                              initialDate:
                                                  _amountPaidOn ??
                                                  DateTime.now(),
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2100),
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                        colorScheme:
                                                            ColorScheme.light(
                                                              primary: AppTheme
                                                                  .primaryColor,
                                                            ),
                                                      ),
                                                  child: child!,
                                                );
                                              },
                                            );
                                            if (picked != null) {
                                              setState(
                                                () => _amountPaidOn = picked,
                                              );
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 12,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Paid On',
                                                  style: TextStyle(
                                                    color: AppTheme.primaryBlack
                                                        .withValues(alpha: 0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.event,
                                                      color:
                                                          AppTheme.primaryColor,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      _amountPaidOn == null
                                                          ? 'Select Date'
                                                          : formatDate(
                                                              _amountPaidOn!,
                                                            ),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 12,
                                          ),
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Payment Mode',
                                              labelStyle: TextStyle(
                                                color: AppTheme.primaryBlack
                                                    .withValues(alpha: 0.7),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            value: _paymentMode,
                                            isDense: true,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: AppTheme.primaryColor,
                                            ),
                                            items: [
                                              DropdownMenuItem(
                                                value: 'cash',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.money,
                                                      color:
                                                          AppTheme.primaryColor,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text('Cash'),
                                                  ],
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'online',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone_android,
                                                      color:
                                                          AppTheme.primaryColor,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text('Online'),
                                                  ],
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'cheque',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .account_balance_wallet,
                                                      color:
                                                          AppTheme.primaryColor,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text('Cheque'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            onChanged: (val) => setState(
                                              () => _paymentMode = val,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Meter Reading Card
                        Card(
                          elevation: 4,
                          color: AppTheme.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Electricity Meter Readings',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 16),

                                _buildTextField(
                                  controller: _meterLastController,
                                  label: 'Previous Meter Reading',
                                  hintText: 'Last month meter reading',
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*$'),
                                    ),
                                  ],
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'Enter last month reading'
                                      : null,
                                  enabled: false,
                                  prefixIcon: Icons.history,
                                ),

                                _buildTextField(
                                  controller: _meterThisController,
                                  label: 'Current Meter Reading',
                                  hintText: 'This month meter reading',
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*$'),
                                    ),
                                  ],
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'Enter this month reading'
                                      : null,
                                  onChanged: (val) {
                                    if (_selectedTenantId != null) {
                                      final tenants =
                                          ref.read(tenantsProvider).value ?? [];
                                      final tenant = tenants.firstWhere(
                                        (t) => t.tenantID == _selectedTenantId,
                                        orElse: () => tenants.first,
                                      );
                                      _calculateTotalRent(tenant);
                                    }
                                  },
                                  prefixIcon: Icons.electric_meter,
                                ),

                                if (_meterLastController.text.isNotEmpty &&
                                    _meterThisController.text.isNotEmpty) ...[
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.electric_bolt,
                                          color: AppTheme.primaryColor,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Units Consumed: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${(double.tryParse(_meterThisController.text) ?? 0.0) - (double.tryParse(_meterLastController.text) ?? 0.0) > 0 ? ((double.tryParse(_meterThisController.text) ?? 0.0) - (double.tryParse(_meterLastController.text) ?? 0.0)).toStringAsFixed(1) : "0.0"} units',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Amount Details Card
                        Card(
                          elevation: 4,
                          color: AppTheme.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 16),

                                _buildTextField(
                                  controller: _totalDueAmountController,
                                  label: 'Total Due Amount',
                                  hintText:
                                      'Total amount due from previous months',
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*$'),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    if (_selectedTenantId != null) {
                                      final tenant = tenants.firstWhere(
                                        (t) => t.tenantID == _selectedTenantId,
                                      );
                                      _calculateTotalRent(tenant);
                                    }
                                  },
                                  prefixIcon: Icons.account_balance_wallet,
                                ),

                                _buildTextField(
                                  controller: _currentDueController,
                                  label: 'Current Due Amount',
                                  hintText: 'Amount due for current month',
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*$'),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    if (_selectedTenantId != null) {
                                      final tenant = tenants.firstWhere(
                                        (t) => t.tenantID == _selectedTenantId,
                                      );
                                      _calculateTotalRent(tenant);
                                    }
                                  },
                                  prefixIcon: Icons.money,
                                ),

                                SizedBox(height: 8),

                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppTheme.primaryColor.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Monthly Rent:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '₹${_totalRentController.text.isEmpty ? 0 : _totalRentController.text}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Submit Button
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          offset: Offset(0, -4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: OutlinedButton.icon(
                            onPressed:
                                _selectedTenantId != null &&
                                    _meterThisController.text.isNotEmpty
                                ? () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    final tenantDao = ref.read(
                                      tenantDaoProvider,
                                    );

                                    final ownerData = await ownerDao
                                        .getAllOwners();

                                    if (ownerData.isEmpty) {
                                      Toast(
                                        context: context,
                                        title: 'No Owner Data found',
                                        description:
                                            'Add an owner first to generate invoice',
                                      );
                                      return;
                                    }
                                    final tenant = await tenantDao
                                        .getTenantByID(_selectedTenantId!);
                                    if (tenant == null) return;

                                    double meterLastMonth = double.parse(
                                      _meterLastController.text,
                                    );
                                    double meterThisMonth = double.parse(
                                      _meterThisController.text,
                                    );
                                    double totalRentForMonth = double.parse(
                                      _totalRentController.text,
                                    );
                                    double currentDueAmount =
                                        double.tryParse(
                                          _currentDueController.text,
                                        ) ??
                                        0;

                                    // Create a temporary RentData object for preview
                                    final previewRent = RentData(
                                      rentID: widget.rent?.rentID ?? 0,
                                      tenantID: _selectedTenantId!,
                                      rentPerMonth: tenant.rentPerMonth,
                                      electricityRate: tenant.electricityRate,
                                      rentPaid: _rentPaid,
                                      currentDueAmount: currentDueAmount,
                                      totalDueAmount: totalRentForMonth,
                                      amountPaidOn: _amountPaidOn,
                                      meterReadingLastMonth: meterLastMonth,
                                      meterReadingThisMonth: meterThisMonth,
                                      paymentMode: _paymentMode,
                                      totalRentForMonth: totalRentForMonth,
                                      rentMonth: DateTime(
                                        _rentMonth.year,
                                        _rentMonth.month,
                                      ),
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    );

                                    final file = await _pdfService
                                        .generateRentInvoice(
                                          previewRent,
                                          tenant,
                                          ownerData.first,
                                        );
                                    _pdfService.openPDF(file);
                                  }
                                : null,
                            icon: Icon(
                              Icons.preview,
                              color: AppTheme.primaryColor,
                            ),
                            label: Text(
                              'Preview Invoice',
                              style: TextStyle(color: AppTheme.primaryColor),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: AppTheme.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton(
                            onPressed: _saveRent,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              isUpdate
                                  ? 'Update Rent Record'
                                  : 'Save Rent Record',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
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
                'Loading tenant data...',
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
                'Error loading data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryRed,
                ),
              ),
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
}
