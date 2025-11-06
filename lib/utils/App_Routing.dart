import 'package:get/get.dart';
import 'package:love_on_life/views/auth_screens/forgot_pasword_screen.dart';
import 'package:love_on_life/views/auth_screens/login_screen.dart';
import 'package:love_on_life/views/auth_screens/reset_pass_screen.dart';
import 'package:love_on_life/views/auth_screens/signup_screen.dart';
import 'package:love_on_life/views/dashboard_screens/bottom_nav_bar.dart';
import 'package:love_on_life/views/dashboard_screens/event_details_screen.dart';
import 'package:love_on_life/views/payment_method_screens/select_card_screen.dart';
import 'package:love_on_life/views/splash_screens/get_started.dart';

import '../views/auth_screens/verification_code_screen.dart';
import '../views/splash_screens/splash_one.dart';
class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/', page: () => SplashOne()),
    GetPage(name: '/getstarted', page: () => GetStarted()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignupScreen()),
    GetPage(name: '/verification', page: () => VerificationCodeScreen()),
    GetPage(name: '/forgot', page: () => ForgotPassScreen()),
    GetPage(name: '/reset', page: () => ResetPassScreen()),
    GetPage(name: '/bottomnavbar', page: () => BottomNavBar()),
    GetPage(name: '/event', page: () => EventDetailsScreen()),
    GetPage(name: '/card', page: () => SelectCardScreen()),


    //
  ];
}
