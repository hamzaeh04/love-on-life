import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/outh_file/local_db_key.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:love_on_life/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/custom_header.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                    text: "Terms & Conditions",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),

              SizedBox(height: 2.h),
             customText(
                text: termsAndConditions,
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              SizedBox(height: 2.h),
              customButton("Accept", color: buttonPinkColor, textColor: whiteColor, fontweight: FontWeight.w500, ontap: () async {
                final prefs = SharedPreferencesMethod.storage;
                await prefs.setBool(LocalDBKeys.FIRSTTIMEOPENAPP, true);
                Get.offAllNamed("/getstarted");
              })
            ],
          ),
        ),
      ),
    );
  }
}
const String termsAndConditions = '''
Effective Date: April 15, 2026

1. Use of the App
You agree to use the app only for lawful purposes and in a way that does not harm others or interfere with its operation.

2. Eligibility
You must be at least 18 years old (or minimum age in your jurisdiction).

3. Content
Any content must be respectful and legal. We may remove content at any time.

4. Privacy
Your use of the app is governed by our Privacy Policy.

5. Intellectual Property
All content belongs to Love On Life Foundation.

6. Limitation of Liability
We are not liable for any damages from app usage.

7. Changes
We may update these terms anytime.

8. Contact
Email: loveonlifefoundation@gmail.com
''';