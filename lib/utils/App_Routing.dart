import 'package:get/get.dart';
import 'package:love_on_life/views/auth_screens/forgot_pasword_screen.dart';
import 'package:love_on_life/views/auth_screens/login_screen.dart';
import 'package:love_on_life/views/auth_screens/reset_pass_screen.dart';
import 'package:love_on_life/views/auth_screens/signup_screen.dart';
import 'package:love_on_life/views/dashboard_screens/bottom_nav_bar.dart';
import 'package:love_on_life/views/dashboard_screens/event_details_screen.dart';
import 'package:love_on_life/views/menu_screens/profile_screens/change_password.dart';
import 'package:love_on_life/views/menu_screens/profile_screens/edit_profile.dart';
import 'package:love_on_life/views/payment_method_screens/payment_detail_screen.dart';
import 'package:love_on_life/views/payment_method_screens/select_card_screen.dart';
import 'package:love_on_life/views/splash_screens/get_started.dart';

import '../views/auth_screens/verification_code_screen.dart';
import '../views/search_screens/event_screen.dart';
import '../views/search_screens/favorite_screen.dart';
import '../views/search_screens/search_screens.dart';
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
    GetPage(name: '/payment', page: () => PaymentDetailScreen()),
    GetPage(name: '/edit', page: () => EditProfile()),
    GetPage(name: '/change', page: () => ChangePassword()),
    GetPage(name: '/search', page: () => SearchScreen()),
    GetPage(name: '/favorite', page: () => FavoriteScreen()),
    GetPage(name: '/myevent', page: () => EventScreen()),

    //
  ];
}
