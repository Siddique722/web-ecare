import 'package:ecare/constants/linker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CurrentMedicationsController extends GetxController {
  // Reactive variables to store the medications
  var medicineControllers = List<TextEditingController>.generate(
      10, (index) => TextEditingController()).obs;

  // Map to store current medications data
  var currentMedicationsData = <String, dynamic>{}.obs;

  // Method to check and navigate
  void checkAndNavigate(
      String? role,
      String? userID,
      Map<String, dynamic>? userProfileData,
      Map<String, dynamic>? comorbiditiesData,
      Map<String, dynamic>? allergicMedicationsData,
      BuildContext context) {
    // Collecting all entered medication names
    List<String> medications = medicineControllers
        .map((controller) => controller.text.trim())
        .toList();

    // Removing empty entries
    medications.removeWhere((med) => med.isEmpty);

    // Checking for duplicates
    Set<String> uniqueMedications = Set<String>();
    for (String med in medications) {
      if (uniqueMedications.contains(med)) {
        Fluttertoast.showToast(
          msg: "No repeated medications",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return; // Exit the function if duplicates are found
      }
      uniqueMedications.add(med);
    }

    // Populate currentMedicationsData
    for (int i = 0; i < medications.length; i++) {
      currentMedicationsData['medicine${i + 1}'] = medications[i];
    }

    // Navigate to the next screen
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MedicalHistory(
          role: role!,
          userID: userID!,
          userProfileData: userProfileData!,
          comorbiditiesData: comorbiditiesData!,
          allergicMedicationsData: allergicMedicationsData!,
          currentMedicationsData: currentMedicationsData,
        ),
      ),
    );
  }
}
