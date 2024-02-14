import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/controllers/sign_up.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';
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
                      hintText: AppLocalizations.of(context)!.name,
                      controller: signUpController.nameController.value),
                  sizedBox,
                  customTextField(
                      hintText: AppLocalizations.of(context)!.email,
                      controller: signUpController.emailController.value),
                  sizedBox,
                  customTextField(
                      hintText:AppLocalizations.of(context)!.mobileNumber,
                      controller: signUpController.mobileController.value),
                  sizedBox,
                  customTextField(
                      hintText:AppLocalizations.of(context)!.password,
                      controller: signUpController.passwordController.value),
                  sizedBox,
                  customTextField(
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      controller:
                          signUpController.confirmPasswordController.value),
                  sizedBox,
                  sizedBox,
                  SizedBox(
                    height: 15.sp,
                    width: 40.w,
                    child: Obx(() {
                      return ElevatedButton(
                        onPressed: () {
                          signUpController.signup(context);
                        },
                        child: signUpController.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                               AppLocalizations.of(context)!.signUp,
                                style: TextStyle(fontSize: 6.sp),
                              ),
                      );
                    }),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${AppLocalizations.of(context)!.alreadyHaveAnAccount}? "),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppPaths.loginPath);
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.5.sp))),
                          child: Text(AppLocalizations.of(context)!.login))
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
      decoration: InputDecoration(
        labelText: hintText,
        focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
