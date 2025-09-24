import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants_widgets.dart';
import '../views/dashboard_screens/home_screen.dart';
import 'custom_button.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';

Widget discoverWidget({
  required String imagePath,
  required String eventName,
  required String description,
  required String tag,
  required String noOfPeople,
  String? date,
  String? time,
  String? ticketPrice,
  String? ticketsLeft,
  VoidCallback? onViewLocation,
  VoidCallback? onJoinNow,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(13.sp),
      border: Border.all(
        color: textfieldBorderColor,
        width: 0.2.w,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13.sp),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 2.h,
                    left: 3.w,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.sp),
                        color: whiteColor
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.4.h),
                        child: customText(
                          text: tag,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                ),
                Positioned(
                    bottom: 2.h,
                    right: 3.w,
                    child: homeShareWidget("assets/png/home_icons/heart_icon.png",width: 4.w,height: 2.h,hori: 1.5.w),
                ),
                Positioned(
                  bottom: 6.h,
                  right: 3.w,
                  child: homeShareWidget("assets/png/home_icons/share_icon.png",width: 4.w,height: 2.h,hori: 1.5.w),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    customText(
                      text: eventName ?? "",
                      fontFamily: 'dmsans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    customText(
                      text: noOfPeople ?? "",
                      fontFamily: 'dmsans',
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: 0.2.h),
                customText(
                  text: description ?? "",
                  fontFamily: 'dmsans',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 1.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 🔹 Date & Time
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 3.w, top: 1.h, bottom: 1.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: const Color(0xFFD9F3FB),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/png/event_detail_icon/date&time.png',
                              width: 7.5.w,
                            ),
                            SizedBox(width: 3.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  text: date ?? "",
                                  fontFamily: 'dmsans',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                customText(
                                  text: time ?? "",
                                  fontFamily: 'dmsans',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),

                    // 🔹 Tickets
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: const Color(0xFFFFE4F8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 3.w, top: 1.h, bottom: 1.h),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/png/bottom_nav_icon/ticket.png',
                                    width: 5.w,
                                    color: buttonPinkColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: ticketPrice ?? "",
                                    fontFamily: 'dmsans',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  customText(
                                    text: ticketsLeft ?? "",
                                    fontFamily: 'dmsans',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: customButton(
                        "View Location",
                        color: blackColor,
                        fontweight: FontWeight.w500,
                        fontsize: 15.sp,
                        height: 5.h,
                        textColor: whiteColor,
                        ontap: onViewLocation,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: customButton(
                        "Join Now",
                        color: buttonPinkColor,
                        fontweight: FontWeight.w500,
                        fontsize: 15.sp,
                        height: 5.h,
                        textColor: whiteColor,
                        ontap: onJoinNow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



