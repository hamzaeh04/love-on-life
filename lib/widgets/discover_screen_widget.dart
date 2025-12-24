import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/widgets/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants_widgets.dart';
import '../core/services/apiendpoints.dart';
import '../views/dashboard_screens/home_screen.dart';
import 'custom_button.dart';
import 'profile_network_image.dart';

Widget discoverWidget({
  int? index, // 👈 optional index now
  required String imagePath,
  required String eventName,
  required String description,
  required String tag,
  required String noOfPeople,
  String? date,
  String? time,
  String? eventId,
  bool? isFavorite,
  String? ticketPrice,
  String? ticketsLeft,
  VoidCallback? onViewLocation,
  VoidCallback? onJoinNow,
  VoidCallback? onFavIconTap,
  BuildContext? context,
}) {
  final CommunityController communityController = Get.find<CommunityController>();
  print("The images are ${baseService.baseURL}${imagePath}");
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(13.sp),
      border: Border.all(
        color: textfieldBorderColor,
        width: 0.2.w,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [
              Container(
                height: 20.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.sp), topRight: Radius.circular(12.sp)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.sp), topRight: Radius.circular(12.sp)),
                  // child: ProfileNetworkImage2(
                  //   imageUrl: "${baseService.baseURL}${imagePath}",
                  //   size: 10.w,
                  //   placeholder: 'assets/png/discover1.jpeg',
                  //   isCommunity: true,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: "${baseService.baseURL}${imagePath}",
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
                ),
              ),

              // 🔹 Tag
              Positioned(
                bottom: 1.h,
                left: 3.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.sp),
                    color: whiteColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
                    child: customText(
                      text: tag,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // 🔹 Favourite (Heart) Icon
              Positioned(
                bottom: 1.h,
                right: 3.w,
                child: Obx(() {
                  final events = communityController.getAllEventsModel.value?.data?.events;
                  if (events == null || index == null || index! >= events.length) {
                    return SizedBox(); // return empty widget if index is invalid
                  }

                  final currentEvent = events[index!];
                  final eventIsFav = currentEvent?.isFavorite ?? false;

                  return GestureDetector(
                    onTap: () async {
                      if (currentEvent?.id != null) {
                        await communityController.toggleFavoriteEvent("${currentEvent!.id}", index!);
                        communityController.getFavoriteEvents();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.25.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                        border: Border.all(color: textfieldBorderColor, width: 0.3.w),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            eventIsFav
                                ? 'assets/png/community_icon/like_red.png'
                                : 'assets/png/community_icon/Like.png',
                            width: 4.w,
                            height: 2.h,
                            color: eventIsFav ? buttonPinkColor : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                }),

              ),

              // 🔹 Share Icon
              Positioned(
                bottom: 5.h,
                right: 3.w,
                child: InkWell(
                  onTap: (){
                    communityController.shareEvent("${baseService.baseURL}${ApiEndPoints.getEventById(eventId ?? '')}");
                  },
                  child: homeShareWidget(
                    "assets/png/home_icons/share_icon.png",
                    width: 4.w,
                    height: 2.h,
                    hori: 1.5.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // 🔹 Event Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Event name can be long, so wrap it in Expanded
                    Expanded(
                      child: customText(
                        text: eventName,
                        fontFamily: 'dmsans',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        overFlow: TextOverflow.ellipsis, // use ellipsis for overflow
                        maxLines: 3,
                      ),
                    ),

                    SizedBox(width: 2.w),

                    // Number of people + text
                    customText(
                      text: noOfPeople,
                      fontFamily: 'dmsans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    SizedBox(width: 1.w),
                    customText(
                      text: 'people attending',
                      fontFamily: 'dmsans',
                      fontSize: 13.sp,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ],
                ),
                SizedBox(height: 0.2.h),
                customText(
                  text: description,
                  fontFamily: 'dmsans',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 1.h),

                Row(
                  children: [
                    Expanded(child: midButton(containerBgBlueColor, Image.asset('assets/png/event_detail_icon/calendar.png',), date ?? '12 Sep, 2025', time ?? '12:00 AM')),
                    SizedBox(width: 2.w,),
                    Expanded(child: midButton(containerPinkColor, Image.asset('assets/png/event_detail_icon/ticket.png', ),
                        "\$ ${ticketPrice}" ?? 'Free', '7 Tickets Left')),
                  ],
                ),

                SizedBox(height: 1.5.h),

                // 🔹 Buttons
                Row(
                  children: [
                    // Expanded(
                    //   child: customButton(
                    //     "View Location",
                    //     color: blackColor,
                    //     fontweight: FontWeight.w500,
                    //     fontsize: 15.sp,
                    //     height: 5.h,
                    //     textColor: whiteColor,
                    //     ontap: onViewLocation,
                    //   ),
                    // ),
                    // SizedBox(width: 2.w),
                    Expanded(
                      child: customButton(
                        "Join Now",
                        color: buttonPinkColor,
                        fontweight: FontWeight.w500,
                        fontsize: 15.sp,
                        height: 5.h,
                        textColor: whiteColor,
                        ontap: onJoinNow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
Widget midButton(Color color, Image image, String midButtonTitle, String midButtonDesc){
  return Container(
    height: 5.5.h,
    // width: 40.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        color: color
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          Container(
            height: 4.h,
            width: 8.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: image,
          ),
          SizedBox(width: 2.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                text: midButtonTitle,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
              customText(
                text: midButtonDesc,
                fontSize: 13.5.sp,
                color: Colors.black.withValues(alpha: 0.8),
                fontWeight: FontWeight.w400
              ),
            ],
          )
        ],
      ),
    ),
  );
}