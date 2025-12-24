import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/core/services/base_services.dart';
import 'package:love_on_life/utils/helper_functions.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../controllers/drawer_controller.dart';
import '../../../utils/utility.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_phone_feild.dart';
import '../../../widgets/custom_text_field.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final AuthController controller = Get.find<AuthController>();
  final Drawercontroller drawerController = Get.find<Drawercontroller>();
  final BaseService baseService = BaseService();
  GlobalKey<FormState> editProfile = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
            top: 5.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 5.h),
        child: Form(
          key: editProfile,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeader("Edit Profile"),
              SizedBox(height: 4.h),
              Center(
                child: Obx(() => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200, width: 2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: controller.profilePicture.value != null
                              ? FileImage(File(controller.profilePicture.value!.path))
                              : (controller.userProfilePic.value.isNotEmpty
                              ? NetworkImage("${baseService.baseURL}${controller.userProfilePic.value}")
                              : const AssetImage("assets/png/home_icons/profile-placeholder.jpg")) as ImageProvider,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2.w,
                      bottom: 0.h,
                      child: InkWell(
                        onTap: () => controller.pickProfileImage(),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)],
                          ),
                          child: Image.asset("assets/png/camera_img.png", width: 7.w),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              SizedBox(height: 2.5.h),
              customTextFeild(
                'Full Name',
                controller.userName.value,
                'assets/png/person.png',
                false,
                isRequired: true,
                controller: drawerController.editNameField,
                validator: (value) => HelperFunction.stringValidate(value),
              ),
              SizedBox(height: 1.5.h),
              customTextFeild(
                'Email Address',
                controller.userEmail.value,
                'assets/png/lock.png',
                false,
                isRequired: true,
                controller: controller.editProfileEmail,
                readOnly: true,
              ),
              SizedBox(height: 1.5.h),
              CustomPhoneTextFeild(),
              SizedBox(height: 4.h),
              customButton(
                "Update",
                color: buttonPinkColor,
                fontweight: FontWeight.w700,
                fontsize: 16.sp,
                textColor: whiteColor,
                ontap: () {
                  // Check if form fields are valid
                  bool isFormValid = editProfile.currentState!.validate();

                  // Check if phone number is empty
                  bool isPhoneValid = controller.fullPhoneNumber.value.isNotEmpty;

                  // Check if profile picture is selected
                  bool isImageSelected = controller.profilePicture.value != null;

                  if (isFormValid && isPhoneValid && isImageSelected) {
                    // Everything is filled, proceed
                    File? imageFile = File(controller.profilePicture.value!.path);
                    drawerController.updateProfile(context, profilePicture: imageFile);
                  } else {
                    // Show error message
                    String message = "";
                    if (!isFormValid) {
                      message += "Please enter your full name.\n";
                    }
                    if (!isPhoneValid) {
                      message += "Please enter your phone number.\n";
                    }
                    if (!isImageSelected) {
                      message += "Please select a profile picture.\n";
                    }
                    Utils.showToast('Please fill all required fields', true);

                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}