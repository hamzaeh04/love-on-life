import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/community_post_widget.dart';
import '../../widgets/community_suggestion_widget.dart';
import '../../widgets/create_post_widget.dart';
import '../../widgets/custom_app_bar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Padding(
            padding: EdgeInsets.only(left: 4.w, top: 8.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 2.h),
                  customText(
                    text: 'Create Post',
                    fontFamily: 'dmsans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.5.h),
                  createPost(),
                  SizedBox(height: 1.5.h),
                  communityPost(
                      'assets/png/community_icon/grpimg1.png',
                      'Youth Influencer',
                      'Rufus Schulist',
                      '8 mins',
                      'assets/png/community_icon/person1.png',
                      'assets/png/community_icon/ticketing-admissions 1.png',
                      isGroup: true,
                      isGroupOnly: true
                  ),
                  SizedBox(height: 1.h),
                  Padding(padding: EdgeInsets.only(right: 4.w), child: Divider()),
                  SizedBox(height: 1.h),
                  communityPost(
                    'assets/png/community_icon/person3.png',
                    'Youth Influencer',
                    'Rufus Schulist',
                    '8 mins',
                    'assets/png/community_icon/person1.png',
                    'assets/png/event_detail_icon/people2.jpg',
                  ),
                  SizedBox(height: 1.h),
                  Padding(padding: EdgeInsets.only(right: 4.w), child: Divider()),
                  SizedBox(height: 1.h),
                  communityPost(
                    'assets/png/community_icon/grpimg1.png',
                    'Youth Influencer',
                    'Rufus Schulist',
                    '8 mins',
                    'assets/png/community_icon/person1.png',
                    'assets/png/event_detail_icon/people2.jpg',
                  ),
                  SizedBox(height: 1.h),
                  Padding(padding: EdgeInsets.only(right: 4.w), child: Divider()),
                  SizedBox(height: 1.h),
                  customText(
                    text: 'Communities you may want to join',
                    fontFamily: 'dmsans',
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 1.h),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        communitySuggestion('assets/png/event_detail_icon/image 1.png', 'Event Vista', '5.6k Followers'),
                        SizedBox(width: 3.w,),
                        communitySuggestion('assets/png/event_detail_icon/image 2.png', 'Business Talks', '7.3k Followers'),
                        SizedBox(width: 3.w,),
                        communitySuggestion('assets/png/community_icon/grpimg1.png', 'Tech Gamers', '4.7k Followers')
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h
                    ),
                    margin: EdgeInsets.only(right: 4.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(color: textfieldBorderColor),
                        borderRadius: BorderRadius.circular(25.sp)
                    ),
                    child: customText(
                        text: 'View all >'
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(padding: EdgeInsets.only(right: 4.w), child: Divider()),
                  SizedBox(height: 1.h),
                  communityPost(
                    'assets/png/community_icon/person3.png',
                    'Youth Influencer',
                    'Rufus Schulist',
                    '8 mins',
                    'assets/png/community_icon/person1.png',
                    'assets/png/event_detail_icon/people2.jpg',
                  ),
                  SizedBox(height: 1.h),
                  Padding(padding: EdgeInsets.only(right: 4.w), child: Divider()),
                  SizedBox(height: 1.h),
                  communityPost(
                    'assets/png/community_icon/person3.png',
                    'Youth Influencer',
                    'Rufus Schulist',
                    '8 mins',
                    'assets/png/community_icon/person1.png',
                    'assets/png/event_detail_icon/people2.jpg',
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  // height: 14.h, // 🔹 blur limited to this height
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // frosted effect
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 4.h, bottom: 1.h),
                    child: Row(
                      children: [
                        customText(
                          text: 'Community',
                          fontFamily: 'dmsans',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        const Spacer(),
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 4.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.8.h,
                              ),

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: textfieldBorderColor,
                                  width: 0.3.w,
                                ),
                              ),
                              child: Image.asset('assets/png/bell_icon.png', width: 3.5.w,),
                            ),
                            Positioned(
                              right: 6.2.w,
                              top: 0.8.h,
                              child: Image.asset(
                                'assets/png/bell_icon2.png',
                                width: 1.5.w,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      )
    );
  }
}



