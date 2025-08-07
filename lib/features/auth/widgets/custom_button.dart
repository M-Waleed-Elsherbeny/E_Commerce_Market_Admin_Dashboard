import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.buttonWidth,
    this.buttonHeight,
    this.textButton = "no Name",
    this.onPressed,
    this.child,
    this.backgroundColor,
  });
  final double? buttonWidth, buttonHeight;
  final String textButton;
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth ?? 50, buttonHeight ?? 50),
        backgroundColor: backgroundColor ?? AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child:
          child ??
          Text(
            textButton,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.kWhiteColor,
            ),
          ),
    );
  }
}
