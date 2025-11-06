import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget communitySuggestion (String path, String title, String followers){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),

    width: 36.w,
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(14.sp),
        border: Border.all(color: textfieldBorderColor)
    ),
    child:
    Center(
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset(path, width: 9.w,),
          ),
          SizedBox(height: 0.8.h,),
          customText(
            text: title,
            fontFamily: 'dmsans',
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w700,
          ),
          customText(
            text: followers,
            fontFamily: 'dmsans',
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.7),
          ),
          SizedBox(height: 1.2.h,),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.sp),
              color: joinButtonColor,
            ),
            child: customText(

              text: 'Join',
              color: Color(0xFF34A0C2),
              fontFamily: 'dmsans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
  );
}
