import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart'; // customText

class EventsCarousel extends StatelessWidget {
  final CommunityController communityController =
      Get.find<CommunityController>();
  BaseService baseService = BaseService();

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
        final double viewportFraction = (desiredItemWidth / availableWidth)
            .clamp(0.1, 1.0);

        return CarouselSlider.builder(
          itemCount: communityController.eventsList.length,
          itemBuilder: (context, index, realIndex) {
            final event = communityController.eventsList[index];

            return ClipRRect(
              key: ValueKey(event.id),
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand, // let image & overlay fill the card slot
                children: [
                  // Full image covering the card
                  CachedNetworkImage(
                    imageUrl: "${baseService.baseURL}${event.image}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.broken_image),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: customText(
                            text: event.category ?? "Educational",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        customText(
                          text: event.eventTitle ?? "Young Education Program",
                          color: whiteColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 0.5.h),
                        customText(
                          text:
                              event.description ??
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.",
                          color: whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            Expanded(
                              child: carousalWidget(
                                "assets/png/home_icons/pin_point_updated.png",
                                'Gotham City',
                                "3.4 km",
                                imgwidth: 3.w,
                              ),
                            ),

                            Expanded(
                              child: carousalWidget(
                                "assets/png/home_icons/calender_grey.png",
                                communityController.formatDate(event.date) ??
                                    "12 Sep, 2025",
                                communityController.formatTime(event.time) ??
                                    "12:00 AM - 2:00 PM",
                                imgwidth: 3.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            carousalWidget(
                              "assets/png/home_icons/ticket_white.png",
                              "\$ ${event.price}",
                              "${event.ticketType}" ?? '7 Tickets left',
                            ),

                            SizedBox(width: 7.w), // spacing before avatars

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.sp),
                                color: whiteColor.withAlpha(60),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.4.h,
                              ), // 👈 inner padding

                              child: customText(
                                text:
                                    "${event.userIds?.length.toString()} peoples attending",
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
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
            onPageChanged: (index, reason) {
              communityController.currentCarouselIndex.value = index;
            },
          ),
        );
      },
    );
  }
}

Widget carousalWidget(
  String path,
  String date,
  String time, {
  double? imgwidth,
}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: whiteColor.withAlpha(60),
        ),
        child: Padding(
          padding:
              imgwidth != null ? EdgeInsets.all(2.w) : EdgeInsets.all(1.7.w),
          child: Image.asset(path, width: imgwidth ?? 4.w),
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
            color: whiteColor,
          ),
          customText(
            text: time ?? "",
            fontFamily: 'dmsans',
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: whiteColor,
          ),
        ],
      ),
    ],
  );
}
