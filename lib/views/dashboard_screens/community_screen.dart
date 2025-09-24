import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 4.w, top: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                customText(
                    text: 'Community',
                    fontFamily: 'dmsans',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700
                ),
                Spacer(),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4.w),
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
                      height: 4.h,
                      width: 8.5.w,
                      decoration: BoxDecoration(
                        //color: Colors.yellow,
                          shape: BoxShape.circle,
                          border: Border.all(color: textfieldBorderColor, width: 0.3.w)
                      ),
                      child: Image.asset('assets/png/bell_icon.png',),
                    ),
                    Positioned(
                      right: 6.w,
                        top: 0.7.h,
                        child: Image.asset('assets/png/bell_icon2.png', width: 2.w,)
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 2.h,),
            customText(
                text: 'Create Post',
                fontFamily: 'dmsans',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
            ),
            createPost()
          ],
        ),
      ),
    );
  }
}
Widget createPost() {
  return Container(
    margin: EdgeInsets.only(right: 4.w, top: 0.25.h),
    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.7.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.sp),
      border: Border.all(color: textfieldBorderColor)
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 0.15.h,
            ),
            customText(
              text: 'Participant',
              fontFamily: 'dmsans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF83848D),
            ),
          ],
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 0.7.h,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: publicButtonColor,
            border: Border.all(color: textfieldBorderColor),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customText(
                    text: 'Public',
                    fontFamily: 'dmsans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(width: 1.w),
                  Icon(Icons.keyboard_arrow_down, size: 14.sp,)
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
