import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/controllers/login.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../router/login_state_check.dart';
import '../router/routes.dart';

const String loggedInKey = 'LoggedIn';
const mainColor = Color(0xFFCD7F32);

toast({required String msg}) {
  return Fluttertoast.showToast(msg: msg);
}

void saveLoginState(BuildContext context) {
  Provider.of<LoginState>(context, listen: false).loggedIn = true;
}

void saveLoginOutState(BuildContext context) {
  Provider.of<LoginState>(context, listen: false).loggedIn = false;
}

final companyLogo = "assets/mining_black_white.PNG";

List menuNames = [
  "Home",
  "Careers",
  "About us",
];

List loginSignup = [
  "Login",
  "Sign up",
];

Widget topMenuBar(context) {
  final loginController = Get.put(LoginController());
  return Ink(
    color: mainColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 7.5.sp, top: 2.5.sp, bottom: 2.5.sp),
          child: InkWell(
            onTap: () {
              if (GoRouter.of(context).location == AppPaths.loginPath ||
                  GoRouter.of(context).location == AppPaths.signUpPath) {
              } else {
                GoRouter.of(context).pushReplacement(AppPaths.homepath);
              }
            },
            child: Image.asset(
              companyLogo,
              scale: 4.5,
            ),
          ),
        ),
        GoRouter.of(context).location == AppPaths.homepath
            ? Row(
                children: List.generate(menuNames.length, (index) {
                  return InkWell(
                      hoverColor: Colors.blueGrey,
                      onTap: () {
                        if (index == 0) {
                          GoRouter.of(context)
                              .push(AppPaths.supplierProfilePath);
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 10.sp,
                              right: 10.sp,
                              top: 5.sp,
                              bottom: 5.sp),
                          child: Text(
                            menuNames[index],
                            style: TextStyle(fontSize: 5.sp),
                          )));
                }),
              )
            : SizedBox(),
        FirebaseAuth.instance.currentUser != null
            ? Padding(
                padding: EdgeInsets.only(right: 10.sp),
                child: IconButton(
                  icon: Icon(Icons.power_settings_new_sharp),
                  onPressed: () {
                    loginController.logout(context);
                  },
                ),
              )
            : GoRouter.of(context).location == AppPaths.loginPath ||
                    GoRouter.of(context).location == AppPaths.signUpPath ||
                    FirebaseAuth.instance.currentUser != null
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(right: 10.sp),
                    child: Row(
                      children: List.generate(loginSignup.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 5.sp),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                if (index == 0) {
                                  GoRouter.of(context).push(AppPaths.loginPath);
                                } else {
                                  GoRouter.of(context)
                                      .push(AppPaths.signUpPath);
                                }
                              },
                              child: Text(
                                loginSignup[index],
                                style: TextStyle(color: mainColor),
                              )),
                        );
                      }),
                    ),
                  )
        // GoRouter.of(context).location == AppPaths.userProfilePath ||
        //         GoRouter.of(context).location == AppPaths.homepath
        //     ? Padding(
        //         padding:
        //             EdgeInsets.only(right: 10.sp, top: 2.sp, bottom: 2.5.sp),
        //         child: InkWell(
        //           onTap: () {
        //             if (GoRouter.of(context).location !=
        //                 AppPaths.userProfilePath) {
        //               GoRouter.of(context).push(AppPaths.userProfilePath);
        //             } else {
        //               loginController.logout(context);
        //             }
        //           },
        //           hoverColor: Color(0xFFFFD700),
        //           borderRadius: BorderRadius.circular(10.sp),
        //           child:
        //               GoRouter.of(context).location == AppPaths.userProfilePath
        //                   ? Icon(Icons.power_settings_new_sharp)
        //                   : CircleAvatar(
        //                       maxRadius: 8.sp,
        //                       backgroundImage: CachedNetworkImageProvider(
        //                           "https://fiverr-res.cloudinary.com/t_profile_original,q_auto,f_auto/attachments/profile/photo/3812e851a005c89864aa20fbe7961b72-1675812653471/f918c1dd-9e66-4798-b30d-908aa689431a.jpg"),
        //                     ),
        //         ),
        //       )
        //     : Container()
      ],
    ),
  );
}
