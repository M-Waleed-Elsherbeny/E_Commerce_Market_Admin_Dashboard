import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/features/add_products/widgets/custom_add_product.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Add New Product"),
      body: const CustomAddProduct(),
    );
  }
}
