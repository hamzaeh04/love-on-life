import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget customAppBar(){
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        padding: EdgeInsets.only(top: 7.h, left: 4.w, right: 4.w, bottom: 1.5.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          // frosted effect
        ),
        child: Row(
          children: [
            /// Location
            Row(
              children: [
                Image.asset("assets/png/pinpoint_icon.png", width: 9.w),
                SizedBox(width: 2.w),
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: 'Your Location',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.12.h,
                      ),
                      Row(
                        children: [
                          customText(
                            text: 'Metropolitan, DC ',
                            fontFamily: 'dmsans',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Spacer(),

            /// Bell Icon
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
                  height: 4.h,
                  width: 8.5.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    border: Border.all(color: textfieldBorderColor, width: 0.3.w),
                  ),
                  child: Image.asset('assets/png/bell_icon.png', width: 2.w, height: 2.h),
                ),
                Positioned(
                  right: 2.2.w,
                  top: 0.8.h,
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
