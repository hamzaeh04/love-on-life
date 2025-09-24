import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h,),
            //AppBar
            Row(
              children: [
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
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
            //Body
            SizedBox(height: 3.h,),
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
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
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
                      padding: EdgeInsets.only(left: 3.w, top: 1.5.h, bottom: 1.5.h, right: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Color(0xFFD9F3FB)
                      ),
                      child:
                      Row(
                        children: [
                          Image.asset('assets/png/event_detail_icon/date&time.png', width: 7.5.w,),
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
                            left: 13.w + (index * 4.w), // har image thoda overlap karega
                            child: Image.asset(   // ya Image.asset agar local ho
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
            )

          ],
        ),
      ),
    );
  }
}
