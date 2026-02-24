import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:love_on_life/controllers/notification_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_header.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  NotificationController notificationController =
      Get.find<NotificationController>();
  CommunityController communityController = Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationController.GetNotification(page: 1, limit: 10);
    });
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await notificationController.GetNotification(page: 1, limit: 10);
        },
        builder: (
          BuildContext context,
          Widget child,
          IndicatorController controller,
        ) {
          return Stack(
            children: [
              child, // your scrollable content
              Positioned(
                top: 45.h,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return SizedBox(
                      height: controller.value * 60, // indicator height
                      child: Center(
                        child:
                            controller.isIdle
                                ? const SizedBox()
                                : CircularProgressIndicator(
                                  strokeWidth: 4,
                                  valueColor: AlwaysStoppedAnimation(
                                    buttonPinkColor,
                                  ),
                                ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customHeader("Notifications", padding: 22.5.w),
                SizedBox(height: 3.h),

                // 🔽 Filter Bar
                Container(
                  decoration: BoxDecoration(
                    color: buttonPinkColor.withOpacity(0.03),
                    border: Border.all(color: selectedContainerColor),
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.5.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            customText(
                              text: 'Showing:',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: loginGreyColor,
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20.sp),
                                border: Border.all(
                                  color: notificationGreyColor,
                                  width: 0.2.w,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 0.2.h,
                                ),
                                child: PopupMenuButton<String>(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  color: whiteColor,
                                  elevation: 2,
                                  offset: const Offset(0, 35),

                                  onSelected: (String value) {
                                    notificationController.setFilter(value);
                                  },
                                  child: Obx(() => Row(
                                    children: [
                                      customText(
                                        text: notificationController.selectedFilter.value,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: notificationGreyColor,
                                      ),
                                      SizedBox(width: 1.w),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.sp,
                                        color: notificationGreyColor,
                                      ),
                                    ],
                                  )),

                                  itemBuilder:
                                      (context) => [
                                        const PopupMenuItem(
                                          value: 'All',
                                          child: Text('All'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Read',
                                          child: Text('Read'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Unread',
                                          child: Text('Unread'),
                                        ),
                                      ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            notificationController.readAllNotifications();
                          },
                          child: customText(
                            text: 'Mark As All Read',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: buttonPinkColor,
                            txtDecoration: TextDecoration.underline,
                            decorationColor: buttonPinkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 2.h),
                Obx(() {
                  final filter = notificationController.selectedFilter.value;

                  final filteredList = notificationController.notificationsList.where((n) {
                    if (filter == 'All') return true;
                    if (filter == 'Read') return n.isRead == true;
                    if (filter == 'Unread') return n.isRead == false;
                    return true;
                  }).toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final data = filteredList[index];
                      return notificationWidget(
                        data.body ?? "",
                        title: data.title,
                        date: communityController.formatDate(data.createdAt),
                        time: communityController.formatTime3(data.createdAt),
                        isRead: data.isRead ?? false,
                        onReadTap: () => notificationController.ReadSingleNotification(data.id ?? ""),
                      );
                    },
                  );
                }),
                SizedBox(height: 3.h),

                // ✅ You can add more below...
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget notificationWidget(
  String message, {
  required String time,
  required String date,
  bool isRead = false,
  String? title,
  VoidCallback? onReadTap,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 1.h),
    decoration: BoxDecoration(
      color: isRead ? whiteColor : buttonPinkColor.withOpacity(0.04),
      border: Border.all(
        color: isRead ? notificationGreyColor : buttonPinkColor,
        width: isRead ? 0.1.w : 0.2.w,
      ),
      borderRadius: BorderRadius.circular(15.sp),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: title ?? 'New Like',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),
          customText(
            text:
                message ??
                'Sed rhoncus sapien nunc eget odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: blackColor,
          ),
          SizedBox(height: 0.5.h),

          // ✅ Action & Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onReadTap,
                child: customText(
                  text: 'Mark As Read',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isRead ? loginGreyColor : buttonPinkColor,
                  txtDecoration: TextDecoration.underline,
                  decorationColor: isRead ? loginGreyColor : buttonPinkColor,
                ),
              ),

              Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/png/home_icons/clock_icon.png",
                        width: 3.5.w,
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: "${time}" ?? '12:45 PM',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: loginGreyColor,
                      ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  Row(
                    children: [
                      Image.asset(
                        "assets/png/home_icons/calender_icon.png",
                        width: 3.5.w,
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: date ?? '20 June 2025',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: loginGreyColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
