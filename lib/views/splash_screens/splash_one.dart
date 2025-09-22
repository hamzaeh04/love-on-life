import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/splash_controller.dart';
import 'package:sizer/sizer.dart';

class SplashOne extends StatelessWidget {
  const SplashOne({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController("getstarted"));
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
