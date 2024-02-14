import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_mining_supplier/router/routes.dart';

import '../constants/constants.dart';

class SignupController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signup(context) async {
    try {
      isLoading(true);

      if (nameController.value.text.isNotEmpty &&
          emailController.value.text.isNotEmpty &&
          mobileController.value.text.isNotEmpty) {
        if (passwordController.value.text !=
            confirmPasswordController.value.text) {
          Fluttertoast.showToast(
              msg:  '${AppLocalizations.of(context)!.passwordsDoNotMatchPleaseCorrectAndTryAgain}.');
          isLoading(false);
          return;
        } else if (passwordController.value.text.isEmpty ||
            confirmPasswordController.value.text.isEmpty) {
          toast(msg:  '${AppLocalizations.of(context)!.passwordConfirmPasswordCannotBeEmpty}.');
          isLoading(false);
          return;
        }

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text,
        );

        if (userCredential.user != null) {
          String uid = userCredential.user?.uid ?? '';
          // Store additional user information in a Firebase collection
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'name': nameController.value.text,
            'email': emailController.value.text,
            'mobileNumber': mobileController.value.text,
            'displayPicture': '',
            'role': 'supplier',
            'created': DateTime.now(),
            'id': uid,
          });
          saveLoginState(context);
          GoRouter.of(context).pushReplacement(AppPaths.homepath);
          isLoading(false);
          toast(msg:  '${AppLocalizations.of(context)!.accountCreatedSuccessfully}!');
        }
      } else {
        if (nameController.value.text.isEmpty) {
          toast(msg:  '${AppLocalizations.of(context)!.nameCannotBeEmpty}');
        }
        if (emailController.value.text.isEmpty) {
          toast(msg:  '${AppLocalizations.of(context)!.emailCannotBeEmpty}');
        }
        if (mobileController.value.text.isEmpty) {
          toast(msg:  '${AppLocalizations.of(context)!.mobileNumberCannotBeEmpty}');
        }
        isLoading(false);
      }
    } catch (e) {
      print("object signup $e");
      isLoading(false);
      toast(msg: " '${AppLocalizations.of(context)!.signUpFailedPleaseTryAgainLater}' ($e)");
    }
  }

// Rx<Uint8List?> resumeBytes = Rx<Uint8List?>(null);
// final resumeName = ''.obs;
//
// Future<void> selectResume() async {
//   try {
//     FilePickerResult? result = await FilePicker.platform
//         .pickFiles(type: FileType.custom, allowedExtensions: ["PDF"]);
//
//     if (result != null) {
//       // Use `bytes` instead of `path` for web
//       resumeBytes.value = result.files.single.bytes;
//       resumeName.value = result.files.first.name;
//     }
//   } catch (e) {
//     Get.snackbar('Error', 'Failed to pick a file. $e');
//   }
// }
//
// final homeController = Get.put(HomeController());
//
// Future<void> uploadResume() async {
//   try {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       Get.snackbar('Error', 'User not authenticated.');
//       return;
//     }
//
//     if (resumeBytes.value == null) {
//       Get.snackbar('Error', 'Please select a resume to upload.');
//       return;
//     }
//
//     isLoading(true);
//
//     final resumeRef = FirebaseStorage.instance.ref(
//         'resumes_jobPortal/${user.email}/${DateTime.now().millisecondsSinceEpoch}_resume.pdf');
//
//     // Use `putData` instead of `putFile` for web
//     await resumeRef.putData(resumeBytes.value!);
//
//     final resumeUrl = await resumeRef.getDownloadURL();
//
//     // Update the resume link in the user's document
//     await FirebaseFirestore.instance
//         .collection('Users_jobportal')
//         .doc(user.uid)
//         .update({
//       "resume_name": resumeName.value,
//       'resumeUrl': resumeUrl,
//     });
//     homeController.resume_name.value = resumeName.value;
//     homeController.userResumeLink.value = resumeUrl;
//     isLoading(false);
//     Get.snackbar('Success', 'Resume uploaded successfully!');
//   } catch (e) {
//     isLoading(false);
//     Get.snackbar('Error', 'Resume upload failed. $e');
//   }
// }
}
