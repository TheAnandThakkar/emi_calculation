import 'package:emi_calculation/utils/app_commons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonComponent {
  static elevatedButton({
    required String title,
    required VoidCallback onPress,
    Color? primaryColor,
    Color? foregroundColor,
    double? buttonTextSize,
    FontWeight? buttonTextWeight,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: primaryColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(
          fontSize: buttonTextSize,
          fontWeight: buttonTextWeight,
        ),
      ),
    );
  }

  static textButtonWithIcon({
    required String title,
    required VoidCallback onPressed,
    required IconData icon,
    Color? iconColor,
    Color? textColor,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          AppColors.backgroundColor,
        ),
      ),
    );
  }
}
