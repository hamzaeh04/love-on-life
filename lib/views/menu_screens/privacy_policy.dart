import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/utils/color_constants.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/success_dialog.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeader("Privacy Policy",padding: 21.w),
              SizedBox(height: 2.h),
              customText(
                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis commodo egestas massa, at euismod neque commodo in. Maecenas ipsum urna, vestibulum eu mollis nec, malesuada vel felis. Phasellus ultricies elementum justo, a viverra ipsum efficitur eget. Etiam cursus malesuada pretium. Nam nec massa at augue malesuada consequat. Nulla gravida placerat molestie. In eleifend felis bibendum malesuada cursus. Fusce sed auctor ex, a sollicitudin velit. Morbi sed lacinia lorem. Nam eu fermentum mauris, vitae lobortis ipsum. In a gravida ligula, dapibus cursus orci.',
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w400,
                  color: blackColor
              ),
              SizedBox(height: 2.h),
              customText(
                  text: 'Vestibulum id pretium lacus, ac elementum arcu. Maecenas imperdiet ipsum id augue suscipit, et mollis enim semper. Vestibulum in eleifend nisi, ut placerat dolor. Sed vestibulum id tortor quis pellentesque. Nullam posuere, mi a elementum tristique, erat magna blandit diam, ut convallis nunc arcu eu ex. Nunc et neque pellentesque, luctus turpis eu, ornare orci. Suspendisse eros ante, ullamcorper eu feugiat eget, tincidunt quis diam. Sed non tincidunt tortor. Mauris semper magna quis diam ultrices, non tempus diam condimentum. Donec arcu eros, efficitur ac dictum et, placerat at sem. Nullam tincidunt eros non ipsum aliquam, ac rutrum erat varius.',
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w400,
                  color: blackColor
              ),
              SizedBox(height: 2.h),
              customText(
                  text: 'Aenean dui magna, facilisis id pellentesque vitae, ultrices eget ipsum. Fusce et fermentum metus, condimentum tempor quam. Nam iaculis ultricies nisi facilisis suscipit. Nunc interdum libero eu egestas bibendum. In id felis eu odio maximus ornare. Suspendisse consectetur gravida ligula, eget volutpat enim tempor non. Donec nec sem malesuada, mattis velit ac, malesuada lectus. Sed blandit leo sed mauris commodo, non sollicitudin lectus efficitur. Etiam eu felis sed tellus sodales auctor eu sed nisl. Donec id rutrum quam, eu hendrerit orci. In vestibulum id odio nec placerat. Nam vulputate augue ac iaculis imperdiet.',
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w400,
                  color: blackColor
              ),
              SizedBox(height: 3.5.h),
            ],
          ),
        ),
      ),
    );
  }
}
