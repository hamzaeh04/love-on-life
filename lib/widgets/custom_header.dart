

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

Widget customHeader(String title,{double? padding}){
  return Row(
    children: [
      InkWell(
        onTap: (){
          Get.back();
        },
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
            padding: EdgeInsets.all(1.w),
            child: Icon(Icons.arrow_back,size: 19.sp),
          ),
        ),
      ),
      SizedBox(width: padding!=null ? padding : 24.w),
      customText(
        text: title,
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
      ),
    ],
  );
}
