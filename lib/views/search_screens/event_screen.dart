import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/community_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/search_controller.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/discover_screen_widget.dart';
import '../dashboard_screens/discover_screen.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();
  final AuthController authController = Get.find<AuthController>();
  final CommunityController communityController = Get.find<CommunityController>();
  final SearchController2 searchController = Get.find<SearchController2>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      communityController.getMyEvents();
    });


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
                                onChanged: (value) {
                                  searchController.updateSearch(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 3.w),
                  // Container(
                  //   height: 5.h, width: 5.h,
                  //   decoration: BoxDecoration(color: buttonPinkColor, shape: BoxShape.circle),
                  //   child: Center(child: Image.asset('assets/png/community_icon/filter.png', width: 4.w)),
                  // ),
                ],
              ),

              SizedBox(height: 2.h),

              /// 🔹 Event List
              Obx(() {
                if (communityController.isLoading.value) {
                  return SizedBox(
                    height: 70.h,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                final data = communityController.getMyEventsModel.value?.data;
                final upcoming = data?.upcoming ?? [];
                final past = data?.past ?? [];
                final allEvents = [...upcoming, ...past];

                final search = searchController.searchText.value.toLowerCase();

                final filteredEvents = allEvents.where((event) {
                  final title = event.eventTitle?.toLowerCase() ?? '';
                  final category = event.category?.toLowerCase() ?? '';
                  return title.contains(search) || category.contains(search);
                }).toList();

                if (filteredEvents.isEmpty) {
                  return SizedBox(
                    height: 70.h,
                    child: Center(
                      child: customText(
                        text: "No Events Found",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredEvents.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];

                    return discoverWidget(
                      index: index,
                      imagePath: event.image ?? '',
                      eventName: event.eventTitle ?? '',
                      description: event.description ?? '',
                      date: communityController.formatDate(event.date) ?? "",
                      time: event.time ?? '',
                      ticketPrice: event.price?.toString() ?? '',
                      tag: event.category ?? '',
                      noOfPeople: '20',
                      ticketsLeft: '5',
                      context: context,
                      onViewLocation: () {},
                      onJoinNow: () {},
                    );
                  },
                );
              }),
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