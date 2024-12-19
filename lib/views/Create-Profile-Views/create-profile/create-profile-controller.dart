import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecare/views/Create-Profile-Views/combrobities.dart';
import 'package:ecare/widgets/date-field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:ecare/constants/linker.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TextEditingController instances
  final nameController = TextEditingController();
  final primaryContactController = TextEditingController();
  final emergencyContact1Controller = TextEditingController();
  final emergencyContact2Controller = TextEditingController();
  final dateController = TextEditingController();

  // Reactive variables
  var selectedGender = ''.obs;
  var emergencyContact1Relation = ''.obs;
  var emergencyContact2Relation = ''.obs;
  var selectedBloodGroup = ''.obs;

  var userID = ''.obs;
  var userEmail = ''.obs;
  var imagePath = ''.obs; // To store Base64 image data
  final Rx<XFile?> imageFile = Rx<XFile?>(null);

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userID.value = user.uid;
      userEmail.value = user.email ?? '';
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        imageFile.value = pickedFile;
        imagePath.value = base64Encode(bytes); // Save as Base64 string
        Get.snackbar("Success", "Image selected successfully!");
      } else {
        Get.snackbar("No Image", "No image selected.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  void storeUserData() {
    if (formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> userProfileData = {
        'name': nameController.text,
        'primaryContact': primaryContactController.text,
        'emergencyContact1': emergencyContact1Controller.text,
        'relation1': emergencyContact1Relation.value,
        'emergencyContact2': emergencyContact2Controller.text,
        'relation2': emergencyContact2Relation.value,
        'gender': selectedGender.value,
        'bloodGroup': selectedBloodGroup.value,
        'dateOfBirth': dateController.text,
        'profileImage': imagePath.value,
        'userId': userID.value,
        'email': userEmail.value,
        'refferId': _generateRandomCode(),
      };

      FirebaseFirestore.instance
          .collection('Users')
          .doc(userID.value)
          .set(userProfileData)
          .then((_) {
        Get.snackbar("Success", "User profile stored successfully!");
        Get.to(() => ComorbitiesView(
              role: "user",
              userProfileData: userProfileData,
              userID: userID.value,
            ));
      }).catchError((error) {
        Get.snackbar("Error", "Failed to store user profile: $error");
      });
    }
  }

  String _generateRandomCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    var random = Random();

    String randomDigits =
        List.generate(4, (index) => numbers[random.nextInt(10)]).join();
    String randomAlphabets =
        List.generate(3, (index) => letters[random.nextInt(26)]).join();

    return randomDigits + randomAlphabets;
  }
}
