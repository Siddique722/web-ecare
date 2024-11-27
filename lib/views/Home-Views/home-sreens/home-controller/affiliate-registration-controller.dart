import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

  class AffiliateRegistrationController extends GetxController {
    // Controllers for text fields
    final TextEditingController panController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController upiController = TextEditingController();

    // Observables for loading and user data
    var isLoading = false.obs;
    var userEmail = ''.obs;
    var userName = ''.obs;
    var userpan=''.obs;
    var balance=''.obs;

    // Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch user data
    void fetchUserData() async {
      try {
        isLoading(true);
        final userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId == null) {
          Get.snackbar('Error', 'User not logged in');
          return;
        }

        final docSnapshot =
        await firestore.collection('ReferData').doc(userId).get();

        if (docSnapshot.exists) {
          userEmail.value = docSnapshot['userEmail'];
          userName.value = docSnapshot['userName'];
          balance.value=docSnapshot['balance'];
          userpan.value=docSnapshot['pan'];
        } else {
          Get.snackbar('Error', 'User data not found');
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading(false);
      }
    }

    // Update user data
    void updateUserData() async {
      if (panController.text.isEmpty ||
          addressController.text.isEmpty ||
          upiController.text.isEmpty) {
        Get.snackbar('Error', 'All fields are required');
        return;
      }

      try {
        isLoading(true);
        final userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId == null) {
          Get.snackbar('Error', 'User not logged in');
          return;
        }

        await firestore.collection('ReferData').doc(userId).update({
          'pan': panController.text,
          'address': addressController.text,
          'upi': upiController.text,
        });

        Get.snackbar('Success', 'Details updated successfully');
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading(false);
      }
    }

    @override
    void onInit() {
      super.onInit();
      fetchUserData();
    }
  }

