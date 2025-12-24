import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/search_controller.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/discover_screen_widget.dart';
import '../dashboard_screens/discover_screen.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    final CommunityController communityController = Get.find<CommunityController>();
    final SearchController2 searchController = Get.put(SearchController2());

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 5.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeader('My Events', padding: 27.w),
              SizedBox(height: 2.5.h),

              /// 🔹 Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(25.sp),
                        border: Border.all(
                          color: textfieldBorderColor,
                          width: 0.4.w,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/png/home_icons/search_icon.png",
                              width: 5.w,
                              color: searchColor,
                            ),
                            SizedBox(width: 1.w),
                            Expanded(
                              child: TextField(
                                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Search here...",
                                  hintStyle: TextStyle(color: searchColor, fontSize: 15.sp),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Container(
                    height: 5.h, width: 5.h,
                    decoration: BoxDecoration(color: buttonPinkColor, shape: BoxShape.circle),
                    child: Center(child: Image.asset('assets/png/community_icon/filter.png', width: 4.w)),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              /// 🔹 Event List
              Obx(() => searchController.isSearch.value == true
                  ? ListView.builder(
                // IMPORTANT: Dono lists sync honi chahiye crash se bachne ke liye
                itemCount: controller.events.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var eventData = controller.events[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: discoverWidget(
                      index: index, // Pass index for favorite logic
                      imagePath: eventData['imagePath'],
                      eventName: eventData['eventName'],
                      description: eventData['description'],
                      date: eventData['date'],
                      time: eventData['time'],
                      ticketPrice: eventData['ticketPrice'],
                      tag: eventData['tag'],
                      noOfPeople: '20',
                      ticketsLeft: eventData['ticketsLeft'],
                      context: context,
                      onViewLocation: () => print("View Location $index"),
                      onJoinNow: () => print("Join Now $index"),
                    ),
                  );
                },
              )
                  : _buildRecentSearches()), // Moved to a function for cleanliness
              SizedBox(height: 13.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      children: [
        SizedBox(height: 1.h),
        Row(
          children: [
            customText(text: 'Recent Searches', fontSize: 15.5.sp, fontWeight: FontWeight.w600),
            const Spacer(),
            customText(text: 'Clear All', fontSize: 14.sp),
          ],
        ),
        SizedBox(height: 3.h),
        options('Educational'),
        options('Music'),
        options('Business'),
        options('Motivational'),
      ],
    );
  }
}