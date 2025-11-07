import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/community_post_widget.dart';
import '../../widgets/community_suggestion_widget.dart';
import '../../widgets/create_post_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drawer_widget.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
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
                    padding: EdgeInsets.only( bottom: 0.h),
                    child: customAppBar('Community', ontap: ()=>
                        _scaffoldKey.currentState!.openDrawer(),),
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



