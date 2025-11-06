import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget communityPost(
    String path,
    String title,
    String name,
    String time,
    String path2,
    String mainImage,
    {
      bool? isGroup = false,
      bool? isGroupOnly = true,
      bool? isFollow = true,
    }) {
  return Container(
    margin: EdgeInsets.only(right: 4.w),
    width: double.infinity,
    decoration: BoxDecoration(

    ),
    child: Column(
      children: [
        Row(
          children: [
            isGroup == true ? Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.sp),
                  ),
                  child: Image.asset(path, width: 10.w),
                ),
                isGroupOnly == true ? Positioned(
                  bottom: 0.h,
                  right: -1.2.w,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //border: Border.all(color: Colors.white, width: 0.5.w)
                    ),
                    child: Image.asset(path2, width: 5.5.w),
                  ),
                ): SizedBox.shrink()
              ],
            ): Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(11.sp),
              ),
              child: Image.asset(path, width: 10.w),
            ),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: title,
                  fontFamily: 'dmsans',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                (isGroup == true || isGroupOnly == false) ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customText(
                        text: name,
                        fontFamily: 'dmsans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF666666),
                        height: 0.05
                    ),
                    SizedBox(width: 2.4.w), // spacing before divider
                    Container(
                      width: 0.1.w, // thickness of line
                      height: 1.h, // height of divider
                      color: Color(0xFF666666),
                    ),
                    SizedBox(width: 2.4.w), // spacing after divider
                    customText(
                      text: time,
                      fontFamily: 'dmsans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666),
                    ),
                  ],
                ):customText(
                  text: time,
                  fontFamily: 'dmsans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF666666),
                ),
              ],
            ),
            Spacer(),
            if(isFollow!)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.sp),
                  color: joinButtonColor,
                ),
                child: customText(
                  text: isGroup == true ? 'Join' : 'Follow',
                  color: Color(0xFF34A0C2),
                  fontFamily: 'dmsans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            SizedBox(width: 2.w),
            Image.asset(
              'assets/png/community_icon/DotsThreeVertical.png',
              width: 7.w,
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.sp),
          child: Image.asset(
            mainImage,
            height: 32.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/png/community_icon/Like.png', width: 5.5.w),
              SizedBox(width: 2.w),
              customText(
                text: 'Like',
                color: Color(0xFF000000),
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 12.w),
              Image.asset('assets/png/community_icon/Comment.png', width: 5.5.w),
              SizedBox(width: 2.w),
              customText(
                text: 'Comments',
                color: Color(0xFF000000),
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(width: 12.w),
              Image.asset(
                'assets/png/community_icon/Messanger.png',
                width: 5.5.w,
              ),
              SizedBox(width: 2.w),
              customText(
                text: 'Share',
                color: Color(0xFF000000),
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        SizedBox(height: 0.5.h),
        Row(
          children: [
            Container(
              child: Image.asset(
                'assets/png/community_icon/Oval.png',
                width: 4.5.w,
              ),
            ),
            SizedBox(width: 2.w,),
            customText(
              text: 'Liked by ',
              fontFamily: 'dmsans',
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w400,
            ),
            customText(
              text: 'craig_love',
              fontFamily: 'dmsans',
              fontSize: 13.5.sp,
              fontWeight: FontWeight.bold,
              txtDecoration: TextDecoration.underline,
            ),
            customText(
              text: ' and ',
              fontFamily: 'dmsans',
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w400,
            ),
            customText(
              text: '44,686 others',
              fontFamily: 'dmsans',
              fontSize: 13.5.sp,
              fontWeight: FontWeight.bold,
              txtDecoration: TextDecoration.underline,
            ),
          ],
        ),
        SizedBox(height: 0.6.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'joshua_l ',
                    style: TextStyle(
                      fontFamily: 'dmsans',
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.black, // required in TextSpan
                    ),
                  ),
                  TextSpan(
                    text:
                    'The game in Japan was amazing and I want to\nshare some photos',
                    style: TextStyle(
                      fontFamily: 'dmsans',
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}