import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants_widgets.dart';
import '../views/dashboard_screens/home_screen.dart';
import 'custom_button.dart';

Widget discoverWidget({
  int? index, // 👈 optional index now
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
  final DashboardController dashboardController = Get.find<DashboardController>();

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
                Image.asset(imagePath, fit: BoxFit.cover),

                // 🔹 Tag
                Positioned(
                  bottom: 2.h,
                  left: 3.w,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.sp),
                      color: whiteColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
                      child: customText(
                        text: tag,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // 🔹 Favourite (Heart) Icon
                Positioned(
                  bottom: 2.h,
                  right: 3.w,
                  child: GestureDetector(
                    onTap: () => dashboardController.toggleFavorite(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.25.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                        border: Border.all(color: textfieldBorderColor, width: 0.3.w),
                      ),
                      child: Obx(() {
                        bool isFav = dashboardController.isFavorite(index);
                        return Icon(
                          isFav ? Icons.favorite : Icons.favorite_border_outlined,
                          size: 17.sp,
                          color: isFav ? buttonPinkColor : Colors.grey,
                        );
                      }),
                    ),
                  ),
                ),

                // 🔹 Share Icon
                Positioned(
                  bottom: 6.h,
                  right: 3.w,
                  child: homeShareWidget(
                    "assets/png/home_icons/share_icon.png",
                    width: 4.w,
                    height: 2.h,
                    hori: 1.5.w,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),

          // 🔹 Event Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    customText(
                      text: eventName,
                      fontFamily: 'dmsans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    customText(
                      text: noOfPeople,
                      fontFamily: 'dmsans',
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: 0.2.h),
                customText(
                  text: description,
                  fontFamily: 'dmsans',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 1.h),

                // 🔹 Buttons
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
