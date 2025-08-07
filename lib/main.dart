import 'package:admin_dashboard/core/observer/my_bloc_observer.dart';
import 'package:admin_dashboard/core/routes/app_routes_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024), // Common web design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
      return MaterialApp.router(
        title: 'Our Market Admin Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        routerConfig: AppRoutesConfig.router,
      );
      },
    );
  }
}
