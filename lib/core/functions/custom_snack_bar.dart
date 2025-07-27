import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor = Colors.green,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}
