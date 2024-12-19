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

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxMap<String, dynamic> userProfileData = <String, dynamic>{}.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController primaryContactController =
      TextEditingController();
  final TextEditingController emergencyContact1Controller =
      TextEditingController();
  final TextEditingController emergencyContact2Controller =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final RxString imagePath = ''.obs;

  String userID = '';
  String userEmail = '';

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userID = user.uid;
      userEmail = user.email!;
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        selectedImage.value = pickedFile;
        imagePath.value = base64Encode(bytes);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void storeUserData() {
    if (formKey.currentState?.validate() ?? false) {
      // Populate userProfileData map
      userProfileData['name'] = nameController.text;
      userProfileData['primaryContact'] = primaryContactController.text;
      userProfileData['emergencyContact1'] = emergencyContact1Controller.text;
      userProfileData['emergencyContact2'] = emergencyContact2Controller.text;
      userProfileData['dateOfBirth'] = dateController.text;
      userProfileData['profileImage'] = imagePath.value;
      userProfileData['userId'] = userID;
      userProfileData['email'] = userEmail;
      userProfileData['refferId'] = generateRandomCode();

      FirebaseFirestore.instance
          .collection('Users')
          .doc(userID)
          .set(userProfileData.value) // Access the Map with `.value`
          .then((_) {
        print('User data stored successfully.');
        Get.to(() => ComorbitiesView(
              role: 'user', // Replace with actual role if needed
              userProfileData: userProfileData.value,
              userID: userID,
            ));
      }).catchError((error) {
        print('Error storing user data: $error');
      });
    }
  }

  String generateRandomCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    final random = Random();

    String randomDigits =
        List.generate(4, (_) => numbers[random.nextInt(10)]).join();
    String randomAlphabets =
        List.generate(3, (_) => letters[random.nextInt(26)]).join();

    return randomDigits + randomAlphabets;
  }
}

class CreateProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController primaryContactController =
      TextEditingController();
  final TextEditingController emergencyContact1Controller =
      TextEditingController();
  final TextEditingController emergencyContact2Controller =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Observables
  var selectedGender = RxnString();
  var emergencyContact1Relation = RxnString();
  var emergencyContact2Relation = RxnString();
  var selectedBloodGroup = RxnString();
  var imagePath = ''.obs;

  String userID = '';
  String userEmail = '';

  // Firebase-related instances
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userID = user.uid;
        userEmail = user.email ?? '';
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        imagePath.value = base64Encode(bytes); // Save as Base64 string
        print("Image selected and converted to Base64.");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> storeUserData(String? role) async {
    if (formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> userProfileData = {
        'name': nameController.text.trim(),
        'primaryContact': primaryContactController.text.trim(),
        'emergencyContact1': emergencyContact1Controller.text.trim(),
        'relation1': emergencyContact1Relation.value ?? '',
        'emergencyContact2': emergencyContact2Controller.text.trim(),
        'relation2': emergencyContact2Relation.value ?? '',
        'gender': selectedGender.value ?? '',
        'bloodGroup': selectedBloodGroup.value ?? '',
        'dateOfBirth': dateController.text.trim(),
        'profileImage': imagePath.value,
        'userId': userID,
        'email': userEmail,
        'refferId': _generateRandomCode(),
      };

      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userID)
            .set(userProfileData);
        print("User Profile Data Stored Successfully");
        Get.to(() => ComorbitiesView(
              role: role,
              userProfileData: userProfileData,
              userID: userID,
            ));
      } catch (e) {
        print("Failed to store user profile data: $e");
        Get.snackbar("Error", "Failed to store user profile data.");
      }
    }
  }

  String _generateRandomCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    Random random = Random();

    String randomDigits =
        List.generate(4, (index) => numbers[random.nextInt(10)]).join();
    String randomAlphabets =
        List.generate(3, (index) => letters[random.nextInt(26)]).join();
    return randomDigits + randomAlphabets;
  }
}
