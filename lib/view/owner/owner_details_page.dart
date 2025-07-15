import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_ledger/provider/db_provider.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:tenant_ledger/util/toast.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:toastification/toastification.dart';

class OwnerDetailsPage extends ConsumerStatefulWidget {
  final bool isEditing;

  const OwnerDetailsPage({super.key, this.isEditing = false});

  @override
  ConsumerState<OwnerDetailsPage> createState() => _OwnerDetailsPageState();
}

class _OwnerDetailsPageState extends ConsumerState<OwnerDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _isEditing;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _propertyNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _upiIdController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isEditing;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _propertyNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    _upiIdController.dispose();
    super.dispose();
  }

  

  void _populateFormFields(OwnerData owner) {
    _nameController.text = owner.name;
    _phoneController.text = owner.phone;
    _propertyNameController.text = owner.propertyName;
    _addressController.text = owner.address;
    _cityController.text = owner.city;
    _stateController.text = owner.state;
    _pinCodeController.text = owner.pinCode;
    _upiIdController.text = owner.upiID ?? '';
  }

  Future<void> _saveOwner(OwnerData? existingOwner) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (existingOwner != null) {
        final updatedOwner = OwnerCompanion(
          ownerID: Value(existingOwner.ownerID),
          name: Value(_nameController.text),
          phone: Value(_phoneController.text),
          propertyName: Value(_propertyNameController.text),
          address: Value(_addressController.text),
          city: Value(_cityController.text),
          state: Value(_stateController.text),
          pinCode: Value(_pinCodeController.text),
          upiID: Value(
            _upiIdController.text.isEmpty ? null : _upiIdController.text,
          ),
          updatedAt: Value(DateTime.now()),
          createdAt: Value(existingOwner.createdAt),
        );

        await ref.read(ownerDaoProvider).updateOwner(updatedOwner);

        if (mounted) {
          Toast(
            context: context,
            title: 'Hurray!',
            description: "Owner 's details updated successfully!",
            type: ToastificationType.success,
          );
        }
      } else {
        final newOwner = OwnerCompanion.insert(
          name: _nameController.text,
          phone: _phoneController.text,
          propertyName: _propertyNameController.text,
          address: _addressController.text,
          city: _cityController.text,
          state: _stateController.text,
          pinCode: _pinCodeController.text,
          upiID: Value(
            _upiIdController.text.isEmpty ? null : _upiIdController.text,
          ),
        );

        await ref.read(ownerDaoProvider).insertOwner(newOwner);

        if (mounted) {
          Toast(
            context: context,
            title: 'Hurray!',
            description: 'Owner data saved successfully!',
            type: ToastificationType.success,
          );
        }
      }

      setState(() {
        _isEditing = false;
      });
    } catch (e, stack) {
      print(e);
      print(stack);
      if (mounted) {
        Toast(
          context: context,
          title: 'Error Saving Owner',
          description: e.toString(),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteOwner(int ownerID) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Owner'),
        content: const Text(
          'Are you sure you want to delete this owner? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(ownerDaoProvider).deleteOwner(ownerID);

      if (mounted) {
        Toast(
          context: context,
          title: 'Hurray!',
          description: "Owner deleted successfully!",
          type: ToastificationType.success,
        );
        setState(() {
          _isEditing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        Toast(
          context: context,
          title: 'Error Deleting Owner',
          description: e.toString(),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ownersAsyncValue = ref.watch(allOwnersProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Owner Details'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: ownersAsyncValue.when(
        loading: () => null,
        error: (_, __) => null,
        data: (owners) {
          if (owners.isEmpty) {
            return _isEditing
                ? null
                : FloatingActionButton.extended(
                    onPressed: () => setState(() => _isEditing = true),
                    backgroundColor: AppTheme.primaryColor,
                    icon: const Icon(Icons.add, color: AppTheme.primaryWhite),
                    label: const Text(
                      'ADD OWNER',
                      style: TextStyle(color: AppTheme.primaryWhite),
                    ),
                  );
          } else {
            // Owner exists
            return _isEditing
                ? FloatingActionButton.extended(
                    onPressed: () => _saveOwner(owners.first),
                    backgroundColor: AppTheme.primaryColor,
                    icon: const Icon(Icons.save, color: AppTheme.primaryWhite),
                    label: const Text(
                      'SAVE',
                      style: TextStyle(color: AppTheme.primaryWhite),
                    ),
                  )
                : FloatingActionButton.extended(
                    onPressed: () => setState(() => _isEditing = true),
                    backgroundColor: AppTheme.primaryColor,
                    icon: const Icon(Icons.edit, color: AppTheme.primaryWhite),
                    label: const Text(
                      'EDIT',
                      style: TextStyle(color: AppTheme.primaryWhite),
                    ),
                  );
          }
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ownersAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (owners) {
                if (owners.isEmpty) {
                  if (_isEditing) {
                    return _buildCreateOwnerForm();
                  } else {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                size: 80,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'No Owner Details Found',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Add your details as the property owner',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }

                final owner = owners.first;

                if (_nameController.text.isEmpty) {
                  _populateFormFields(owner);
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Owner header with avatar
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withValues(
                                alpha: 0.1,
                              ),
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
                                owner.name.isNotEmpty
                                    ? owner.name[0].toUpperCase()
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
                              owner.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withValues(
                                  alpha: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: AppTheme.primaryWhite,
                                    size: 16,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    owner.propertyName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppTheme.primaryWhite,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),

                            // Status Indicators
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Contact Information Card
                              _buildInfoCard(
                                'Contact Information',
                                Icons.contact_phone,
                                [
                                  _buildTextFormField(
                                    label: 'Name',
                                    controller: _nameController,
                                    enabled: _isEditing,
                                    prefixIcon: Icons.person,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'Please enter owner name'
                                        : null,
                                  ),
                                  _buildTextFormField(
                                    label: 'Phone',
                                    controller: _phoneController,
                                    enabled: _isEditing,
                                    prefixIcon: Icons.phone,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'Please enter phone number'
                                        : null,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Property Details Card
                              _buildInfoCard('Property Details', Icons.home, [
                                _buildTextFormField(
                                  label: 'Property Name',
                                  controller: _propertyNameController,
                                  enabled: _isEditing,
                                  prefixIcon: Icons.business,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Please enter property name'
                                      : null,
                                ),
                                _buildTextFormField(
                                  label: 'Address',
                                  controller: _addressController,
                                  enabled: _isEditing,
                                  prefixIcon: Icons.location_on,
                                  maxLines: 2,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Please enter address'
                                      : null,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildTextFormField(
                                        label: 'City',
                                        controller: _cityController,
                                        enabled: _isEditing,
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                            ? 'Please enter city'
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildTextFormField(
                                        label: 'State',
                                        controller: _stateController,
                                        enabled: _isEditing,
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                            ? 'Please enter state'
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                _buildTextFormField(
                                  label: 'PIN Code',
                                  controller: _pinCodeController,
                                  enabled: _isEditing,
                                  prefixIcon: Icons.pin,
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Please enter PIN code'
                                      : null,
                                ),
                              ]),

                              const SizedBox(height: 16),

                              // Payment Details Card
                              _buildInfoCard(
                                'Payment Details',
                                Icons.payments_outlined,
                                [
                                  _buildTextFormField(
                                    label: 'UPI ID (Optional)',
                                    controller: _upiIdController,
                                    enabled: _isEditing,
                                    prefixIcon: Icons.account_balance,
                                  ),
                                  const SizedBox(height: 12),
                                  
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Record Info Card
                              if (_isEditing)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24.0,
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _deleteOwner(owner.ownerID),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'DELETE OWNER',
                                      style: TextStyle(
                                        color: AppTheme.primaryWhite,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),

                              // Add some bottom space for FAB
                              const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 10,
      color: AppTheme.primaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
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
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildCreateOwnerForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1,
                      size: 60,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Create Owner Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter your details as the property owner',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Contact Information Card
            _buildInfoCard('Contact Information', Icons.contact_phone, [
              _buildTextFormField(
                label: 'Name',
                controller: _nameController,
                enabled: true,
                prefixIcon: Icons.person,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter owner name'
                    : null,
              ),
              _buildTextFormField(
                label: 'Phone',
                controller: _phoneController,
                enabled: true,
                maxLength: 10,
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter phone number'
                    : null,
              ),
            ]),

            const SizedBox(height: 16),

            // Property Details Card
            _buildInfoCard('Property Details', Icons.home, [
              _buildTextFormField(
                label: 'Property Name',
                controller: _propertyNameController,
                enabled: true,
                prefixIcon: Icons.business,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter property name'
                    : null,
              ),
              _buildTextFormField(
                label: 'Address',
                controller: _addressController,
                enabled: true,
                prefixIcon: Icons.location_on,
                maxLines: 2,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter address'
                    : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      label: 'City',
                      controller: _cityController,
                      enabled: true,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter city'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFormField(
                      label: 'State',
                      controller: _stateController,
                      enabled: true,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter state'
                          : null,
                    ),
                  ),
                ],
              ),
              _buildTextFormField(
                label: 'PIN Code',
                controller: _pinCodeController,
                enabled: true,
                prefixIcon: Icons.pin,
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter PIN code'
                    : null,
              ),
            ]),

            const SizedBox(height: 16),

            // Payment Details Card
            _buildInfoCard('Payment Details', Icons.payments_outlined, [
              _buildTextFormField(
                label: 'UPI ID (Optional)',
                controller: _upiIdController,
                enabled: true,
                prefixIcon: Icons.account_balance,
              ),
              const SizedBox(height: 12),
            ]),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => _saveOwner(null),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: const Text(
                'SAVE OWNER DETAILS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    int maxLines = 1,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        cursorColor: AppTheme.primaryColor,
        maxLength: maxLength,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: enabled ? Colors.black87 : Colors.black54),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppTheme.primaryBlack.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
              width: 2,
            ),
          ),
          enabled: enabled,
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        validator: validator,
      ),
    );
  }

  
  
}
