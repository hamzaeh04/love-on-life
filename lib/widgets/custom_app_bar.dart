import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget customAppBar(String title) {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        height: 13.h, // 🔹 fix height taake blur limited ho
        padding: EdgeInsets.only(top: 7.h, left: 4.w, right: 4.w, bottom: 1.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2), // frosted effect
        ),
        child: Row(
          children: [
            /// Location
            Image.asset("assets/png/home_icons/header_profile.png", width: 10.w, fit: BoxFit.contain,),
            Spacer(),
            customText(
              text: title,
              fontFamily: 'dmsans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),

            Spacer(),

            /// Bell Icon
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
                  height: 4.5.h,
                  width: 8.5.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    border: Border.all(color: textfieldBorderColor, width: 0.3.w),
                  ),
                  child: Image.asset('assets/png/bell_icon.png', width: 2.5.w, height: 2.5.h),
                ),
                Positioned(
                  right: 2.2.w,
                  top: 1.h,
                  child: Image.asset('assets/png/bell_icon2.png', width: 1.6.w),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
