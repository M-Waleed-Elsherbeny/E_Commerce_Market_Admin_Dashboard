import 'package:admin_dashboard/core/assets/app_assets.dart';
import 'package:admin_dashboard/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoginMethods extends StatelessWidget {
  const CustomLoginMethods({
    super.key,
    required this.deviceWidth,
    this.onGoogleSignIn,
    this.onFacebookSignIn,
    this.onAppleSignIn,
  });

  final double? deviceWidth;
  final VoidCallback? onGoogleSignIn, onFacebookSignIn, onAppleSignIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          splashColor: AppColors.kPrimaryColor.withAlpha(100),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onGoogleSignIn,
          icon: Image.asset(
            AppAssets.googleIcon,
            width: deviceWidth! * 0.09,
            fit: BoxFit.cover,
          ),
        ),
        IconButton(
          splashColor: AppColors.kPrimaryColor.withAlpha(100),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onFacebookSignIn,
          icon: Icon(
            Icons.facebook_outlined,
            size: 50,
            color: AppColors.kPrimaryColor,
          ),
        ),
        IconButton(
          onPressed: onAppleSignIn,
          icon: Icon(
            Icons.apple_outlined,
            size: 50,
            color: AppColors.kBlackColor,
          ),
        ),
      ],
    );
  }
}
