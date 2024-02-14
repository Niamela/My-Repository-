import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';

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
          toast(msg: '${AppLocalizations.of(context)!.loggedIn}...');
          saveLoginState(context);
          GoRouter.of(context).pushReplacement(AppPaths.homepath);
        } else {
          toast(msg: '${AppLocalizations.of(context)!.loggedIn}...');
        }
      } else {
        toast(msg: '${AppLocalizations.of(context)!.enterEmailAndPasswordToLogin}.');
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print("object $e");
      toast(msg: " '${AppLocalizations.of(context)!.loginFailedPleaseTryAgainLater}.' ($e)");
    }
  }

  Future<void> logout(context) async {
    try {
      saveLoginOutState(context);
      await auth.signOut();
      GoRouter.of(context).pushReplacement(AppPaths.initialPath);
      toast(msg: '${AppLocalizations.of(context)!.loggedOut}...');
    } catch (e) {
      toast(msg: '${AppLocalizations.of(context)!.logoutFailed}.');
    }
  }
}
