import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/payment_controller.dart';
import 'package:love_on_life/widgets/custom_header.dart';
import 'package:love_on_life/widgets/success_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_button.dart';

class SelectCardScreen extends StatelessWidget {
  SelectCardScreen({super.key});
  final PaymentController controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Padding(
       padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           customHeader("Select Card"),
           SizedBox(height: 4.h),
           customText(
               text: 'Select your credit card to proceed with\npayment',
               fontSize: 15.sp,
               fontWeight: FontWeight.w400,
               color: loginGreyColor
           ),
SizedBox(height: 2.h),

           Row(children: [
             customText(
                 text: 'Billing Price:',
                 fontSize: 15.5.sp,
                 fontWeight: FontWeight.w500,
                 color: loginGreyColor

             ),
             SizedBox(
               width: 1.w,
             ),customText(
                 text: '\$10.00',
                 fontSize: 15.5.sp,
                 fontWeight: FontWeight.w700,
                 color: loginGreyColor
             ),
           ],),
           SizedBox(height: 3.h),
           Obx(() => Column(
             children: List.generate(controller.cards.length, (index) {
               return Padding(
                 padding: EdgeInsets.only(bottom: 1.5.h),
                 child: cardWidget(
                   path: controller.cards[index]["path"]!,
                   cardNo: controller.cards[index]["no"]!,
                   isSelected: controller.selectedIndex.value == index,
                   onTap: () {
                     controller.selectedIndex.value = index; // ✅ update selected
                   },
                 ),
               );
             }),
           )),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               customText(
                   text: 'Use Another Card',
                   fontSize: 15.sp,
                   fontWeight: FontWeight.w500,
                   color: buttonPinkColor,
                   txtDecoration: TextDecoration.underline,
                   decorationColor: buttonPinkColor
               ),
             ],
           ),
           SizedBox(height: 4.h),
           customButton("Proceed",color: buttonPinkColor,fontweight: FontWeight.w700,fontsize: 16.sp,textColor: whiteColor,ontap: (){
             Get.toNamed("payment");
             // successDialog(context, "Done!", "Your ticket has successfully placed!", "Ok", (){
             //   Get.back();
             // });
           }),
         ],
       ),
     ),
    );
  }
}

Widget cardWidget({
  required String path,
  required String cardNo,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(
          color: greyBorderColor,
          width: 0.3.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: Row(
          children: [
            Image.asset(path, width: 8.w),
            SizedBox(width: 2.w),

            // ✅ Expanded prevents overflow and auto-wraps space
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: customText(
                      text: cardNo,
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w500,
                      color: loginGreyColor,
                    ),
                  ),
                  SizedBox(width: 2.w),

                  if (isSelected)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: greyBorderColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.5.w, vertical: 0.2.h),
                        child: customText(
                          text: "Default",
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                          color: blackColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ✅ Radio button stays at right without overflowing
            Container(
              height: 2.4.h,
              width: 4.8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? blackColor : selectedContainerColor,
                  width: 0.4.w,
                ),
              ),
              child: isSelected
                  ? Padding(
                padding: EdgeInsets.all(0.5.w),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: blackColor,
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    ),
  );
}


