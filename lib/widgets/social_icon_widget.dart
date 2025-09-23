import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

Widget socialIconWidget(String path){
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(30.sp),
        border: Border.all(
          color: textfieldBorderColor,
          width: 0.2.w
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 1.7.h),
        child: Image.asset(path,width: 6.w),
      ),
    ),
  );
}
