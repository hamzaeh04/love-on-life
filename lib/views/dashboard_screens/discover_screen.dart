import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/controllers/navigation_controller.dart';
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
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customAppBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: 'Discover Events',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 1.h),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(25.sp),
                    border: Border.all(color: textfieldBorderColor, width: 0.2.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
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
                              border: InputBorder.none,   // 👈 removes all borders
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isCollapsed: true,          // 👈 removes default padding
                              contentPadding: EdgeInsets.only(bottom: 0.2.h), // 👈 no extra padding
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
                            Icon(Icons.keyboard_arrow_down,size: 15.sp)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Obx(() =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 🔹 pehle saare items generate karo
                        ...List.generate(
                          controller.discoverList.length,
                              (index) {
                            final item = controller.discoverList[index];
                            final isSelected = controller.discoverIndex.value == index;

                            return Padding(
                              padding: EdgeInsets.only(right: index == controller.discoverList.length - 1 ? 0 : 1.1.w),
                              child: InkWell(
                                onTap: () {
                                  controller.switchDiscoverTab(index);
                                },
                                borderRadius: BorderRadius.circular(25.sp),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    color: isSelected ? selectedTabColor : whiteColor,
                                    border: Border.all(
                                      color: textfieldBorderColor,
                                      width: 0.2.w,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.43.w, vertical: 0.4.h),
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

                        // 🔹 last me + icon add kar do
                        InkWell(
                          onTap: () {
                            // yahan apni "add new" wali logic laga
                          },
                          borderRadius: BorderRadius.circular(25.sp),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
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
                discoverWidget(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
