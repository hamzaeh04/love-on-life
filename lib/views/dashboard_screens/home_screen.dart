import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:love_on_life/widgets/custom_app_bar.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// 👇 Yeh pura area blur hoga (7.h space + Row)
          customAppBar(),
          SizedBox(height: 1.h),
          customText(
            text: 'Events Near by You',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              homeShareWidget("assets/png/home_icons/share_icon.png"),
              SizedBox(width: 2.w),
              homeShareWidget("assets/png/home_icons/heart_icon.png"),
              SizedBox(width: 2.w),
              customButton(
                "Join Now",
                color: buttonPinkColor,
                fontweight: FontWeight.w700,
                fontsize: 16.sp,
                textColor: whiteColor,
                height: 5.h,
                width: 35.w,
                ontap: () {},
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                customText(
                  text: 'Community Feed',
                  fontFamily: 'dmsans',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
                Spacer(),
                moreContainer("This week"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [moreContainer("Load more")]),
        ],
      ),
    );
  }



  Widget moreContainer(String title, {VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.yellow,
          color: whiteColor,
          borderRadius: BorderRadius.circular(25.sp),
          border: Border.all(color: textfieldBorderColor, width: 0.2.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
          child: Row(
            children: [
              customText(
                text: title,
                fontFamily: 'dmsans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              Icon(Icons.keyboard_arrow_down_rounded, size: 16.sp),
            ],
          ),
        ),
      ),
    );
  }
}
Widget homeShareWidget(String path,{double? height, double? width,double? hori,double? vert}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hori??2.5.w, vertical: vert??1.h),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: whiteColor,
      border: Border.all(color: textfieldBorderColor, width: 0.3.w),
    ),
    child: Center(child: Image.asset(path, width: width ?? 6.w, height: height ?? 3.h)),
  );
}
