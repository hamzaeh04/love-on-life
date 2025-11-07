import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeader("Notifications", padding: 22.5.w),
              SizedBox(height: 3.h),

              // 🔽 Filter Bar
              Container(
                decoration: BoxDecoration(
                  color: buttonPinkColor.withOpacity(0.03),
                  border: Border.all(color: selectedContainerColor),
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          customText(
                            text: 'Showing:',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: loginGreyColor,
                          ),
                          SizedBox(width: 2.w),
                          Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(
                                color: notificationGreyColor,
                                width: 0.2.w,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 0.3.h),
                              child: Row(
                                children: [
                                  customText(
                                    text: 'All',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: notificationGreyColor,
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18.sp,
                                    color: notificationGreyColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      customText(
                        text: 'Mark As All Read',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: buttonPinkColor,
                        txtDecoration: TextDecoration.underline,
                        decorationColor: buttonPinkColor,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              // 🔽 Notification 1 (Unread / Highlighted)
              notificationWidget(isRead: false),
              SizedBox(height: 1.h),
              // 🔽 Notification 2 (Read / Grey version)
              notificationWidget(isRead: true),
              SizedBox(height: 1.h),
              notificationWidget(isRead: true),
              SizedBox(height: 1.h),
              // 🔽 Notification 2 (Read / Grey version)
              notificationWidget(isRead: true),
              SizedBox(height: 1.h),
              // 🔽 Notification 2 (Read / Grey version)
              notificationWidget(isRead: true),
              SizedBox(height: 3.h),

              // ✅ You can add more below...
            ],
          ),
        ),
      ),
    );
  }
}




Widget notificationWidget({bool isRead = false}) {
  return Container(
    decoration: BoxDecoration(
      color: isRead ? whiteColor : buttonPinkColor.withOpacity(0.04),
      border: Border.all(
        color: isRead ? notificationGreyColor : buttonPinkColor,
        width: isRead ? 0.1.w : 0.2.w,
      ),
      borderRadius: BorderRadius.circular(15.sp),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Column(
        children: [
          customText(
            text:
            'Sed rhoncus sapien nunc eget odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: blackColor,
          ),
          SizedBox(height: 0.5.h),

          // ✅ Action & Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                text: isRead ? 'Mark As Read' : 'Mark As Unread',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: isRead ? loginGreyColor : buttonPinkColor,
                txtDecoration: TextDecoration.underline,
                decorationColor:
                isRead ? loginGreyColor : buttonPinkColor,
              ),

              Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/png/home_icons/clock_icon.png",
                        width: 3.5.w,
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: '12:45 PM',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: loginGreyColor,
                      ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  Row(
                    children: [
                      Image.asset(
                        "assets/png/home_icons/calender_icon.png",
                        width: 3.5.w,
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: '20 June 2025',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: loginGreyColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
