import 'package:easylifeapp/admin/screens/admin_screen.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/router.dart';
import 'package:easylifeapp/screens/splash_screen.dart';
import 'package:easylifeapp/serviceman/screens/serviceman_screen.dart';
import 'package:easylifeapp/services/auth_service.dart';
import 'package:easylifeapp/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'EasyLife.com',
            onGenerateRoute: (settings) => generateRoute(settings),
            home: Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? Provider.of<UserProvider>(context).user.type == 'Customer'
                    ? const BottomBar()
                    : Provider.of<UserProvider>(context).user.type == 'Admin'
                        ? const AdminScreen()
                        : const ServicemanScreen()
                : const SplashScreen());
      },
    );
  }
}
