import 'package:admin_dashboard/core/database/supabase_config.dart';
import 'package:admin_dashboard/core/observer/my_bloc_observer.dart';
import 'package:admin_dashboard/core/routes/app_routes_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          title: 'Our Market Admin Dashboard',
          theme: ThemeData(),
          routerConfig: AppRoutesConfig.router,
        );
      },
    );
  }
}
