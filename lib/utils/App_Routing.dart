import 'package:get/get.dart';
import 'package:love_on_life/views/splash_screens/get_started.dart';

import '../views/splash_screens/splash_one.dart';
class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/', page: () => SplashOne()),
    GetPage(name: '/getstarted', page: () => GetStarted()),

    //
  ];
}
