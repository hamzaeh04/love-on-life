import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/controllers/navigation_controller.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/core/services/login/google_auth_service.dart';
import 'package:love_on_life/outh_file/local_db_key.dart';
import 'package:love_on_life/widgets/profile_network_image.dart';
import 'package:love_on_life/widgets/success_dialog.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants_widgets.dart';
import '../controllers/drawer_controller.dart';
import '../utils/shared_prefrences_methods.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final BaseService baseService = BaseService();
  final GoogleAuthService googleAuthService = GoogleAuthService();
  final AuthController controller = Get.find<AuthController>();
  final NavigationController navigationController = Get.find<NavigationController>();
  final Drawercontroller drawerController = Get.find<Drawercontroller>();
  final prefs = SharedPreferencesMethod.storage;
  late final date = prefs.getString(LocalDBKeys.JOINDATE);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffF8FCFF), // light bluish-white bg
      shape: const RoundedRectangleBorder(
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.circular(25),
        //   bottomRight: Radius.circular(25),
        // ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),

            /// 🔹 Profile Section
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Obx(() {
                      return ProfileNetworkImage(
                        imageUrl:
                            controller.userProfilePic.value.isNotEmpty
                                ? "${baseService.baseURL}${controller.userProfilePic.value}"
                                : "",
                        size: 11.w,
                        placeholder:
                            "assets/png/home_icons/profile-placeholder.jpg",
                      );
                    }),
                  ],
                ),

                SizedBox(width: 2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => customText(
                        text:
                            controller.userName.value.isNotEmpty
                                ? controller.userName.value
                                : "User Name",
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 0,
                      ),
                    ),
                    customText(
                      text: "Joined since ${drawerController.formatYear(date)}",

                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.h),

            /// 🔹 Drawer Menu Items
            drawerTile(
              'assets/png/drawer_icons/profile.png',
              "My Profile",
              ontap: () {
                Get.toNamed("profile");
                print(controller.date.value);
              },
            ),
            drawerTile(
              'assets/png/drawer_icons/myevents.png',
              "My Events",
              ontap: () {
                Get.toNamed("myevent");
              },
            ),
            drawerTile(
              'assets/png/drawer_icons/favorites.png',
              "Favorites",
              ontap: () {
                Get.toNamed("favourite");
              },
            ),
            drawerTile(
              'assets/png/drawer_icons/CreditCard.png',
              "Payment Methods",
              ontap: () {
                Get.toNamed("card");
              },
            ),
            drawerTile(
              'assets/png/drawer_icons/FAQs.png',
              "Privacy Policy",
              ontap: () {
                controller.openPrivacyPolicy();
              },
            ),
            drawerTile(
              'assets/png/drawer_icons/conditions.png',
              "Terms & Conditions",
              ontap: () {
                controller.openTerms();
              },
            ),

            const Spacer(),

            // / 🔹 Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  successDialog(
                    context,
                    'Oops!',
                    'Are you sure you want to logout?',
                    "No",
                    buttonText2: "Yes",
                    isLogout: true,
                    ontap2: () {
                      controller.logout(context);
                      googleAuthService.logout();
                      navigationController.goToHome();
                    },
                    () {
                      Get.back();
                    },
                  );
                },
                icon: Icon(Icons.logout, color: Colors.black, size: 17.sp),
                label: customText(
                  text: "Logout",
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(
                    0xffFFF5F5,
                  ), // ✅ Added background color
                  side: const BorderSide(color: Color(0xffFD6B68), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.6.h),
                ),
              ),
            ),
            SizedBox(height: 8.h),

            /// 🔹 Logout Button at the END
            // Padding(
            //   padding: EdgeInsets.only(bottom: 2.h),
            //   child: Center(
            //     child: customButton(
            //       'Logout',
            //       path: 'assets/png/drawer_icons/Logout.png',
            //       width: 70.w,
            //       height: 6.h,
            //       color: const Color(0xffFD6B68),
            //       textColor: Colors.white,
            //       fontsize: 15.sp,
            //       fontweight: FontWeight.w600, //BorderRadius.circular(50),
            //       ontap: () {
            //         // 🔹 Add your logout logic here
            //         Navigator.pop(context);
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// Custom drawer tile widget
  Widget drawerTile(String path, String title, {VoidCallback? ontap}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 0.h),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: ontap,
                child: Row(
                  children: [
                    Image.asset(path, width: 6.5.w),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: customText(
                        text: title,

                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                      size: 22.sp,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.2.h),
                child: Divider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:love_on_life/widgets/custom_button.dart';
// import '../constants/constants_widgets.dart';
// import 'custom_drawer.dart'; // use your existing CustomDrawer here

class AnimatedDrawerScreen extends StatefulWidget {
  const AnimatedDrawerScreen({super.key});

  @override
  State<AnimatedDrawerScreen> createState() => _AnimatedDrawerScreenState();
}

class _AnimatedDrawerScreenState extends State<AnimatedDrawerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void toggleDrawer() {
    if (isDrawerOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FCFF),
      body: Stack(
        children: [
          /// Drawer behind main content
          CustomDrawer(),

          /// Main screen with transformation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double slide = 250 * _controller.value;
              double scale = 1 - (0.2 * _controller.value); // vertical shrink
              double verticalPadding = 40 * _controller.value;

              return Transform(
                transform:
                    Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (isDrawerOpen) toggleDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        25 * _controller.value,
                      ),
                      boxShadow: [
                        if (isDrawerOpen)
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: const Offset(-5, 5),
                          ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        25 * _controller.value,
                      ),
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: Colors.pinkAccent,
                          elevation: 0,
                          leading: IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: toggleDrawer,
                          ),
                          title: const Text(
                            "Home Screen",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        body: Center(
                          child: Text(
                            "Main Content",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
