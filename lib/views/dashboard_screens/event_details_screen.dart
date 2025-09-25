import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/discover_screen_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key});

  final List<String> apiImages = [
    "assets/png/event_detail_icon/p1.png",
    "assets/png/event_detail_icon/p2.png",
    "assets/png/community_icon/person3.png",
    "assets/png/event_detail_icon/p3.png",
    "assets/png/event_detail_icon/p4.png",
    "assets/png/event_detail_icon/image.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 6.h,),

                  //Body
                  SizedBox(height: 11.65.h,),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(13.sp),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/png/event_detail_icon/people.png',
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              bottom: 1.5.h,
                              left: 4.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    color: Colors.white
                                ),
                                child: customText(
                                  text: 'Motivational',
                                  fontFamily: 'dmsans',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                          )
                        ],
                      )
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
                        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean\npretium.'
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: 'Date & Time',
                            fontFamily: 'dmsans',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 0.8.h,),
                          Container(
                            padding: EdgeInsets.only(
                                left: 3.w, top: 1.5.h, bottom: 1.5.h, right: 12.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: Color(0xFFD9F3FB)
                            ),
                            child:
                            Row(
                              children: [
                                Image.asset(
                                  'assets/png/event_detail_icon/date&time.png',
                                  width: 7.5.w,),
                                SizedBox(width: 3.w,),
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
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: 'Attendees',
                            fontFamily: 'dmsans',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 0.8.h,),
                          Stack(
                            children: [
                              Container(
                                width: 45.w,
                                padding: EdgeInsets.only(top: 4.8.h, bottom: 1.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: const Color(0xFFCFE1FF),
                                ),
                              ),
                              // yeh attendee icon fix rahega
                              Positioned(
                                top: 1.4.h,
                                left: 3.w,
                                child: Image.asset(
                                  'assets/png/event_detail_icon/attendees.png',
                                  width: 7.5.w,
                                ),
                              ),

                              // yahan loop use hoga for API images
                              ...List.generate(apiImages.length, (index) {
                                return Positioned(
                                  top: 1.4.h,
                                  left: 13.w + (index * 4.w),
                                  // har image thoda overlap karega
                                  child: Image.asset( // ya Image.asset agar local ho
                                    apiImages[index],
                                    width: 7.w,
                                  ),
                                );
                              }),
                            ],
                          )

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h,),
                  customText(
                    text: 'Event Organizers',
                    fontFamily: 'dmsans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 1.5.h,),
                  event_organizers('assets/png/event_detail_icon/image 1.png', 'Youth Influencer', 'Training youth for their bright future'),
                  SizedBox(height: 1.5.h,),
                  event_organizers('assets/png/event_detail_icon/image 2.png', 'Planning Expert', 'Crafting Experiences for every occassion '),
                  SizedBox(height: 1.5.h,),
                  customText(
                    text: 'Location',
                    fontFamily: 'dmsans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 1.5.h,),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(13.sp),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/png/event_detail_icon/Mask group.png',
                            height: 25.h,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              bottom: 1.5.h,
                              right: 4.w,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/png/event_detail_icon/aaa.png',
                                  width: 8.w,
                                ),
                              )
                          )
                        ],
                      ),
                  ),
                  SizedBox(height: 1.5.h,),
                  customText(
                    text: 'Gallery',
                    fontFamily: 'dmsans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 1.5.h,),
                  // Gallery items to be added
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/png/event_detail_icon/gallery1.png',
                              height: 26.h, // Can keep relative height like this if you use responsive package
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Flexible(
                        flex: 3,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/png/event_detail_icon/gallery2.png',
                              width: double.infinity, // takes full Flexible width
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 1.25.h),
                            Image.asset(
                              'assets/png/event_detail_icon/gallery3.png',
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.5.h,),
                  customText(
                    text: 'Comments',
                    fontFamily: 'dmsans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 1.5.h,),
                  comments('assets/png/event_detail_icon/p1.png', 'Lynn Ritchie', 'Motivational Speaker', '2hrs Ago', '12k Likes', 'Lorem ipsum dolor sit amet, consectetur elit. Aenean pretium.'),
                  SizedBox(height: 1.h,),
                  Divider(),
                  SizedBox(height: 1.h,),
                  comments('assets/png/event_detail_icon/p2.png', 'Edwards Gem', 'Participant', '2hrs Ago', '12k Likes', 'Lorem ipsum dolor sit amet, consectetur elit. Aenean pretium.'),
                  SizedBox(height: 1.h,),
                  Divider(),
                  SizedBox(height: 1.h,),
                  comments('assets/png/event_detail_icon/p3.png', 'Robbin Basker', 'Organizer', '2hrs Ago', '12k Likes', 'Lorem ipsum dolor sit amet, consectetur elit. Aenean pretium.'),

                  SizedBox(height: 3.h,),
                  customText(
                    text: 'Discover Similar Events',
                    fontFamily: 'dmsans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 1.5.h,),
                  discoverWidget(
                    imagePath: 'assets/png/discover1.jpeg',
                    eventName: 'Young Education Program',
                    description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
                    date: '10 Sep, 2025',
                    time: '12:00 AM',
                    ticketPrice: '\$40',
                    tag: "Educational",
                    noOfPeople: "25 people attending",
                    ticketsLeft: '7 Tickets left',
                    onViewLocation: () {
                      print("View Location clicked");
                    },
                    onJoinNow: () {
                      print("Join Now clicked");
                    },
                  ),
                  SizedBox(height: 1.h),

                  discoverWidget(
                    imagePath: 'assets/png/event_detail_icon/people.png',
                    eventName: 'Young Education Program',
                    description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
                    date: '10 Sep, 2025',
                    time: '12:00 AM',
                    ticketPrice: '\$40',
                    tag: "Educational",
                    noOfPeople: "25 people attending",
                    ticketsLeft: '7 Tickets left',
                    onViewLocation: () {
                      print("View Location clicked");
                    },
                    onJoinNow: () {
                      print("Join Now clicked");
                    },
                  ),
                  SizedBox(height: 1.h),

                  discoverWidget(
                    imagePath: 'assets/png/event_detail_icon/people.png',
                    eventName: 'Young Education Program',
                    description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
                    date: '10 Sep, 2025',
                    time: '12:00 AM',
                    ticketPrice: '\$40',
                    tag: "Educational",
                    noOfPeople: "25 people attending",
                    ticketsLeft: '7 Tickets left',
                    onViewLocation: () {
                      print("View Location clicked");
                    },
                    onJoinNow: () {
                      print("Join Now clicked");
                    },
                  ),
                  SizedBox(height: 10.h,),
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
                    padding: EdgeInsets.only(left: 4.w, top: 5.h, bottom: 1.5.h),
                    child: //AppBar
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: textfieldBorderColor)
                          ),
                          child: Icon(Icons.arrow_back, size: 18.sp,),
                        ),
                        SizedBox(width: 16.w,),
                        customText(
                          text: 'Leadership skills',
                          fontFamily: 'dmsans',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
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
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h, bottom: 3.h),
                    child: //AppBar
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                            "Mark in Calendar",
                            color: blackColor,
                            fontweight: FontWeight.w500,
                            fontsize: 15.sp,
                            height: 5.h,
                            textColor: whiteColor,
                            ontap: (){
                              Get.toNamed('singleTicket');
                            },
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: customButton(
                            "Join for \$40",
                            color: buttonPinkColor,
                            fontweight: FontWeight.w500,
                            fontsize: 15.sp,
                            height: 5.h,
                            textColor: whiteColor,
                            ontap: (){
                              Get.toNamed('event');
                            },
                          ),
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
Widget event_organizers(String path, String title, String desc){
  return Row(
    children: [
      ClipRRect(
        child: Image.asset(path, width: 10.w,),
      ),
      SizedBox(width: 1.5.w,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: title,
            fontFamily: 'dmsans',
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w500,
          ),customText(
            text: desc,
            fontFamily: 'dmsans',
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF83848D),
            height: 0.15.h
          ),
        ],
      ),
      Spacer(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: Color(0xFF262626)
        ),
        child: customText(
          text: 'Follow',
          fontFamily: 'dmsans',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: whiteColor
        ),
      )
    ],
  );
}


