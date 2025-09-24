import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants_widgets.dart';

Widget discoverWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 3.h),

      ClipRRect(
        borderRadius: BorderRadius.circular(13.sp),
        child: Image.asset(
          'assets/png/event_detail_icon/people.png',
          fit: BoxFit.cover,
        ),
      ),

      SizedBox(height: 1.h),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: 'Events Details',
            fontFamily: 'dmsans',
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 0.2.h),
          customText(
            text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean\npretium. '
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nAenean pretium. '
                'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Aenean pretium. '
                'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Aenean pretium.',
            fontFamily: 'dmsans',
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),

      SizedBox(height: 2.h),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Date & Time
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: 'Date & Time',
                fontFamily: 'dmsans',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 0.8.h),
              Container(
                padding: EdgeInsets.only(
                    left: 3.w, top: 1.5.h, bottom: 1.5.h, right: 12.w),
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
                          text: '10 Sep, 2025',
                          fontFamily: 'dmsans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        customText(
                          text: '12:00 AM',
                          fontFamily: 'dmsans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 🔹 Attendees
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: 'Attendees',
                fontFamily: 'dmsans',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 0.8.h),
            ],
          ),
        ],
      )
    ],
  );
}
