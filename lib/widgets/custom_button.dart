import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

Widget customButton(String text,{String? path,Color? color,FontWeight? fontweight,double? fontsize,Color? textColor,VoidCallback? ontap,double? height,double? width}){
 return InkWell(
   onTap: ontap,
   child: Container(
     height: height ?? 6.h,
     width: width ?? double.infinity,
     decoration: BoxDecoration(
       color: color!=null ? color : whiteColor,
       borderRadius: BorderRadius.circular(25.sp),
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         path != null
             ? Image.asset(
           path,
           height: 5.h,
           width: 5.w,
         )
             : const SizedBox.shrink(), // empty widget if path is null
         SizedBox(width: 2.w),
         customText(
           text: text,
           fontWeight: fontweight!=null ? fontweight : FontWeight.w400,
           fontSize: fontsize!=null ? fontsize : 15.sp,
           color: textColor!=null ? textColor : blackColor,
         ),
       ],
     ),
   ),
 );
}
