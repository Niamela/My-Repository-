import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/controllers/login.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_mining_supplier/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../l10n/support_locale.dart';
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

List<String> loginSignup = [
  "login",
  "signup",
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
              if (GoRouter.of(context).location != AppPaths.homepath) {
                GoRouter.of(context).pushReplacement(AppPaths.homepath);
              }
            },
            child: Image.asset(
              companyLogo,
              scale: 4.5,
            ),
          ),
        ),
        // GoRouter.of(context).location == AppPaths.homepath
        //     ? Row(
        //         children: List.generate(menuNames.length, (index) {
        //           return InkWell(
        //               hoverColor: Colors.blueGrey,
        //               onTap: () {
        //                 if (index == 0) {
        //                   GoRouter.of(context)
        //                       .push(AppPaths.supplierProfilePath);
        //                 }
        //               },
        //               child: Container(
        //                   padding: EdgeInsets.only(
        //                       left: 10.sp,
        //                       right: 10.sp,
        //                       top: 5.sp,
        //                       bottom: 5.sp),
        //                   child: Text(
        //                     menuNames[index],
        //                     style: TextStyle(fontSize: 5.sp),
        //                   )));
        //         }),
        //       )
        //     : SizedBox(),
        FirebaseAuth.instance.currentUser != null
            ? Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.sp),
                    child: IconButton(
                      hoverColor: Colors.white,
                      splashRadius: 8.sp,
                      icon: Icon(Icons.power_settings_new_sharp),
                      onPressed: () {
                        loginController.logout(context);
                      },
                    ),
                  ),
                  GoRouter.of(context).location == AppPaths.userProfilePath
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              right: 10.sp, top: 2.sp, bottom: 2.5.sp),
                          child: InkWell(
                            splashColor: Colors.white,
                            radius: 8.sp,
                            onTap: () {
                              if (GoRouter.of(context).location !=
                                  AppPaths.userProfilePath) {
                                GoRouter.of(context)
                                    .push(AppPaths.userProfilePath);
                              } else {
                                loginController.logout(context);
                              }
                            },
                            hoverColor: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp),
                            child: CircleAvatar(
                              maxRadius: 6.sp,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                ],
              )
            : GoRouter.of(context).location == AppPaths.loginPath ||
                    GoRouter.of(context).location == AppPaths.signUpPath ||
                    FirebaseAuth.instance.currentUser != null
                ? StatefulBuilder(builder: (context, state) {
                    return SizedBox(
                      height: 10.sp,
                      width: 30.sp,
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(5.sp),
                        padding: EdgeInsets.only(left: 2.5.sp),
                        underline: Container(),
                        elevation: 0,
                        focusColor: Colors.transparent,
                        dropdownColor: mainColor,
                        alignment: Alignment.center,
                        icon: Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text(
                              AppLocalizations.of(context)!.english,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DropdownMenuItem(
                              value: 'fr',
                              child: Text(AppLocalizations.of(context)!.french,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ],
                        onChanged: (v) {
                          state(() {
                            L10n.lang = v!;
                            context.read<LocaleProvider>().setLocale(Locale(v));
                          });
                        },
                        value: L10n.lang,
                      ),
                    );
                  })
                : Padding(
                    padding: EdgeInsets.only(right: 5.sp),
                    child: Row(children: [
                      TextButton(
                          onPressed: () {
                            if (GoRouter.of(context).location !=
                                AppPaths.aboutUs) {
                              GoRouter.of(context).push(AppPaths.aboutUs);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.aboutUs,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 5.sp,
                                fontWeight: FontWeight.bold),
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 10.sp),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              GoRouter.of(context).push(AppPaths.loginPath);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(color: mainColor),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              GoRouter.of(context).push(AppPaths.signUpPath);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUp,
                              style: TextStyle(color: mainColor),
                            )),
                      ),
                      StatefulBuilder(builder: (context, state) {
                        return SizedBox(
                          height: 10.sp,
                          width: 30.sp,
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(5.sp),
                            padding: EdgeInsets.only(left: 2.5.sp),
                            underline: Container(),
                            elevation: 0,
                            focusColor: Colors.transparent,
                            dropdownColor: mainColor,
                            alignment: Alignment.center,
                            icon: Icon(
                              Icons.language,
                              color: Colors.white,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text(
                                  AppLocalizations.of(context)!.english,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DropdownMenuItem(
                                  value: 'fr',
                                  child: Text(
                                      AppLocalizations.of(context)!.french,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ],
                            onChanged: (v) {
                              state(() {
                                L10n.lang = v!;
                                context
                                    .read<LocaleProvider>()
                                    .setLocale(Locale(v));
                              });
                            },
                            value: L10n.lang,
                          ),
                        );
                      }),
                    ]),
                  ),
      ],
    ),
  );
}
