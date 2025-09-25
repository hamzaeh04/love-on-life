import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:love_on_life/widgets/custom_app_bar.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:love_on_life/widgets/events_carousal.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/ticketClipper.dart';
import 'community_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable area starts from here
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 4.w),
                    child: customText(
                      text: 'Events Near by You',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                   EventsCarousel(),
                  SizedBox(height: 2.h),
                  // Horizontal buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeShareWidget("assets/png/home_icons/share_icon.png"),
                      SizedBox(width: 2.w),
                      homeShareWidget("assets/png/home_icons/heart_icon.png"),
                      SizedBox(width: 2.w),
                      customButton(
                        "Join Now",
                        color: buttonPinkColor,
                        fontweight: FontWeight.w700,
                        fontsize: 16.sp,
                        textColor: whiteColor,
                        height: 5.h,
                        width: 35.w,
                        ontap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  // Community Feed header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: [
                        customText(
                          text: 'Community Feed',
                          fontFamily: 'dmsans',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        Spacer(),
                        moreContainer("This week"),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Feed posts
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        communityPost(
                          'assets/png/community_icon/person3.png',
                          'Youth Influencer',
                          'Rufus Schulist',
                          '8 mins',
                          'assets/png/community_icon/person1.png',
                          'assets/png/event_detail_icon/people2.jpg',
                          isFollow: false,
                        ),

                        SizedBox(height: 1.h),
                        Divider(),
                        SizedBox(height: 1.h),
                        communityPost(
                          'assets/png/community_icon/person3.png',
                          'Youth Influencer',
                          'Rufus Schulist',
                          '8 mins',
                          'assets/png/community_icon/person1.png',
                          'assets/png/event_detail_icon/people2.jpg',
                          isFollow: false
                        ),
                        SizedBox(height: 1.h),
                        Divider(),
                      ],
                    ),
                  ),
                  // Load more button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [moreContainer("Load more")],
                  ),

                  SizedBox(height: 12.h), // bottom padding
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: customAppBar(),
          ),
        ],
      ),
    );
  }
}




  Widget moreContainer(String title, {VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.yellow,
          color: whiteColor,
          borderRadius: BorderRadius.circular(25.sp),
          border: Border.all(color: textfieldBorderColor, width: 0.2.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
          child: Row(
            children: [
              customText(
                text: title,
                fontFamily: 'dmsans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              Icon(Icons.keyboard_arrow_down_rounded, size: 16.sp),
            ],
          ),
        ),
      ),
    );
  }
Widget homeShareWidget(String path,{double? height, double? width,double? hori,double? vert}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hori??2.5.w, vertical: vert??1.h),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: whiteColor,
      border: Border.all(color: textfieldBorderColor, width: 0.3.w),
    ),
    child: Center(child: Image.asset(path, width: width ?? 6.w, height: height ?? 3.h)),
  );
}


