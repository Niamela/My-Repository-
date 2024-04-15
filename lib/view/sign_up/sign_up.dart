import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/controllers/sign_up.dart';
import 'package:sizer/sizer.dart';

import '../../router/routes.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final signUpController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            topMenuBar(context),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              child: Column(
                children: [
                  customTextField(
                      hintText: "Name",
                      controller: signUpController.nameController.value),
                  sizedBox,
                  customTextField(
                      hintText: "Email",
                      controller: signUpController.emailController.value),
                  sizedBox,
                  customTextField(
                      hintText: "Mobile number",
                      controller: signUpController.mobileController.value),
                  sizedBox,
                  customTextField(
                      hintText: "Password",
                      controller: signUpController.passwordController.value),
                  sizedBox,
                  customTextField(
                      hintText: "Confirm Password",
                      controller:
                          signUpController.confirmPasswordController.value),
                  sizedBox,
                  sizedBox,
                  SizedBox(
                    height: 15.sp,
                    width: 40.w,
                    child: Obx(() {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () {
                          signUpController.signup(context);
                        },
                        child: signUpController.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 6.sp, color: Colors.white),
                              ),
                      );
                    }),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppPaths.loginPath);
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.5.sp))),
                          child: Text(
                            "Login",
                            style: TextStyle(color: mainColor),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final sizedBox = SizedBox(
    height: 7.sp,
  );

  TextField customTextField(
      {TextEditingController? controller, String? hintText}) {
    return TextField(
      controller: controller,
      cursorColor: mainColor,
      style: TextStyle(color: mainColor),
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: mainColor),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
