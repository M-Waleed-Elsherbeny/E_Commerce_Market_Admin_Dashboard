import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/features/home/widgets/custom_card_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Home View", canPop: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              CustomCardChooser(
                onPressed: () {
                  context.pushNamed(AppRoutes.productsView);
                },
                title: "Products",
                icon: Icons.shopping_bag,
              ),
              CustomCardChooser(
                onPressed: () {},
                title: "Add Product",
                icon: Icons.add_circle,
              ),
              CustomCardChooser(
                onPressed: () {},
                title: "Add a New Admin",
                icon: Icons.admin_panel_settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
