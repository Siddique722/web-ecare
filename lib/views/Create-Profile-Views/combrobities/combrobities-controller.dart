// ComorbiditiesController.dart
import 'package:ecare/constants/linker.dart';
import 'package:get/get.dart';

class ComorbiditiesController extends GetxController {
  // Input data
  final String? role;
  final String? userID;
  final Map<String, dynamic>? userProfileData;

  ComorbiditiesController({this.role, this.userID, this.userProfileData});

  // State variables
  var selectedComorbidity1 = RxnString();
  var selectedComorbidity2 = RxnString();
  var selectedComorbidity3 = RxnString();
  var selectedComorbidity4 = RxnString();
  var selectedComorbidity5 = RxnString();
  var selectedComorbidity6 = RxnString();

  final List<String> allComorbidities = [
    'History of stroke/hemorrhage',
    'Thyroid disease',
    'Liver disease',
    'Cancer',
    'Hypertension',
    'Pancreatic disease',
    'Kidney disease',
    'Cardiac disease',
    'Diabetes',
    'Dyslipidemia (cholesterol)',
    'Unselect'
  ];

  // Observable lists for dropdown options
  var availableComorbidities1 = <String>[].obs;
  var availableComorbidities2 = <String>[].obs;
  var availableComorbidities3 = <String>[].obs;
  var availableComorbidities4 = <String>[].obs;
  var availableComorbidities5 = <String>[].obs;
  var availableComorbidities6 = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateAvailableComorbidities();
  }

  void updateAvailableComorbidities() {
    final selectedComorbidities = [
      selectedComorbidity1.value,
      selectedComorbidity2.value,
      selectedComorbidity3.value,
      selectedComorbidity4.value,
      selectedComorbidity5.value,
      selectedComorbidity6.value,
    ];

    availableComorbidities1.value = allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity1.value)
        .toList();
    availableComorbidities2.value = allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity2.value)
        .toList();
    availableComorbidities3.value = allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity3.value)
        .toList();
    availableComorbidities4.value = allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity4.value)
        .toList();
    availableComorbidities5.value = allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity5.value)
        .toList();
    availableComorbidities6.value = allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity6.value)
        .toList();
  }

  void storeUserData() {
    final comorbiditiesMap = {
      'selectedComorbidity1': selectedComorbidity1.value ?? '',
      'selectedComorbidity2': selectedComorbidity2.value ?? '',
      'selectedComorbidity3': selectedComorbidity3.value ?? '',
      'selectedComorbidity4': selectedComorbidity4.value ?? '',
      'selectedComorbidity5': selectedComorbidity5.value ?? '',
      'selectedComorbidity6': selectedComorbidity6.value ?? '',
      'userId': userID,
    };
    print('_storeUserData=$comorbiditiesMap');

    Get.to(() => AlergicMedications(
          role: role,
          userId: userID,
          userProfileData: userProfileData,
          comorbiditiesData: comorbiditiesMap,
        ));
  }
}

// ComorbiditiesView.dart
