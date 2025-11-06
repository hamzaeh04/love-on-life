import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

Widget socialIconWidget(String path,{VoidCallback? ontap}){
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
        color: whiteColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: textfieldBorderColor,
          width: 0.2.w
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.7.h),
        child: Image.asset(path,width: 6.w),
      ),
    ),
  );
}

