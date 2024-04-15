import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../controllers/login.dart';
import '../../router/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  RxBool obscureText = false.obs;
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: mainColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          topMenuBar(context),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Column(
              children: [
                customTextField(
                    hintText: "Email",
                    controller: loginController.emailController.value),
                SizedBox(height: 10.sp),
                Obx(() {
                  return TextField(
                    obscureText: obscureText.value,
                    cursorColor: mainColor,
                    controller: loginController.passwordController.value,
                    autofillHints: [AutofillHints.password],
                    onSubmitted: (value) {
                      loginController.login(context);
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: mainColor),
                      suffixIcon: IconButton(
                          splashRadius: 4.sp,
                          icon: Icon(
                            obscureText.value
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            size: 5.sp,
                            color: obscureText.value ? Colors.grey : mainColor,
                          ),
                          onPressed: () {
                            obscureText.value = !obscureText.value;
                          }),
                      labelText: "Password",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor("#FFB8860B"))),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  );
                }),
                SizedBox(height: 15.sp),
                SizedBox(
                  height: 15.sp,
                  width: 40.w,
                  child: Obx(() {
                    return ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        loginController.login(context);
                        loginController.emailController.value.clear();
                        loginController.passwordController.value.clear();
                      },
                      child: loginController.isLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 6.sp, color: Colors.white),
                            ),
                    );
                  }),
                ),
                SizedBox(height: 10.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?"),
                    TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppPaths.signUpPath);
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.5.sp))),
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: mainColor),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextField customTextField({
    TextEditingController? controller,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      cursorColor: mainColor,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: mainColor),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("#FFB8860B"))),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
