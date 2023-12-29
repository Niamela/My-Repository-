import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  RxBool obscureText = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                  customTextField(hintText: "Email"),
                  SizedBox(height: 10.sp),
                  Obx(() {
                    return TextField(
                      obscureText: obscureText.value,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            splashRadius: 4.sp,
                            icon: Icon(
                              obscureText.value
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 5.sp,
                            ),
                            onPressed: () {
                              obscureText.value = !obscureText.value;
                            }),
                        labelText: "Password",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: HexColor("#FFB8860B"))),
                        enabledBorder: OutlineInputBorder(),
                      ),
                    );
                  }),
                  SizedBox(height: 15.sp),
                  SizedBox(
                    height: 15.sp,
                    width: 40.w,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextField customTextField({
    TextEditingController? controller,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("#FFB8860B"))),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
