import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            SizedBox(height: 6.h),
            Row(
              children: [
                Container(
                  height: 12.w,
                  width: 12.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //color: Colors.yellow
                  ),
                  child: Image.asset('assets/png/profile.png'),
                ),
                SizedBox(width: 1.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customText(
                      text: 'Eddie Sanz',
                      fontFamily: 'dmsans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 0.15.h,
                    ),
                    customText(
                      text: 'Joined since 2023',
                      fontFamily: 'dmsans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF83848D),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.5.w,
                    vertical: 1.h,
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    color: Colors.white,
                    border: Border.all(color: textfieldBorderColor),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/png/edit_icon.png', width: 3.w),
                      SizedBox(width: 2.w),
                      customText(
                        text: 'Edit Profile',
                        fontFamily: 'dmsans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h,),
            items('assets/png/event_icon.png', 'My Events', path2: 'assets/png/arrow-right.png', isLast: false),
            items('assets/png/payment_icon.png', 'Payment Methods', path2: 'assets/png/arrow-right.png', isLast: false),
            items('assets/png/billing_icon.png', 'Billings & Invoices', path2: 'assets/png/arrow-right.png', isLast: false),
            items('assets/png/security_icon.png', 'Password & Security', path2: 'assets/png/arrow-right.png', isLast: false),
            items('assets/png/preference_icon.png', 'App Preferences', path2: 'assets/png/arrow-right.png', isLast: false),
            items('assets/png/logout_icon.png', 'Logout',),
          ],
        ),
      ),
    );
  }
}
Widget items(String path, String title, {String? path2, bool? isLast}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 2.w, top: 1.8.h, bottom: 1.8.h),
        child: Row(
          children: [
            Image.asset(path, width: 4.5.w,),
            SizedBox(width: 4.w,),
            customText(
              text: title,
              fontFamily: 'dmsans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,

            ),
            Spacer(),
            path2 != null ? Image.asset(path2!, width: 5.w,): SizedBox.shrink()
          ],
        ),
      ),
      isLast == false ? Divider(
        thickness: 1.2,
      ): SizedBox.shrink()
    ],
  );
}
