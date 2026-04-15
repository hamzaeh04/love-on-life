import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:love_on_life/config/stripe_keys.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/controllers/navigation_controller.dart';
import 'package:love_on_life/controllers/payment_controller.dart';
import 'package:love_on_life/controllers/ticket_controller.dart';
import 'package:love_on_life/core/services/login/google_auth_service.dart';
import 'package:love_on_life/core/services/notification/notification_service.dart';
import 'package:love_on_life/firebase_options.dart';
import 'package:love_on_life/utils/App_Routing.dart';
import 'package:love_on_life/utils/init_binding.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'controllers/community_controller.dart';
import 'controllers/drawer_controller.dart';
import 'controllers/notification_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/stripe_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesMethod.init();
  final googleAuthService = GoogleAuthService();
  googleAuthService.initService(
    clientId: "813161449252-eq01riueph9mjsgnkkg17f9g2ci7mcqp.apps.googleusercontent.com",
    serverClientId: "813161449252-d1kbnk7ct7q3a55g1parudfg23d7250h.apps.googleusercontent.com"
  );

  Stripe.publishableKey = StripeKeys.publishableKey;
  // 2️⃣ Apply the settings (mandatory)
  await Stripe.instance.applySettings();
  if(Platform.isAndroid || Platform.isIOS){
    FirebaseNotification notification = FirebaseNotification();
    await notification.initLocalNotification();
    await notification.initNotification();
    notification.onTokenRefresh();
    FirebaseMessaging.onBackgroundMessage(firebaseMessageBackgroundHandler);
  }

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs);
  // Lock app orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // optional, if you want upside-down too
  ]);
  Get.put(NotificationController());
  Get.put(NavigationController());
  Get.put(DashboardController());
  Get.put(AuthController());
  Get.put(Drawercontroller());
  Get.put(CommunityController());// Put into GetX dependency
  Get.put(SearchController2());
  Get.put(PaymentController());// Put into GetX dependency
  Get.put(TicketController());// Put into GetX dependency
  Get.put(StripeController());
  runApp(const MyApp());   // 👈 Only this
  // 👇 These ensure all controllers are available globally

}

@pragma('vm:entry-point')
Future<void> firebaseMessageBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());

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
