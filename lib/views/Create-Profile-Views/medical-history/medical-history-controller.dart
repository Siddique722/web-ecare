import 'package:ecare/constants/linker.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecare/constants/linker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'dart:html' as html; // Add this import for web-specific handling
import 'dart:typed_data';

class MedicalHistoryController extends GetxController {
  var isLoading = false.obs;
  var medicalHistoryData = <String, dynamic>{}.obs;
  var surgicalHistoryData = <String, dynamic>{}.obs;

  final TextEditingController medicalHistoryController1 =
      TextEditingController();
  final TextEditingController medicalHistoryController2 =
      TextEditingController();
  final TextEditingController surgicalHistoryController1 =
      TextEditingController();
  final TextEditingController surgicalHistoryController2 =
      TextEditingController();

  Future<void> uploadProfileImageAndSaveData(
    String userID,
    Map<String, dynamic> userProfileData,
    String role,
    String? familyUserID,
    Function createUserProfile,
    Function createFamilyProfile,
  ) async {
    try {
      isLoading.value = true;

      // Check if profile image exists in userProfileData
      if (userProfileData['profileImage'] != null &&
          userProfileData['profileImage'].isNotEmpty &&
          userProfileData['profileImage'] is String) {
        // Convert base64 string to Uint8List (only for web-compatible input)
        Uint8List fileBytes = base64Decode(userProfileData['profileImage']);
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        // Upload the file to Firebase Storage using putData (Firebase Web API)
        UploadTask uploadTask = FirebaseStorage.instance
            .ref('profileImages/$fileName')
            .putData(fileBytes);

        // Get the download URL after upload
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Update the userProfileData with the download URL
        userProfileData['profileImage'] = downloadUrl;
      } else {
        userProfileData['profileImage'] = '';
      }

      // Collect data into maps
      medicalHistoryData['history1'] = medicalHistoryController1.text;
      medicalHistoryData['history2'] = medicalHistoryController2.text;
      medicalHistoryData['userId'] = userID;
      surgicalHistoryData['surgery1'] = surgicalHistoryController1.text;
      surgicalHistoryData['surgery2'] = surgicalHistoryController2.text;
      surgicalHistoryData['userID'] = userID;

      // Save data to Firestore
      if (role == 'register') {
        await createUserProfile();
      } else if (role == 'family') {
        await createFamilyProfile();
      }
    } catch (e) {
      print('Error uploading profile image: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createFamilyProfile(
    String userID,
    Map<String, dynamic> userProfileData,
    Map<String, dynamic> comorbiditiesData,
    Map<String, dynamic> allergicMedicationsData,
    Map<String, dynamic> currentMedicationsData,
  ) async {
    try {
      String userfamilyId =
          (Random().nextInt(900000000) + 100000000).toString();
      userProfileData['userfamilyId'] = userfamilyId;
      comorbiditiesData['userfamilyId'] = userfamilyId;
      allergicMedicationsData['userfamilyId'] = userfamilyId;
      currentMedicationsData['userfamilyId'] = userfamilyId;
      medicalHistoryData['userfamilyId'] = userfamilyId;
      surgicalHistoryData['userfamilyId'] = userfamilyId;

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(userID)
          .set({'docId': userID});

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(userID)
          .collection('userProfileData')
          .doc(userfamilyId)
          .set(userProfileData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(userID)
          .collection('comorbiditiesData')
          .doc(userfamilyId)
          .set(comorbiditiesData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(userID)
          .collection('allergicMedicationsData')
          .doc(userfamilyId)
          .set(allergicMedicationsData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(userID)
          .collection('currentMedicationsData')
          .doc(userfamilyId)
          .set(currentMedicationsData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(userID)
          .collection('medicalHistoryData')
          .doc(userfamilyId)
          .set(medicalHistoryData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(userID)
          .collection('surgicalHistoryData')
          .doc(userfamilyId)
          .set(surgicalHistoryData);
    } catch (e) {
      print('Error creating family profile: $e');
    }
  }

  Future<void> createUserProfile(
    String userID,
    Map<String, dynamic> userProfileData,
    Map<String, dynamic> comorbiditiesData,
    Map<String, dynamic> allergicMedicationsData,
    Map<String, dynamic> currentMedicationsData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('userProfileData')
          .doc(userID)
          .set(userProfileData);

      await FirebaseFirestore.instance
          .collection('comorbiditiesData')
          .doc(userID)
          .set(comorbiditiesData);

      await FirebaseFirestore.instance
          .collection('allergicMedicationsData')
          .doc(userID)
          .set(allergicMedicationsData);

      await FirebaseFirestore.instance
          .collection('currentMedicationsData')
          .doc(userID)
          .set(currentMedicationsData);

      await FirebaseFirestore.instance
          .collection('medicalHistoryData')
          .doc(userID)
          .set(medicalHistoryData);

      await FirebaseFirestore.instance
          .collection('surgicalHistoryData')
          .doc(userID)
          .set(surgicalHistoryData);
    } catch (e) {
      print('Error creating user profile: $e');
    }
  }
}
