import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget createPost() {
  return Container(
    margin: EdgeInsets.only(right: 4.w),
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12.sp),
      border: Border.all(color: textfieldBorderColor),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 9.w,
              width: 9.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //color: Colors.yellow
              ),
              child: Image.asset('assets/png/profile.png'),
            ),
            SizedBox(width: 1.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                customText(
                  text: 'Eddie Sanz',
                  fontFamily: 'dmsans',
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                  height: 0.15.h,
                ),
                customText(
                  text: 'Participant',
                  fontFamily: 'dmsans',
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF83848D),
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.7.h),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                color: publicButtonColor,
                border: Border.all(color: textfieldBorderColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customText(
                    text: 'Public',
                    fontFamily: 'dmsans',
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(width: 1.w),
                  Icon(Icons.keyboard_arrow_down, size: 14.5.sp),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 0.2.h),
        TextField(
          decoration: InputDecoration(
            hintText: 'Write something about the events',
            hintStyle: TextStyle(
              fontFamily: 'dmsans',
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF83848D),
            ),
            border: InputBorder.none, // removes underline/border
            isDense: true, // removes extra vertical padding
            contentPadding: EdgeInsets.zero, // removes internal padding
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            children: [
              Image.asset('assets/png/Image.png', width: 5.w),
              SizedBox(width: 2.5.w),
              customText(
                text: 'Image/video',
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 10.w),
              Image.asset('assets/png/location.png', width: 5.w),
              SizedBox(width: 2.5.w),
              customText(
                text: 'Check-in',
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 10.w),
              Image.asset('assets/png/CheckCircle.png', width: 5.w),
              SizedBox(width: 2.5.w),
              customText(
                text: 'Activity',
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
