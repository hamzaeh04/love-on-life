import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'custom_button.dart';
import 'ticketClipper.dart';

void showTicketDialog(BuildContext context,
    {String? title, String? ticketNumber, String? time, String? date, String? price, String? ticketLeft}) {
  showDialog(
    context: context,
    barrierColor:
    Colors.transparent, // make barrier transparent (no default black dim)
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 4.w), // reduce side padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.none,
          backgroundColor: Colors.transparent, // let TicketWidget control bg
          child: TicketWidget(
            width: double.infinity,
            height: 51.h,
            dyOffset: 15.h,
            isCornerRounded: true,
            color: whiteColor,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 🔹 QR code half inside, half outside
                Positioned(
                  top: -8.5.h, // adjust karke half andar half bahar kar lega
                  right: 0.w,
                  left: 0.w,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipOval(
                      clipBehavior: Clip.none,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: containerPinkColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/png/event_detail_icon/qrcode.png',
                          width: 18.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 9.5.h,
                  right: 0.w,
                  left: 0.w,
                  child: Image.asset(
                    'assets/png/home_icons/line.png',
                    height: 0.136.h,
                  ),
                ),Positioned(
                    top: 1.h,
                    right: 2.2.w,
                    child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(Icons.cancel, color: Colors.black.withOpacity(0.3),))
                ),

                // 🔹 Main content inside ticket
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 👇 ye aapki Row aur Date/Ticket row as it is
                      SizedBox(height: 6.5.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.3.h),
                            child: customText(
                              text: title ?? "Leadership Skills",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Padding(
                            padding: EdgeInsets.only(top: 0.6.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: lightPurple,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 1.5.w,
                                  vertical: 0.3.h,
                                ),
                                child: customText(
                                  text: ticketNumber ?? "GBD998",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: darkPurpleColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 0.8.h),

                      // 🔹 Date & Tickets row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Date & Time
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 3.w,
                                top: 1.h,
                                bottom: 1.h,
                              ),
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        customText(
                                          text: date ?? "10 Sep, 2025",
                                          fontFamily: 'dmsans',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        customText(
                                          text: time ?? "12:00 AM - 2:00 PM",
                                          fontFamily: 'dmsans',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),

                          // Tickets
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: const Color(0xFFFFE4F8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 3.w,
                                  top: 1.h,
                                  bottom: 1.h,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                        child: Image.asset(
                                          'assets/png/bottom_nav_icon/ticket.png',
                                          width: 5.w,
                                          color: buttonPinkColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          customText(
                                            text: price ?? "\$ 40",
                                            fontFamily: 'dmsans',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          customText(
                                            text: ticketLeft ?? "5 Tickets Purchase",
                                            fontFamily: 'dmsans',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.5.h),

                      // 🔹 Naya container niche
                      customText(
                          text: 'Location',
                          fontFamily: 'dmsans',
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp
                      ),
                      SizedBox(height: 0.6.h),
                      Container(
                        child: Image.asset('assets/png/home_icons/map.png'),
                      ),

                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Image.asset(
                            "assets/png/home_icons/barcode.png",
                            width: 18.w,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: customButton(
                              "Cancel  ",
                              color: ticketGreyColor,
                              fontweight: FontWeight.w500,
                              fontsize: 14.sp,
                              textColor: blackColor,
                              height: 4.h,
                              ontap: () {
                                Get.back();
                              },
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: customButton(
                              "Pay  ",
                              color: ticketBlueColor,
                              fontweight: FontWeight.w500,
                              fontsize: 14.sp,
                              textColor: whiteColor,
                              height: 4.h,
                              ontap: () {
                                Get.toNamed("card");
                              },
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
        ),
      );
    },
  );
}