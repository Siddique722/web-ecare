import 'package:demo_app/constants/linker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userId = ''.obs;
  RxInt pendingRequestsCount = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        userEmail.value = currentUser.email!;
        userId.value = currentUser.uid;

        final userDoc = await FirebaseFirestore.instance
            .collection('UsersData')
            .where('userEmail', isEqualTo: userEmail.value)
            .get();

        if (userDoc.docs.isNotEmpty) {
          userName.value = userDoc.docs.first['userName'];
        }

        fetchPendingRequestsCount();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data.');
    }
  }

  Future<void> fetchPendingRequestsCount() async {
    try {
      final requestDocs = await FirebaseFirestore.instance
          .collection('authenticationRequests')
          .where('email', isEqualTo: userEmail.value)
          .where('status', isEqualTo: 'pending')
          .get();

      pendingRequestsCount.value = requestDocs.docs.length;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch pending requests count.');
    }
  }

  Future<void> handleDeleteAccount() async {
    final bool confirm = await Get.dialog(
      AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      isLoading.value = true;

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.delete();
          Get.snackbar('Success', 'Account deleted successfully.');
          Get.offAllNamed('/login');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          Get.snackbar('Error', 'You need to re-login before deleting your account.');
        } else {
          Get.snackbar('Error', 'An error occurred. Please try again.');
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
  Future<void> handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Get.delete<HomeController>(); // Deletes the current instance of HomeController
    Navigator.pushReplacement(
      context,
      CupertinoDialogRoute(
        builder: (context) => LoginView(),
        context: context,
      ),
    );
  }

 //  Future<void> handleLogout(BuildContext context) async {
 //    await FirebaseAuth.instance.signOut();
 //  //  Get.offAllNamed('/login');
 // Navigator.pushReplacement(context, CupertinoDialogRoute(builder: (context)=>LoginView(), context: context));
 //  }

}
