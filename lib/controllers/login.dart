import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../constants/constants.dart';
import '../router/routes.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(context) async {
    try {
      isLoading(true);
      if (emailController.value.text.isNotEmpty &&
          passwordController.value.text.isNotEmpty) {
        UserCredential user = await auth.signInWithEmailAndPassword(
            email: emailController.value.text,
            password: passwordController.value.text);
        if (user.user != null) {
          toast(msg: "Logged in...");
          saveLoginState(context);
          GoRouter.of(context).pushReplacement(AppPaths.homepath);
        } else {
          toast(msg: "Logged in...");
        }
      } else {
        toast(msg: "Enter email and password to login.");
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print("object $e");
      toast(msg: "Login failed. Please try again later. ($e)");
    }
  }

  Future<void> logout(context) async {
    try {
      saveLoginOutState(context);
      await auth.signOut();
      GoRouter.of(context).pushReplacement(AppPaths.initialPath);
      toast(msg: "Logged out...");
    } catch (e) {
      toast(msg: "Logout failed.");
    }
  }
}
