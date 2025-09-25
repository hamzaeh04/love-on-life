import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_on_life/views/dashboard_screens/home_screen.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart'; // customText

class EventsCarousel extends StatelessWidget {
  final List<String> images = [
    "assets/png/carousal_images/carousal1.png",
    "assets/png/carousal_images/carousal2.png",
    "assets/png/carousal_images/carousal3.png",
  ];

  final List<String> apiImages = [
    "assets/png/event_detail_icon/p1.png",
    "assets/png/event_detail_icon/p2.png",
    "assets/png/community_icon/person3.png",
    "assets/png/event_detail_icon/p3.png",
    "assets/png/event_detail_icon/image.png",
  ];


  EventsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // desired item width in screen percentage (using sizer)
    final double desiredItemWidth = 83.w;

    return LayoutBuilder(
      builder: (context, constraints) {
        // available width for carousel (usually screen width minus padding)
        final double availableWidth = constraints.maxWidth;
        // compute viewport fraction so each item equals desiredItemWidth
        final double viewportFraction = (desiredItemWidth / availableWidth).clamp(0.1, 1.0);

        return CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand, // let image & overlay fill the card slot
                children: [
                  // Full image covering the card
                  Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),

                  // subtle gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),

                  // content overlay at the bottom
                  Positioned(
                    bottom: 2.5.h,
                    left: 3.w,
                    right: 3.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: customText(
                            text: "Educational",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        customText(
                          text: "Young Education Program",
                          color: whiteColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 0.5.h),
                        customText(
                          text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.",
                          color: whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            carousalWidget("assets/png/home_icons/pin_point_updated.png", "Gotham City", "3.4 km",imgwidth: 3.w),
                            SizedBox(width: 5.w),
                            carousalWidget("assets/png/home_icons/calender_grey.png", "12 Sep, 2025", "12:00 AM - 2:00 PM",imgwidth: 3.w)
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            carousalWidget(
                              "assets/png/home_icons/ticket_white.png",
                              "\$ 40",
                              "7 Tickets left",
                            ),

                            SizedBox(width: 7.w), // spacing before avatars

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.sp),
                  color: whiteColor.withAlpha(60),
                ),
                padding: EdgeInsets.all(1.w), // 👈 inner padding
                child: SizedBox(
                  width: (apiImages.length * 5.w) + 2.w,
                  height: 7.w,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ...List.generate(apiImages.length, (index) {
                        return Positioned(
                          left: index * 5.w,
                          child: ClipOval(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Avatar Image
                                Image.asset(
                                  apiImages[index],
                                  width: 7.w,
                                  height: 7.w,
                                  fit: BoxFit.cover,
                                ),

                                // 👇 Agar last image hai to overlay + custom text
                                if (index == apiImages.length - 1)
                                  Container(
                                    width: 7.w,
                                    height: 7.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: customText(
                                      text: "12+",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),


              ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 55.h,
            enlargeCenterPage: true,
            autoPlay: true,
            enableInfiniteScroll: true,
            viewportFraction: viewportFraction, // <- dynamic fraction
            // optional: tweak enlarge strategy
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
          ),
        );
      },
    );
  }
}Widget carousalWidget(String path, String date, String time,{double? imgwidth}){
  return Row(
    children: [
      Container(

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: whiteColor.withAlpha(60),
        ),
        child: Padding(
          padding: imgwidth != null ? EdgeInsets.all(2.w): EdgeInsets.all(1.7.w),
          child: Image.asset(
            path,
            width: imgwidth ?? 4.w,
          ),
        ),
      ),
      SizedBox(width: 2.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
              text: date ?? "",
              fontFamily: 'dmsans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: whiteColor
          ),
          customText(
              text: time ?? "",
              fontFamily: 'dmsans',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: whiteColor
          ),
        ],
      ),
    ],
  );
}
