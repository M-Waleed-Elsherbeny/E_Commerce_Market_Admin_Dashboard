import 'package:admin_dashboard/core/routes/app_routes.dart';
import 'package:admin_dashboard/features/add_products/view/add_products_view.dart';
import 'package:admin_dashboard/features/auth/cubit/cubit/admin_authentication_cubit.dart';
import 'package:admin_dashboard/features/auth/view/add_admin_view.dart';
import 'package:admin_dashboard/features/auth/view/login_view.dart';
import 'package:admin_dashboard/features/home/view/home_view.dart';
import 'package:admin_dashboard/features/products/cubit/cubit/products_cubit.dart';
import 'package:admin_dashboard/features/products/models/home_products_model.dart';
import 'package:admin_dashboard/features/products/view/comments_view.dart';
import 'package:admin_dashboard/features/products/view/edit_product_view.dart';
import 'package:admin_dashboard/features/products/view/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutesConfig {
  // static final SupabaseClient client = Supabase.instance.client;
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.loginScreen,
    errorBuilder:
        (context, state) => const Scaffold(body: Center(child: Text('Error'))),
    routes: <RouteBase>[
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => AdminAuthenticationCubit(),
            child: const LoginView(),
          );
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
          return BlocProvider(
            create: (context) => ProductsCubit()..getAllProducts(),
            child: const ProductsView(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.editProductsView,
        path: AppRoutes.editProductsView,
        builder: (BuildContext context, GoRouterState state) {
          HomeProductsModel productsModel = state.extra as HomeProductsModel;
          return BlocProvider(
            create: (context) => ProductsCubit(),
            child: EditProductView(productsModel: productsModel),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.commentsView,
        path: AppRoutes.commentsView,
        builder: (BuildContext context, GoRouterState state) {
          return const CommentsView();
        },
      ),
      GoRoute(
        name: AppRoutes.addProductsView,
        path: AppRoutes.addProductsView,
        builder: (BuildContext context, GoRouterState state) {
          return const AddProductView();
        },
      ),
      GoRoute(
        name: AppRoutes.addAdminView,
        path: AppRoutes.addAdminView,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => AdminAuthenticationCubit(),
            child: const AddAdminView(),
          );
        },
      ),
    ],
  );
}
