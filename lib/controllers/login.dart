
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_router/go_router.dart';

import '../constants/constants.dart';
import '../router/routes.dart';

class LoginController extends GetxController {
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(context) async {
    try {
      isLoading(true);
      if (email.isNotEmpty && password.isNotEmpty) {
        saveLoginState(context);
        await auth.signInWithEmailAndPassword(
            email: email.value, password: password.value);
        GoRouter.of(context).pushReplacement(AppPaths.homepath);
      } else {
        Get.snackbar('Error', 'Login failed. Check your credentials.');
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', 'Login failed. Check your credentials.');
    }
  }

  Future<void> logout(context) async {
    try {
      saveLoginOutState(context);
      await auth.signOut();
      GoRouter.of(context).pushReplacement(AppPaths.initialPath);
    } catch (e) {
      Get.snackbar('Error', 'Logout failed. $e');
    }
  }
}