Widget comments (String path, String name, String role, String time, String likes, String comment){
  return Column(
    children: [
      Row(
        children: [
          ClipOval(
            child: Image.asset(path, width: 9.w,),
          ),
          SizedBox(width: 1.5.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: name,
                fontFamily: 'dmsans',
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),customText(
                text: role,
                fontFamily: 'dmsans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.6)
              ),
            ],
          ),
          Spacer(),
          customText(
              text: time,
              fontFamily: time,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6)
          ),
          SizedBox(width: 2.w), // spacing before divider
          Container(
            width: 0.15.w, // thickness of line
            height: 1.h, // height of divider
            color: Color(0xFF666666),
          ),
          SizedBox(width: 2.w), // spacing after divider
          customText(
              text: likes,
              fontFamily: likes,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6)
          ),
          SizedBox(width: 2.w),
          Icon(Icons.favorite_border, size: 18.sp,)
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 11.w, top: 0.5.h, bottom: 0.5.h),
        child: Column(
          children: [
            customText(
                text: comment,
                fontFamily: likes,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 0.5.h,),
            Container(
              height: 3.5.h, // 👈 you control height here
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(color: textfieldBorderColor),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Reply here",
                  border: InputBorder.none, // removes default underline
                  isCollapsed: true,        // reduces default vertical padding
                ),
                style: TextStyle(fontSize: 14.sp),
              ),
            )
          ],
        ),
      ),

    ],
  );

}
