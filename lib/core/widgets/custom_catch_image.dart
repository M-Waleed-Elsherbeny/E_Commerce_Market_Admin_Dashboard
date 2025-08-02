import 'package:admin_dashboard/core/widgets/custom_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({super.key, required this.url, this.height});
  final String url;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200.h,
      width: double.infinity,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        placeholder: (context, url) => const CustomLoading(),
        errorWidget:
            (context, url, error) =>
            Image.network("https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png"),
                // const Icon(Icons.error, color: AppColors.kRedColor),
      ),
    );
  }
}
