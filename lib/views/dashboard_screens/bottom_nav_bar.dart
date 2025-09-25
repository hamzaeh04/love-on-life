import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/controllers/navigation_controller.dart';
import 'package:love_on_life/views/dashboard_screens/community_screen.dart';
import 'package:love_on_life/views/dashboard_screens/discover_screen.dart';
import 'package:love_on_life/views/dashboard_screens/event_details_screen.dart';
import 'package:love_on_life/views/dashboard_screens/home_screen.dart';
import 'package:love_on_life/views/dashboard_screens/profile_screen.dart';
import 'package:love_on_life/views/dashboard_screens/ticket_screen.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final NavigationController controller = Get.find<NavigationController>();
  late PageController _pageController;

  final List<Widget> pages = [
    HomeScreen(),
    DiscoverScreen(),
    CommunityScreen(),
    TicketScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: controller.currentIndex.value);


    // Expose this page controller to the controller manually
    controller.setPageController(_pageController);

    // Listen to current index and move page
    controller.currentIndex.listen((index) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(index);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 10.h, // jitna space blur lena hai (padding + nav bar)
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // 👇 Blur sirf is chhoti height ke andar apply hoga
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      height: 11.h, // blur ke liye same height
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ),

            // 👇 Actual nav bar
            Padding(
              padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 4.h),
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    navItem("assets/png/bottom_nav_icon/home-2.png", 0, 'Home'),
                    navItem("assets/png/bottom_nav_icon/compass.png", 1, 'Discover'),
                    navItem("assets/png/bottom_nav_icon/community.png", 2, 'Community'),
                    navItem("assets/png/bottom_nav_icon/ticket.png", 3, 'Tickets'),
                    navItem("assets/png/bottom_nav_icon/profile.png", 4, 'Profile'),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),



    );
  }

  Widget navItem(String iconPath, int index, String label) {
    bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.changePage(index);
        _pageController.jumpToPage(index);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.sp),
              color: isSelected ? containerBgBlueColor : null,
            ),
            child: Padding(
              padding: isSelected ? EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.5.h): EdgeInsets.zero,
              child: Row(
                children: [
                  Image.asset(
                    iconPath,
                    height: 19.sp,
                    color// 👈 no color apply
                  : (isSelected ? index == 4 ? null : navIconBlueColor : index == 4 ? null : navIconGreyColor),

            ),
                  SizedBox(width: 2.w),
                  if(isSelected)
                    customText(
                      text: label,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: blackColor
                    ),
                    // Text(label, style: TextStyle(fontSize: 12.sp, color: blackColor)),

                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
}
