import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/router/routes.dart';

import '../constants/constants.dart';

class SignupController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString mobileNumber = ''.obs;
  RxString occupation = ''.obs;
  RxString linkedIn = ''.obs;
  RxString currentSalary = ''.obs;
  RxBool isExperienced = false.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signup(context) async {
    try {
      isLoading(true);

      if (password.value != confirmPassword.value) {
        Fluttertoast.showToast(msg: "Passwords do not match");
        isLoading(false);
        return;
      }

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      String uid = userCredential.user?.uid ?? '';

      // Store additional user information in a Firebase collection
      await FirebaseFirestore.instance
          .collection('Users_jobportal')
          .doc(uid)
          .set({
        'name': "${firstName.value} ${lastName.value}",
        'email': email.value,
        'mobileNumber': mobileNumber.value,
        'domain': occupation.value,
        'displayPicture': '',
        'linkedIn': linkedIn.value,
        'currentSalary': currentSalary.value,
        'isExperienced': isExperienced.value,
        'role': 'student',
        'created': DateTime.now(),
        'updatedAt': DateTime.now(),
        'id': uid,
        'profileCompletionPercentage': 0,
        'resume_name': "",
        'resumeUrl': "",
        'resume_headline': "",
        'list_of_skills': []
        // Add more fields as needed
      });
      saveLoginState(context);
      GoRouter.of(context).pushReplacement(AppPaths.homepath);
      isLoading(false);
      Get.snackbar('Success', 'Account created successfully!');
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', 'Sign up failed. ${e.toString()}');
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