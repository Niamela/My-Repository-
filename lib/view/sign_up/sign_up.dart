import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../router/routes.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

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
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              child: Column(
                children: [
                  customTextField(hintText: "Email"),
                  sizedBox,
                  customTextField(hintText: "Mobile number"),
                  sizedBox,
                  customTextField(hintText: "Password"),
                  sizedBox,
                  customTextField(hintText: "Confirm Password"),
                  sizedBox,
                  sizedBox,
                  SizedBox(
                    height: 15.sp,
                    width: 20.w,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Sign up'),
                    ),
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
                          child: Text("Login"))
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
