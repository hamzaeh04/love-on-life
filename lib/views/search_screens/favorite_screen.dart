import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/discover_screen_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    // 🔹 Sample Data Array
    final List<Map<String, dynamic>> favoriteEvents = [
      {
        'imagePath': 'assets/png/discover1.jpeg',
        'eventName': 'Young Education Program',
        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
        'date': '10 Sep, 2025',
        'time': '12:00 AM',
        'ticketPrice': '\$40',
        'tag': 'Educational',
        'noOfPeople': '25 people attending',
        'ticketsLeft': '7 Tickets left',
      },
      {
        'imagePath': 'assets/png/event_detail_icon/people.png',
        'eventName': 'Young Education Program',
        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
        'date': '10 Sep, 2025',
        'time': '12:00 AM',
        'ticketPrice': '\$40',
        'tag': 'Educational',
        'noOfPeople': '25 people attending',
        'ticketsLeft': '7 Tickets left',
      },
      {
        'imagePath': 'assets/png/event_detail_icon/people.png',
        'eventName': 'Young Education Program',
        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
        'date': '10 Sep, 2025',
        'time': '12:00 AM',
        'ticketPrice': '\$40',
        'tag': 'Educational',
        'noOfPeople': '25 people attending',
        'ticketsLeft': '7 Tickets left',
      },
      {
        'imagePath': 'assets/png/event_detail_icon/people.png',
        'eventName': 'Young Education Program',
        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
        'date': '10 Sep, 2025',
        'time': '12:00 AM',
        'ticketPrice': '\$40',
        'tag': 'Educational',
        'noOfPeople': '25 people attending',
        'ticketsLeft': '7 Tickets left',
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customHeader('Favorites', padding: 29.w),
                SizedBox(height: 2.5.h),

                // 🔹 Search Bar + Filter
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
                      height: 5.h,
                      width: 5.h,
                      decoration: BoxDecoration(
                        color: buttonPinkColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/png/community_icon/filter.png',
                          width: 4.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // 🔹 Events List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: favoriteEvents.length,
              itemBuilder: (context, index) {
                final event = favoriteEvents[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: discoverWidget(
                    index: index,
                    imagePath: event['imagePath'],
                    eventName: event['eventName'],
                    description: event['description'],
                    date: event['date'],
                    time: event['time'],
                    ticketPrice: event['ticketPrice'],
                    tag: event['tag'],
                    noOfPeople: event['noOfPeople'],
                    ticketsLeft: event['ticketsLeft'],
                    onViewLocation: () => print("View Location clicked for ${event['eventName']}"),
                    onJoinNow: () => print("Join Now clicked for ${event['eventName']}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
