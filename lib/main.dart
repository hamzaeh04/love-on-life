import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/controllers/navigation_controller.dart';
import 'package:love_on_life/controllers/payment_controller.dart';
import 'package:love_on_life/utils/App_Routing.dart';
import 'package:love_on_life/utils/init_binding.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());   // 👈 Only this
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          initialBinding: Binding(),   // 👈 All controllers injected here
          initialRoute: '/',
          getPages: AppRoutes.routes,
          title: "Flutter App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
          ),
        );
      },
    );
  }
}
