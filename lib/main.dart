import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/controllers/navigation_controller.dart';
import 'package:love_on_life/controllers/payment_controller.dart';
import 'package:love_on_life/controllers/ticket_controller.dart';
import 'package:love_on_life/utils/App_Routing.dart';
import 'package:love_on_life/utils/init_binding.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'controllers/community_controller.dart';
import 'controllers/drawer_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesMethod.init();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs);
  runApp(const MyApp());   // 👈 Only this
  // 👇 These ensure all controllers are available globally
  Get.put(NavigationController());
  Get.put(DashboardController());
  Get.put(AuthController());
  Get.put(Drawercontroller());
  Get.put(PaymentController());// Put into GetX dependency
  Get.put(CommunityController());// Put into GetX dependency
  Get.put(TicketController());// Put into GetX dependency
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
          builder: EasyLoading.init(),
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
