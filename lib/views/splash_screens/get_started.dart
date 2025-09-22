import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:love_on_life/constants/constants_widgets.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              colors: [
                Color(0xFF030C1A),
                Color(0xFF09395B),
              ],
              stops: [0.4, 1],
            ),

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Image.asset("assets/png/splash_one_logo.png",height: 27.h,width: 80.w),
              Image.asset("assets/png/splash_two_logo.png",height: 13.h,width: 80.w),
              SizedBox(height: 3.5.h),
              customText(
                text: "Join / Discover Events",
                fontSize: 23.sp,
                fontWeight: FontWeight.w700,
                color: whiteColor
              ),
              customText(
                text: "Join an events near by you, interact with\ncommunity with LOVE-ON LIFE",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: whiteColor,
                textAlign: TextAlign.center
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    customButton("Sign Up With Email",color: buttonPinkColor,textColor: whiteColor),
                    SizedBox(height: 1.h),
                    customButton("Join For Free With Google",textColor: blackColor,path: "assets/png/socail_icon/google.png",fontweight: FontWeight.w500),
                    SizedBox(height: 1.h),
                    customButton("Join For Free With Apple",textColor: blackColor,path: "assets/png/socail_icon/apple.png",fontweight: FontWeight.w500),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                            text: "By Signing Up you agree to our",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: whiteColor,
                        ),
                        SizedBox(width: 0.5.w),
                        customText(
                            text: "Terms",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          txtDecoration: TextDecoration.underline,
                          decorationColor: whiteColor,
                          decorationThickness: 2.0
                        ),
                        SizedBox(width: 0.5.w),
                        customText(
                            text: "&",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: whiteColor,
                        ),
                        SizedBox(width: 0.5.w),
                        customText(
                            text: " Privacy Policy.",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            txtDecoration: TextDecoration.underline,
                          decorationColor: whiteColor,
                          decorationThickness: 2.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                          text: "Already Have a Account?",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: whiteColor,
                        ),
                        SizedBox(width: 0.5.w),
                        customText(
                            text: "Sign In",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            txtDecoration: TextDecoration.underline,
                            decorationColor: whiteColor,
                            decorationThickness: 2.0
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
