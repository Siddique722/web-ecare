import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AllergicMedicationsController extends GetxController {
  // Text controllers
  final medicineController1 = TextEditingController();
  final medicineController2 = TextEditingController();
  final medicineController3 = TextEditingController();
  final medicineController4 = TextEditingController();
  final medicineController5 = TextEditingController();

  // Allergic medications data
  final RxMap<String, dynamic> allergicMedicationsData =
      <String, dynamic>{}.obs;

  void storeUserData(String? userId) {
    allergicMedicationsData['medicineController1'] = medicineController1.text;
    allergicMedicationsData['medicineController2'] = medicineController2.text;
    allergicMedicationsData['medicineController3'] = medicineController3.text;
    allergicMedicationsData['medicineController4'] = medicineController4.text;
    allergicMedicationsData['medicineController5'] = medicineController5.text;
    allergicMedicationsData['userId'] = userId;
  }

  @override
  void onClose() {
    // Dispose controllers
    medicineController1.dispose();
    medicineController2.dispose();
    medicineController3.dispose();
    medicineController4.dispose();
    medicineController5.dispose();
    super.onClose();
  }
}
