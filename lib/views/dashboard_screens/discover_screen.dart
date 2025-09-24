import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/widgets/discover_screen_widget.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_app_bar.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 👇 Scrollable content (AppBar ke neeche se start hoga)
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 15.h), // AppBar ke neeche se shuru
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    customText(
                      text: 'Discover Events',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 1.h),

                    /// 🔹 Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(25.sp),
                        border: Border.all(
                          color: textfieldBorderColor,
                          width: 0.2.w,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 0.6.h,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/png/home_icons/search_icon.png",
                              width: 5.w,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search here...",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14.sp,
                                  ),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.only(bottom: 0.2.h),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                customText(
                                  text: 'This week',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(width: 0.3.w),
                                Icon(Icons.keyboard_arrow_down, size: 15.sp),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),

                    /// 🔹 Tabs
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            controller.discoverList.length,
                                (index) {
                              final item = controller.discoverList[index];
                              final isSelected =
                                  controller.discoverIndex.value == index;

                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index ==
                                      controller.discoverList.length - 1
                                      ? 0
                                      : 1.1.w,
                                ),
                                child: InkWell(
                                  onTap: () => controller.switchDiscoverTab(index),
                                  borderRadius: BorderRadius.circular(25.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.sp),
                                      color: isSelected
                                          ? selectedTabColor
                                          : whiteColor,
                                      border: Border.all(
                                        color: textfieldBorderColor,
                                        width: 0.2.w,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.38.w,
                                        vertical: 0.4.h,
                                      ),
                                      child: customText(
                                        text: item,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          /// ➕ Add Button
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(25.sp),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 1.8.w,
                                vertical: 0.4.h,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor,
                                border: Border.all(
                                  color: textfieldBorderColor,
                                  width: 0.2.w,
                                ),
                              ),
                              child: Icon(Icons.add, size: 16.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),

                    /// 🔹 Events Widgets
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

                    SizedBox(height: 13.h),
                  ],
                ),
              ),
            ),
          ),

          /// 👇 Fixed AppBar with Blur
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
