import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/features/products/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Products View"),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CustomProductCard();
        },
      ),
    );
  }
}
