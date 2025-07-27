import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/features/auth/view/login_view.dart';
import 'package:admin_dashboard/features/home/view/home_view.dart';
import 'package:admin_dashboard/features/products/view/products_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRoutesConfig {
  static final SupabaseClient client = Supabase.instance.client;
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.loginScreen,
    errorBuilder:
        (context, state) => const Scaffold(body: Center(child: Text('Error'))),
    routes: <RouteBase>[
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        name: AppRoutes.productsView,
        path: AppRoutes.productsView,
        builder: (BuildContext context, GoRouterState state) {
          return const ProductsView();
        },
      ),
      // GoRoute(
      //   name: AppRoutes.editProfileScreen,
      //   path: AppRoutes.editProfileScreen,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const EditProfileView();
      //   },
      // ),
      // GoRoute(
      //   name: AppRoutes.myOrdersView,
      //   path: AppRoutes.myOrdersView,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const MyOrdersView();
      //   },
      // ),
      // GoRoute(
      //   name: AppRoutes.productDetailsScreen,
      //   path: AppRoutes.productDetailsScreen,
      //   builder: (BuildContext context, GoRouterState state) {
      //     final HomeProductsModel productsModel =
      //         state.extra as HomeProductsModel;
      //     return ProductDetailsScreen(productsModel: productsModel);
      //   },
      // ),
    ],
  );
}
