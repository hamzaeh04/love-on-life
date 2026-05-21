import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/splash_controller.dart';
import 'package:love_on_life/outh_file/local_db_key.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:sizer/sizer.dart';

class SplashOne extends StatelessWidget {
  SplashOne({super.key});
  final prefs = SharedPreferencesMethod.storage;
  @override
  Widget build(BuildContext context) {
    final hasAccepted = prefs.getBool(LocalDBKeys.FIRSTTIMEOPENAPP) ?? false;
    print("First ${hasAccepted}");
    Get.put(SplashController(hasAccepted ? "/getstarted" : "/term"));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF030C1A),
              Color(0xFF09395B),
            ],
            stops: [0.4, 1],
          ),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/png/splash_one_logo.png",height: 27.h,width: 80.w),
            Image.asset("assets/png/splash_two_logo.png",height: 13.h,width: 80.w),
          ],
        )
      ),
    );
  }
}
