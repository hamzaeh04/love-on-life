import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:love_on_life/widgets/custom_header.dart';
import 'package:love_on_life/widgets/custom_text_field.dart';
import 'package:love_on_life/widgets/discover_screen_widget.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/search_controller.dart';
import '../../widgets/custom_app_bar.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();
  final SearchController2 searchController = Get.put(SearchController2());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 👇 Scrollable content (AppBar ke neeche se start hoga)
          Positioned.fill(
            child: Obx(() =>
              SingleChildScrollView(
                padding:
                searchController.isSearch.value == false
                    ? EdgeInsets.only(top: 12.5.h)
                    : EdgeInsets.only(top: 9.5.h),

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 2.5.h),
                      /// 🔹 Search Bar
                      Row(
                        children: [
                          // 🔍 Search Bar
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
                                        onTap: (){
                                          searchController.isSearch.value = true;
                                        },
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Search here...",
                                          hintStyle: TextStyle(
                                            color: searchColor,
                                            fontSize: 15.sp,
                                          ),
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

                          SizedBox(width: 3.w), // spacing between search and button

                          // 🎯 Circular Filter Button
                          InkWell(
                            onTap: (){
                              showModalBottomSheet(context: context, builder: (context) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.sp,), topRight: Radius.circular(20.sp,))
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          customText(text: 'Filters', fontSize: 17.sp, fontWeight: FontWeight.w600),
                                          Spacer(),
                                          Icon(Icons.cancel_outlined, size: 18.sp,)
                                        ],
                                      ),
                                      SizedBox(height: 1.h,),
                                      Divider(),
                                      SizedBox(height: 1.h,),
                                      customButton('Apply', color: ticketBlueColor, textColor: whiteColor),
                                      SizedBox(height: 0.8.h,),
                                      customButton('Clear', color: whiteColor, textColor: ticketBlueColor, borderColor: ticketBlueColor)
                                    ],
                                  ),
                                );
                              },);
                            },
                            child: Container(
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
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),

                      /// 🔹 Tabs
                      // Obx(
                      //       () => Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       ...List.generate(
                      //         controller.discoverList.length,
                      //             (index) {
                      //           final item = controller.discoverList[index];
                      //           final isSelected =
                      //               controller.discoverIndex.value == index;
                      //
                      //           return Padding(
                      //             padding: EdgeInsets.only(
                      //               right: index ==
                      //                   controller.discoverList.length - 1
                      //                   ? 0
                      //                   : 1.1.w,
                      //             ),
                      //             child: InkWell(
                      //               onTap: () => controller.switchDiscoverTab(index),
                      //               borderRadius: BorderRadius.circular(25.sp),
                      //               child: Container(
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(25.sp),
                      //                   color: isSelected
                      //                       ? selectedTabColor
                      //                       : whiteColor,
                      //                   border: Border.all(
                      //                     color: textfieldBorderColor,
                      //                     width: 0.2.w,
                      //                   ),
                      //                 ),
                      //                 child: Padding(
                      //                   padding: EdgeInsets.symmetric(
                      //                     horizontal: 2.38.w,
                      //                     vertical: 0.4.h,
                      //                   ),
                      //                   child: customText(
                      //                     text: item,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 13.sp,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //
                      //       /// ➕ Add Button
                      //       InkWell(
                      //         onTap: () {},
                      //         borderRadius: BorderRadius.circular(25.sp),
                      //         child: Container(
                      //           padding: EdgeInsets.symmetric(
                      //             horizontal: 1.8.w,
                      //             vertical: 0.4.h,
                      //           ),
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: whiteColor,
                      //             border: Border.all(
                      //               color: textfieldBorderColor,
                      //               width: 0.2.w,
                      //             ),
                      //           ),
                      //           child: Icon(Icons.add, size: 16.sp),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 2.h),

                      Obx(() =>
                      searchController.isSearch.value == false ?
                      Column(
                        children: [
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
                      ): Column(
                        children: [
                          SizedBox(height: 1.h,),
                          Row(
                            children: [
                              customText(
                                  text: 'Recent Searches',
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w600
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  customText(
                                      text: 'Clear All',
                                      height: 0,
                                    fontSize: 14.sp
                                  ),

                                  Container(
                                    height: 0.1.h,
                                    width: 12.2.w,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h,),
                          options('Educational'),
                          options('Music'),
                          options('Business'),
                          options('Motivational'),
                        ],
                      ),
                      ),
                      SizedBox(height: 13.h),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 👇 Fixed AppBar with Blur
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(() => searchController.isSearch.value == false ? customAppBar("Discover Events"): Padding(
              padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      searchController.isSearch.value = false;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: textfieldBorderColor,
                              width: 0.2.w
                          )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.w),
                        child: Icon(Icons.arrow_back,size: 19.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 27.w),
                  customText(
                    text: 'Search',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ))
          ),
        ],
      ),
    );
  }
}
Widget options(String title){
  return Column(
    children: [
      Row(
        children: [
          customText(
              text: title,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400
          ),
          Spacer(),
          Icon(Icons.cancel_outlined, color: Colors.black.withOpacity(0.5), size: 16.sp,)
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Divider(),
      )
    ],
  );
}