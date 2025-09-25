import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

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

Widget createPost() {
  return Container(
    margin: EdgeInsets.only(right: 4.w),
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12.sp),
      border: Border.all(color: textfieldBorderColor),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                  height: 0.15.h,
                ),
                customText(
                  text: 'Participant',
                  fontFamily: 'dmsans',
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF83848D),
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.7.h),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                color: publicButtonColor,
                border: Border.all(color: textfieldBorderColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customText(
                    text: 'Public',
                    fontFamily: 'dmsans',
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(width: 1.w),
                  Icon(Icons.keyboard_arrow_down, size: 14.5.sp),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 0.2.h),
        TextField(
          decoration: InputDecoration(
            hintText: 'Write something about the events',
            hintStyle: TextStyle(
              fontFamily: 'dmsans',
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF83848D),
            ),
            border: InputBorder.none, // removes underline/border
            isDense: true, // removes extra vertical padding
            contentPadding: EdgeInsets.zero, // removes internal padding
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            children: [
              Image.asset('assets/png/Image.png', width: 5.w),
              SizedBox(width: 2.5.w),
              customText(
                text: 'Image/video',
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 10.w),
              Image.asset('assets/png/location.png', width: 5.w),
              SizedBox(width: 2.5.w),
              customText(
                text: 'Check-in',
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 10.w),
              Image.asset('assets/png/CheckCircle.png', width: 5.w),
              SizedBox(width: 2.5.w),
              customText(
                text: 'Activity',
                fontFamily: 'dmsans',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

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
Widget communitySuggestion (String path, String title, String followers){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),

    width: 36.w,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(14.sp),
      border: Border.all(color: textfieldBorderColor)
    ),
    child:
    Center(
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset(path, width: 9.w,),
          ),
          SizedBox(height: 0.8.h,),
          customText(
            text: title,
            fontFamily: 'dmsans',
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w700,
          ),
          customText(
            text: followers,
            fontFamily: 'dmsans',
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.7),
          ),
          SizedBox(height: 1.2.h,),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.sp),
              color: joinButtonColor,
            ),
            child: customText(

              text: 'Join',
              color: Color(0xFF34A0C2),
              fontFamily: 'dmsans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
  );
}
