import 'package:get/get.dart';
import 'package:love_on_life/views/auth_screens/login_screen.dart';
import 'package:love_on_life/views/auth_screens/reset_pass_screen.dart';
import 'package:love_on_life/views/dashboard_screens/bottom_nav_bar.dart';
import 'package:love_on_life/views/dashboard_screens/community_screen.dart';
import 'package:love_on_life/views/dashboard_screens/event_details_screen.dart';
import 'package:love_on_life/views/dashboard_screens/profile_screen.dart';
import 'package:love_on_life/views/splash_screens/get_started.dart';

import '../views/auth_screens/forget_pass_screen.dart';
import '../views/splash_screens/splash_one.dart';
class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/', page: () => SplashOne()),
    GetPage(name: '/getstarted', page: () => GetStarted()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/forgot', page: () => ForgetPassScreen()),
    GetPage(name: '/reset', page: () => ResetPassScreen()),
    GetPage(name: '/bottomnavbar', page: () => BottomNavBar()),
    GetPage(name: '/profile', page: () => ProfileScreen()),
    GetPage(name: '/community', page: () => CommunityScreen()),
    GetPage(name: '/event', page: () => EventDetailsScreen()),
    //
  ];
}
