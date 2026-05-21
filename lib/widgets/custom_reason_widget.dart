import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/community_controller.dart';
import '../utils/utility.dart';

void showReasonSheet(BuildContext context, String commentId, String postId,){
  final CommunityController controller = Get.find<CommunityController>();
  String selectedReason;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final List<String> reportReasons = [
        "Spam",
        "Harassment or Bullying",
        "Hate Speech",
        "False Information",
        "Inappropriate Content",
        "Violence",
        "Scam or Fraud",
        "Other",
      ];

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// Drag Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.h),
              height: 0.5.h,
              width: 12.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            /// Title
            customText(
              text: 'Select Reason',
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: blackColor,
            ),

            SizedBox(height: 1.h),

            const Divider(),

            /// Reasons List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: reportReasons.length,
              separatorBuilder: (_, __) => Divider(
                color: Colors.grey.shade200,
                height: 0,
              ),
              itemBuilder: (context, index) {
                final reason = reportReasons[index];

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.3.h,
                  ),
                  title: customText(
                    text: reason,
                    fontSize: 15.sp,
                    color: blackColor,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                  onTap: () {

                    /// API Call Here
                    if(reason != "Other"){
                      print("Selected Reason: $reason");
                      Get.back();
                      if(commentId != ""){
                        controller.reportComment(commentId, postId, reason);
                      } else{
                        controller.reportPost(postId, reason);
                      }
                    } else{
                      controller.isSelected.value = !controller.isSelected.value;
                      print("${reason}, ${controller.isSelected.value}");
                    }
                  },
                );

              },
            ),
            Obx(() {
              if (controller.isSelected.value == true) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.reasonController,
                        decoration: InputDecoration(
                          hintText: "Specify Reason",
                          hintStyle: TextStyle(
                            fontSize: 15.sp
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                      
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      customButton("Submit", color: resetBlueColor, textColor: whiteColor, fontweight: FontWeight.w500, ontap: (){
                        if(controller.reasonController.text.isEmpty || controller.reasonController.value == null){
                          Utils.showToast("Please specify the reason", false);
                        } else{
                          if(commentId != ""){
                            controller.reportComment(commentId, postId, controller.reasonController.text);
                          } else{
                            controller.reportPost(postId, controller.reasonController.text);
                          }
                          Get.back();
                        }
                      })
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            SizedBox(height: 2.h),
          ],
        ),
      );
    },
  );
}