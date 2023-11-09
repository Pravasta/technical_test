import 'package:flutter/material.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/constant/app_text.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    super.key,
    this.backgroundColor = AppColors.blueColor,
    this.textColor = AppColors.whiteColor,
    required this.title,
    this.elevation = 4,
    required this.onTap,
    this.height = 60,
    this.width = 130,
  });

  final Color backgroundColor;
  final Color textColor;
  final String title;
  final double elevation;
  final VoidCallback onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        elevation: elevation,
        shadowColor: AppColors.blueColor.withOpacity(0.7),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: AppText.text20.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
