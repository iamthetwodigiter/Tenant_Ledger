import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/util/toast.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class AddTenantsPage extends ConsumerStatefulWidget {
  final TenantData? tenant;
  const AddTenantsPage({super.key, this.tenant});

  @override
  ConsumerState<AddTenantsPage> createState() => _AddTenantsPageState();
}

class _AddTenantsPageState extends ConsumerState<AddTenantsPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _nameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _aadharController;
  late final TextEditingController _addressController;
  late final TextEditingController _emergencyContactController;
  late final TextEditingController _agreementPeriodController;
  late final TextEditingController _rentPerMonthController;
  late final TextEditingController _advancePaymentController;
  late final TextEditingController _totalDueAmountController;
  late final TextEditingController _meterReadingInitialController;
  late final TextEditingController _meterReadingFinalController;
  late final TextEditingController _electricityRateController;
  late final TextEditingController _waterChargesController;
  late final TextEditingController _perYearIncrementController;

  bool _agreementDone = false;
  DateTime _monthEntered = DateTime.now();
  DateTime? _monthExit;
  List<String> _aadharImages = [];
  bool _isUploading = false;
  final Directory _imagesDirectory = Directory(
    '/storage/emulated/0/TenantLedger/Images/',
  );

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _mobileController = TextEditingController();
    _aadharController = TextEditingController();
    _addressController = TextEditingController();
    _emergencyContactController = TextEditingController();
    _agreementPeriodController = TextEditingController();
    _rentPerMonthController = TextEditingController();
    _advancePaymentController = TextEditingController();
    _totalDueAmountController = TextEditingController();
    _meterReadingInitialController = TextEditingController();
    _meterReadingFinalController = TextEditingController();
    _electricityRateController = TextEditingController();
    _waterChargesController = TextEditingController();
    _perYearIncrementController = TextEditingController();

    if (widget.tenant != null) {
      _nameController.text = widget.tenant!.name;
      _mobileController.text = widget.tenant!.mobileNo;
      _aadharController.text = widget.tenant!.aadharNo;
      _addressController.text = widget.tenant!.permanentAddress;
      _emergencyContactController.text = widget.tenant!.emergencyContact;
      _agreementPeriodController.text = widget.tenant!.agreementPeriod
          .toString();
      _agreementDone = widget.tenant!.agreementDone;
      _aadharImages = widget.tenant!.aadharImages;
      _rentPerMonthController.text = widget.tenant!.rentPerMonth.toString();
      _advancePaymentController.text = widget.tenant!.advancePayment.toString();
      _totalDueAmountController.text = widget.tenant!.totalDueAmount.toString();
      _monthEntered = widget.tenant!.monthEntered;
      _meterReadingInitialController.text = widget.tenant!.meterReadingInitial
          .toString();
      _meterReadingFinalController.text =
          widget.tenant!.meterReadingFinal?.toString() ?? '';
      _electricityRateController.text = widget.tenant!.electricityRate
          .toString();
      _waterChargesController.text = widget.tenant!.waterCharges.toString();
      _perYearIncrementController.text = widget.tenant!.perYearIncrement
          .toString();
    } else {
      _agreementPeriodController.text = '11';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _aadharController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _agreementPeriodController.dispose();
    _rentPerMonthController.dispose();
    _advancePaymentController.dispose();
    _totalDueAmountController.dispose();
    _meterReadingInitialController.dispose();
    _meterReadingFinalController.dispose();
    _electricityRateController.dispose();
    _waterChargesController.dispose();
    _perYearIncrementController.dispose();
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
    Widget? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
          suffixIcon: suffix,
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
        enabled: enabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        style: TextStyle(
          color: enabled ? AppTheme.primaryBlack : Colors.grey.shade700,
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
      margin: EdgeInsets.only(bottom: 20),
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

  void _saveTenant() async {
    if (_formKey.currentState!.validate()) {
      final tenantDao = ref.read(tenantDaoProvider);

      try {
        double? finalMeterReading;
        if (_meterReadingFinalController.text.isNotEmpty) {
          finalMeterReading = double.parse(_meterReadingFinalController.text);
        }

        if (widget.tenant == null) {
          final tenant = TenantCompanion.insert(
            name: _nameController.text,
            mobileNo: _mobileController.text,
            aadharNo: _aadharController.text,
            permanentAddress: _addressController.text,
            emergencyContact: _emergencyContactController.text,
            agreementPeriod: int.parse(_agreementPeriodController.text),
            agreementDone: _agreementDone,
            aadharImages: Value(_aadharImages),
            rentPerMonth: double.parse(_rentPerMonthController.text),
            advancePayment: double.parse(_advancePaymentController.text),
            totalDueAmount: double.parse(_totalDueAmountController.text),
            monthEntered: _monthEntered,
            monthExit: Value(_monthExit),
            meterReadingInitial: double.parse(
              _meterReadingInitialController.text,
            ),
            meterReadingFinal: Value(finalMeterReading),
            electricityRate: double.parse(_electricityRateController.text),
            waterCharges: double.parse(_waterChargesController.text),
            perYearIncrement: double.parse(_perYearIncrementController.text),
          );

          await tenantDao.insertTenant(tenant);
        } else {
          final updatedTenant = widget.tenant!
              .copyWith(
                name: _nameController.text,
                mobileNo: _mobileController.text,
                aadharNo: _aadharController.text,
                permanentAddress: _addressController.text,
                emergencyContact: _emergencyContactController.text,
                agreementPeriod: int.parse(_agreementPeriodController.text),
                agreementDone: _agreementDone,
                aadharImages: _aadharImages,
                rentPerMonth: double.parse(_rentPerMonthController.text),
                advancePayment: double.parse(_advancePaymentController.text),
                totalDueAmount: double.parse(_totalDueAmountController.text),
                monthEntered: _monthEntered,
                monthExit: Value(_monthExit),
                meterReadingInitial: double.parse(
                  _meterReadingInitialController.text,
                ),
                meterReadingFinal: Value(finalMeterReading),
                electricityRate: double.parse(_electricityRateController.text),
                waterCharges: double.parse(_waterChargesController.text),
                perYearIncrement: double.parse(
                  _perYearIncrementController.text,
                ),
                updatedAt: DateTime.now(),
              )
              .toCompanion(true);

          await tenantDao.updateTenant(updatedTenant);
        }

        if (mounted) {
          Toast(
            context: context,
            title: 'Success!',
            description:
                'Successfully ${widget.tenant == null ? 'added' : 'updated'} tenant record',
            type: ToastificationType.success,
          );

          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          Toast(
            context: context,
            title: 'Error registering tenant',
            description: e.toString(),
            type: ToastificationType.error,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.tenant != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Tenant' : 'Add New Tenant',
          style: TextStyle(
            color: AppTheme.primaryWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _buildSectionCard(
                      title: 'Personal Information',
                      icon: Icons.person,
                      children: [
                        _buildTextField(
                          controller: _nameController,
                          label: 'Tenant Name',
                          hintText: 'Enter full name',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter tenant name';
                            }
                            return null;
                          },
                        ),

                        _buildTextField(
                          controller: _mobileController,
                          label: 'Mobile Number',
                          hintText: '10 digit mobile',
                          prefixIcon: Icons.phone_android,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter mobile number';
                            }
                            if (value.length != 10) {
                              return 'Mobile number must be 10 digits';
                            }
                            return null;
                          },
                          maxLength: 10,
                        ),
                        _buildTextField(
                          controller: _emergencyContactController,
                          label: 'Emergency Contact',
                          hintText: 'Emergency number',
                          prefixIcon: Icons.contact_phone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter emergency contact';
                            }
                            if (value.length != 10) {
                              return 'Mobile number must be 10 digits';
                            }
                            return null;
                          },
                          maxLength: 10,
                        ),

                        _buildTextField(
                          controller: _aadharController,
                          label: 'Aadhar Number',
                          hintText: '12 digit Aadhar',
                          prefixIcon: Icons.credit_card,
                          suffix: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: AppTheme.primaryColor,
                            ),
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();

                              List<XFile> images = await picker
                                  .pickMultiImage();

                              if (images.isNotEmpty) {
                                setState(() {
                                  _isUploading = true;
                                });

                                List<String> imagePaths = [];

                                if (_imagesDirectory.existsSync() == false) {
                                  _imagesDirectory.createSync(recursive: true);
                                }

                                final folderName = _nameController.text.isEmpty
                                    ? 'Tenant'
                                    : _nameController.text.replaceAll(" ", "_");

                                final Directory tenantDir = Directory(
                                  '${_imagesDirectory.path}/$folderName',
                                );
                                if (!tenantDir.existsSync()) {
                                  tenantDir.createSync();
                                }

                                for (var image in images) {
                                  final fileName =
                                      'Aadhar_${DateTime.now().millisecondsSinceEpoch}_${images.indexOf(image)}.jpg';
                                  final newPath = '${tenantDir.path}/$fileName';
                                  await image.saveTo(newPath);
                                  imagePaths.add(newPath);
                                }

                                setState(() {
                                  _aadharImages = imagePaths;
                                  _isUploading = false;
                                });
                              }
                            },
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Aadhar number';
                            }
                            if (value.length != 12) {
                              return 'Aadhar must be 12 digits';
                            }
                            return null;
                          },
                          maxLength: 12,
                        ),
                        if (_isUploading)
                          Center(
                            child: CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryColor,
                              ),
                            ),
                          )
                        else if (_aadharImages.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _aadharImages.map((imagePath) {
                              return Stack(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: FileImage(File(imagePath)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _aadharImages.remove(imagePath);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.7),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        SizedBox(height: 12),
                        _buildTextField(
                          controller: _addressController,
                          label: 'Permanent Address',
                          hintText: 'Full permanent address',
                          prefixIcon: Icons.home,
                          maxLines: 2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter permanent address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    _buildSectionCard(
                      title: 'Agreement Details',
                      icon: Icons.description,
                      children: [
                        _buildTextField(
                          controller: _agreementPeriodController,
                          label: 'Agreement Period',
                          hintText: 'Months',
                          prefixIcon: Icons.date_range,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter period';
                            }
                            return null;
                          },
                        ),
                        SizedBox(width: 12),
                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _monthEntered,
                              firstDate: DateTime(2000),
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
                            if (picked != null && picked != _monthEntered) {
                              setState(() {
                                _monthEntered = picked;
                              });
                            }
                          },
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: AppTheme.primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Start Date',
                                      style: TextStyle(
                                        color: AppTheme.primaryBlack.withValues(
                                          alpha: 0.7,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        'dd MMM yyyy',
                                      ).format(_monthEntered),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _monthExit ?? DateTime.now(),
                              firstDate: DateTime(2000),
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
                              setState(() {
                                _monthExit = picked;
                              });
                            }
                          },
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: AppTheme.primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Leave Date (Optional)',
                                      style: TextStyle(
                                        color: AppTheme.primaryBlack.withValues(
                                          alpha: 0.7,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _monthExit != null
                                          ? DateFormat(
                                              'dd MMM yyyy',
                                            ).format(_monthExit!)
                                          : 'Not set (tap to select)',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: _monthExit != null
                                            ? AppTheme.primaryBlack
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 12),

                        Container(
                          decoration: BoxDecoration(
                            color: _agreementDone
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _agreementDone
                                  ? Colors.green.withValues(alpha: 0.3)
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: SwitchListTile.adaptive(
                            title: Text(
                              'Agreement Status',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              _agreementDone
                                  ? 'Agreement Complete'
                                  : 'Agreement Pending',
                              style: TextStyle(
                                color: _agreementDone
                                    ? Colors.green
                                    : Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                            value: _agreementDone,
                            activeColor: Colors.green,
                            inactiveTrackColor: Colors.grey.shade300,
                            inactiveThumbColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _agreementDone = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    _buildSectionCard(
                      title: 'Financial Details',
                      icon: Icons.account_balance_wallet,
                      children: [
                        _buildTextField(
                          controller: _rentPerMonthController,
                          label: 'Monthly Rent',
                          hintText: 'Amount in ₹',
                          prefixIcon: Icons.currency_rupee,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter rent amount';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                _advancePaymentController.text.isNotEmpty) {
                              setState(() {
                                _totalDueAmountController.text =
                                    (double.parse(value) -
                                            double.parse(
                                              _advancePaymentController.text,
                                            ))
                                        .toString();
                              });
                            }
                          },
                        ),
                        SizedBox(width: 12),
                        _buildTextField(
                          controller: _advancePaymentController,
                          label: 'Advance Payment',
                          hintText: 'Amount in ₹',
                          prefixIcon: Icons.payment,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter advance';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (_rentPerMonthController.text.isNotEmpty &&
                                value.isNotEmpty) {
                              setState(() {
                                _totalDueAmountController.text =
                                    (double.parse(
                                              _rentPerMonthController.text,
                                            ) -
                                            double.parse(value))
                                        .toString();
                              });
                            }
                          },
                        ),

                        _buildTextField(
                          controller: _totalDueAmountController,
                          label: 'Initial Due Amount',
                          hintText: 'Amount in ₹',
                          prefixIcon: Icons.money_off,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter due amount';
                            }
                            return null;
                          },
                        ),

                        _buildTextField(
                          controller: _perYearIncrementController,
                          label: 'Yearly Rent Increment',
                          hintText: 'Percentage (%)',
                          prefixIcon: Icons.trending_up,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter yearly increment';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    _buildSectionCard(
                      title: 'Utility Details',
                      icon: Icons.electric_bolt,
                      children: [
                        _buildTextField(
                          controller: _meterReadingInitialController,
                          label: 'Initial Meter Reading',
                          hintText: 'Units',
                          prefixIcon: Icons.speed,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter meter reading';
                            }
                            return null;
                          },
                        ),
                        SizedBox(width: 12),
                        _buildTextField(
                          controller: _meterReadingFinalController,
                          label: 'Final Meter Reading (Optional)',
                          hintText: 'Only when tenant is leaving',
                          prefixIcon: Icons.speed,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (_monthExit != null &&
                                (value == null || value.isEmpty)) {
                              return 'Please enter final reading';
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          controller: _electricityRateController,
                          label: 'Electricity Rate',
                          hintText: '₹ per unit',
                          prefixIcon: Icons.electric_bolt,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter rate';
                            }
                            return null;
                          },
                        ),

                        _buildTextField(
                          controller: _waterChargesController,
                          label: 'Water Charges',
                          hintText: 'Monthly water charges in ₹',
                          prefixIcon: Icons.water_drop,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter water charges';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
                child: ElevatedButton(
                  onPressed: _saveTenant,
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
                    isEditing ? 'Update Tenant' : 'Add Tenant',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
