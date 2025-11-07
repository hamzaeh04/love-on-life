import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/views/auth_screens/login_screen.dart';
import 'package:love_on_life/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/success_dialog.dart';

class PaymentDetailScreen extends StatelessWidget {
  const PaymentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customHeader("Select Card"),
            SizedBox(height: 4.h),
            customText(
                text: 'Enter your credit card details to proceed\nwith payment',
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: loginGreyColor
            ),
            SizedBox(height: 2.h),
            defaultTextFeild("Cardholder Name", "Enter cardholder name",isRequired: true),
            SizedBox(height: 1.5.h),
            defaultTextFeild("Credit/Debit Card No", "Enter your card number",isRequired: true),
            SizedBox(height: 1.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: defaultTextFeild("Expiry Date", "Month",isRequired: true)),
                SizedBox(width: 5.w),
                Expanded(child: defaultTextFeild("", "Year",isRequired: true,istitle: false,isSuffix: true)),
              ],
            ),
            SizedBox(height: 1.5.h),
            defaultTextFeild("CVV", "Enter CVV number",isRequired: true),
            SizedBox(height: 1.5.h),
            Row(
              children: [
                checkBox(),
                SizedBox(width: 3.w),
                customText(
                    text: 'Save this card for a faster checkout next time',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: loginGreyColor
                ),
              ],
            ),
            SizedBox(height: 2.h),
            customButton("Confirm",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
              successDialog(context, "Done!", "Your ticket has successfully placed!", "Ok", (){
                Get.back();
              });
            }),
          ],
        ),
      ),
    );
  }
}
