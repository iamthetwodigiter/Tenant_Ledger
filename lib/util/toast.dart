import 'package:flutter/cupertino.dart';
import 'package:tenant_ledger/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

class Toast {
  Toast({
    required BuildContext context,
    required String title,
    required String description,
    ToastificationType type = ToastificationType.error,
    Duration? duration = const Duration(seconds: 5),
    AlignmentGeometry alignment = Alignment.bottomCenter,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: duration,
      title: Text(
        title,
        style: TextStyle(
          color: _getToastColor(type),
          fontWeight: FontWeight.bold,
          fontFamily: 'Metropolis',
        ),
      ),
      description: Text(
        description,
        style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Metropolis'),
      ),
      alignment: alignment,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      showIcon: false,
      primaryColor: _getToastColor(type),
      backgroundColor: AppTheme.primaryWhite,
      foregroundColor: AppTheme.primaryBlack,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: true,
      closeOnClick: true,
      pauseOnHover: false,
      dragToClose: true,
      applyBlurEffect: false,
    );
  }

  Color _getToastColor(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return AppTheme.primaryGreen;
      case ToastificationType.error:
        return AppTheme.primaryRed;
      case ToastificationType.warning:
        return AppTheme.primaryOrange;
      case ToastificationType.info:
        return AppTheme.primaryBlue;
      default:
        return AppTheme.primaryGreen;
    }
  }
}
