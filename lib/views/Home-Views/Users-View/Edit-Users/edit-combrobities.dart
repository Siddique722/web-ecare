// import 'package:demo_app/views/Home-Views/Users-View/Edit-Users/edit-alergicmedications.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:demo_app/widgets/blue-button.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:demo_app/widgets/the-drop-down.dart';
// import 'package:demo_app/views/Create-Profile-Views/alergic-medication.dart';

// class EditComorbitiesView extends StatefulWidget {
//   final String role;
//   final String userID;
//   String? familyId;
//   final Map<String, dynamic> userProfileData;
//   final Map<String, dynamic> allergicMedicationsData;
//   final Map<String, dynamic> comorbiditiesData;
//   final Map<String, dynamic> currentMedicationsData;
//   final Map<String, dynamic> medicalHistoryData;
//   final Map<String, dynamic> surgicalHistoryData;

//   EditComorbitiesView({
//     this.familyId,
//     required this.userProfileData,
//     required this.userID,
//     required this.role,
//     required this.allergicMedicationsData,
//     required this.comorbiditiesData,
//     required this.currentMedicationsData,
//     required this.medicalHistoryData,
//     required this.surgicalHistoryData,
//   });

//   @override
//   State<EditComorbitiesView> createState() => _EditComorbitiesViewState();
// }

// // class _EditComorbitiesViewState extends State<EditComorbitiesView> {
// //   String? selectedComorbidity1;
// //   String? selectedComorbidity2;
// //   String? selectedComorbidity3;
// //   String? selectedComorbidity4;
// //   String? selectedComorbidity5;
// //   String? selectedComorbidity6;
// //   final List<String> comorbidityOptions = [
// //     'History of stroke/hemorrhage',
// //     'Thyroid disease',
// //     'Liver disease',
// //     'Cancer',
// //     'Hypertension',
// //     'Pancreatic disease',
// //     'Kidney disease',
// //     'Cardiac disease',
// //     'Diabetes',
// //     'Dyslipidemia (cholesterol)',
// //   ];
// //   Map<String, dynamic> comorbiditiesMap = {};
// //   @override
// //   void initState() {
// //     super.initState();
// //     selectedComorbidity1 = widget.comorbiditiesData['selectedComorbidity1'];
// //     selectedComorbidity2 = widget.comorbiditiesData['selectedComorbidity2'];
// //     selectedComorbidity3 = widget.comorbiditiesData['selectedComorbidity3'];
// //     selectedComorbidity4 = widget.comorbiditiesData['selectedComorbidity4'];
// //     selectedComorbidity5 = widget.comorbiditiesData['selectedComorbidity5'];
// //     selectedComorbidity6 = widget.comorbiditiesData['selectedComorbidity6'];
// //     // Ensure initial values match one of the dropdown options or are null
// //     _validateSelectedComorbidities();
// //   }
// //   void _validateSelectedComorbidities() {
// //     // If the selected value is not in the list, set it to null
// //     selectedComorbidity1 = _validateDropdownValue(selectedComorbidity1);
// //     selectedComorbidity2 = _validateDropdownValue(selectedComorbidity2);
// //     selectedComorbidity3 = _validateDropdownValue(selectedComorbidity3);
// //     selectedComorbidity4 = _validateDropdownValue(selectedComorbidity4);
// //     selectedComorbidity5 = _validateDropdownValue(selectedComorbidity5);
// //     selectedComorbidity6 = _validateDropdownValue(selectedComorbidity6);
// //   }
// //   String? _validateDropdownValue(String? value) {
// //     if (value == null || comorbidityOptions.contains(value)) {
// //       return value;
// //     } else {
// //       // Log or handle the mismatch
// //       print("Invalid value detected: $value. Resetting to null.");
// //       return null;
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         title: BoldTextWidgetTheme(text: 'Edit Comorbidities'),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               _storeUserData();
// //             },
// //             child: Text(
// //               'Save',
// //               style: TextStyle(color: Colors.blueAccent.shade700),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text('Comorbidities'),
// //               ...List.generate(6, (index) {
// //                 final comorbidityNumber = index + 1;
// //                 return LighDarkDropDown(
// //                   hint: 'Comorbidity $comorbidityNumber',
// //                   items: comorbidityOptions,
// //                   value: _getSelectedComorbidity(comorbidityNumber),
// //                   onChanged: (value) {
// //                     setState(() {
// //                       _setSelectedComorbidity(comorbidityNumber, value);
// //                     });
// //                   },
// //                 );
// //               }),
// //               InkWell(
// //                   onTap: () {
// //                     _storeUserData();
// //                     print(comorbiditiesMap);
// //                     Navigator.push(
// //                         context,
// //                         CupertinoPageRoute(
// //                             builder: (context) => EditAlergicMedications(
// //                                 familyId: widget.familyId,
// //                                 userProfileData: widget.userProfileData,
// //                                 userID: widget.userID,
// //                                 role: widget.role,
// //                                 allergicMedicationsData:
// //                                     widget.allergicMedicationsData,
// //                                 comorbiditiesData: comorbiditiesMap,
// //                                 currentMedicationsData:
// //                                     widget.currentMedicationsData,
// //                                 medicalHistoryData: widget.medicalHistoryData,
// //                                 surgicalHistoryData:
// //                                     widget.surgicalHistoryData)));
// //                   },
// //                   child: BlueButton(text: 'Next')),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //   String? _getSelectedComorbidity(int number) {
// //     switch (number) {
// //       case 1:
// //         return selectedComorbidity1;
// //       case 2:
// //         return selectedComorbidity2;
// //       case 3:
// //         return selectedComorbidity3;
// //       case 4:
// //         return selectedComorbidity4;
// //       case 5:
// //         return selectedComorbidity5;
// //       case 6:
// //         return selectedComorbidity6;
// //       default:
// //         return null;
// //     }
// //   }
// //   void _setSelectedComorbidity(int number, String? value) {
// //     switch (number) {
// //       case 1:
// //         selectedComorbidity1 = value;
// //         break;
// //       case 2:
// //         selectedComorbidity2 = value;
// //         break;
// //       case 3:
// //         selectedComorbidity3 = value;
// //         break;
// //       case 4:
// //         selectedComorbidity4 = value;
// //         break;
// //       case 5:
// //         selectedComorbidity5 = value;
// //         break;
// //       case 6:
// //         selectedComorbidity6 = value;
// //         break;
// //     }
// //   }
// //   void _storeUserData() {
// //     comorbiditiesMap['selectedComorbidity1'] = selectedComorbidity1 ?? '';
// //     comorbiditiesMap['selectedComorbidity2'] = selectedComorbidity2 ?? '';
// //     comorbiditiesMap['selectedComorbidity3'] = selectedComorbidity3 ?? '';
// //     comorbiditiesMap['selectedComorbidity4'] = selectedComorbidity4 ?? '';
// //     comorbiditiesMap['selectedComorbidity5'] = selectedComorbidity5 ?? '';
// //     comorbiditiesMap['selectedComorbidity6'] = selectedComorbidity6 ?? '';
// //     comorbiditiesMap['userId'] = widget.userID;
// //     final combinedData = {
// //       'userProfileData': widget.userProfileData,
// //       'allergicMedicationsData': widget.allergicMedicationsData,
// //       'comorbiditiesData': comorbiditiesMap,
// //       'currentMedicationsData': widget.currentMedicationsData,
// //       'medicalHistoryData': widget.medicalHistoryData,
// //       'surgicalHistoryData': widget.surgicalHistoryData,
// //     };
// //     // Do something with combinedData
// //   }
// // }

// ///---------------------------
// ///
// ///
// ///
// ///
// ///
// class _EditComorbitiesViewState extends State<EditComorbitiesView> {
//   String? selectedComorbidity1;
//   String? selectedComorbidity2;
//   String? selectedComorbidity3;
//   String? selectedComorbidity4;
//   String? selectedComorbidity5;
//   String? selectedComorbidity6;

//   final List<String> comorbidityOptions = [
//     'History of stroke/hemorrhage',
//     'Thyroid disease',
//     'Liver disease',
//     'Cancer',
//     'Hypertension',
//     'Pancreatic disease',
//     'Kidney disease',
//     'Cardiac disease',
//     'Diabetes',
//     'Dyslipidemia (cholesterol)',
//   ];

//   Map<String, dynamic> comorbiditiesMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadComorbiditiesData();
//     _validateSelectedComorbidities();
//   }

//   void _loadComorbiditiesData() {
//     // Get the comorbidities data for the current familyId
//     final currentData = widget.comorbiditiesData[widget.familyId];

//     if (currentData != null) {
//       selectedComorbidity1 = currentData['selectedComorbidity1'];
//       selectedComorbidity2 = currentData['selectedComorbidity2'];
//       selectedComorbidity3 = currentData['selectedComorbidity3'];
//       selectedComorbidity4 = currentData['selectedComorbidity4'];
//       selectedComorbidity5 = currentData['selectedComorbidity5'];
//       selectedComorbidity6 = currentData['selectedComorbidity6'];
//     }
//   }

//   void _validateSelectedComorbidities() {
//     selectedComorbidity1 = _validateDropdownValue(selectedComorbidity1);
//     selectedComorbidity2 = _validateDropdownValue(selectedComorbidity2);
//     selectedComorbidity3 = _validateDropdownValue(selectedComorbidity3);
//     selectedComorbidity4 = _validateDropdownValue(selectedComorbidity4);
//     selectedComorbidity5 = _validateDropdownValue(selectedComorbidity5);
//     selectedComorbidity6 = _validateDropdownValue(selectedComorbidity6);
//   }

//   String? _validateDropdownValue(String? value) {
//     if (value == null || comorbidityOptions.contains(value)) {
//       return value;
//     } else {
//       print("Invalid value detected: $value. Resetting to null.");
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Edit Comorbidities'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _storeUserData();
//             },
//             child: Text(
//               'Save',
//               style: TextStyle(color: Colors.blueAccent.shade700),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Comorbidities'),
//               ...List.generate(6, (index) {
//                 final comorbidityNumber = index + 1;
//                 return LighDarkDropDown(
//                   hint: 'Comorbidity $comorbidityNumber',
//                   items: comorbidityOptions,
//                   value: _getSelectedComorbidity(comorbidityNumber),
//                   onChanged: (value) {
//                     setState(() {
//                       _setSelectedComorbidity(comorbidityNumber, value);
//                     });
//                   },
//                 );
//               }),
//               InkWell(
//                 onTap: () {
//                   _storeUserData();
//                   Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                       builder: (context) => EditAlergicMedications(
//                         familyId: widget.familyId,
//                         userProfileData: widget.userProfileData,
//                         userID: widget.userID,
//                         role: widget.role,
//                         allergicMedicationsData: widget.allergicMedicationsData,
//                         comorbiditiesData: comorbiditiesMap,
//                         currentMedicationsData: widget.currentMedicationsData,
//                         medicalHistoryData: widget.medicalHistoryData,
//                         surgicalHistoryData: widget.surgicalHistoryData,
//                       ),
//                     ),
//                   );
//                 },
//                 child: BlueButton(text: 'Next'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String? _getSelectedComorbidity(int number) {
//     switch (number) {
//       case 1:
//         return selectedComorbidity1;
//       case 2:
//         return selectedComorbidity2;
//       case 3:
//         return selectedComorbidity3;
//       case 4:
//         return selectedComorbidity4;
//       case 5:
//         return selectedComorbidity5;
//       case 6:
//         return selectedComorbidity6;
//       default:
//         return null;
//     }
//   }

//   void _setSelectedComorbidity(int number, String? value) {
//     switch (number) {
//       case 1:
//         selectedComorbidity1 = value;
//         break;
//       case 2:
//         selectedComorbidity2 = value;
//         break;
//       case 3:
//         selectedComorbidity3 = value;
//         break;
//       case 4:
//         selectedComorbidity4 = value;
//         break;
//       case 5:
//         selectedComorbidity5 = value;
//         break;
//       case 6:
//         selectedComorbidity6 = value;
//         break;
//     }
//   }

//   void _storeUserData() {
//     comorbiditiesMap['selectedComorbidity1'] = selectedComorbidity1 ?? '';
//     comorbiditiesMap['selectedComorbidity2'] = selectedComorbidity2 ?? '';
//     comorbiditiesMap['selectedComorbidity3'] = selectedComorbidity3 ?? '';
//     comorbiditiesMap['selectedComorbidity4'] = selectedComorbidity4 ?? '';
//     comorbiditiesMap['selectedComorbidity5'] = selectedComorbidity5 ?? '';
//     comorbiditiesMap['selectedComorbidity6'] = selectedComorbidity6 ?? '';
//     comorbiditiesMap['userId'] = widget.userID;

//     final combinedData = {
//       'userProfileData': widget.userProfileData,
//       'allergicMedicationsData': widget.allergicMedicationsData,
//       'comorbiditiesData': comorbiditiesMap,
//       'currentMedicationsData': widget.currentMedicationsData,
//       'medicalHistoryData': widget.medicalHistoryData,
//       'surgicalHistoryData': widget.surgicalHistoryData,
//     };

//     // Do something with combinedData
//   }
// }

//------------------------------------------------------------------------------

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/Home-Views/Users-View/Edit-Users/edit-alergicmedications.dart';
import 'package:flutter/cupertino.dart';

class EditComorbiditiesView extends StatefulWidget {
  final String role;
  final String userID;
  String? familyId;
  final Map<String, dynamic> userProfileData;
  final Map<String, dynamic> allergicMedicationsData;
  final Map<String, dynamic> comorbiditiesData;
  final Map<String, dynamic> currentMedicationsData;
  final Map<String, dynamic> medicalHistoryData;
  final Map<String, dynamic> surgicalHistoryData;

  EditComorbiditiesView({
    this.familyId,
    required this.userProfileData,
    required this.userID,
    required this.role,
    required this.allergicMedicationsData,
    required this.comorbiditiesData,
    required this.currentMedicationsData,
    required this.medicalHistoryData,
    required this.surgicalHistoryData,
  });

  @override
  State<EditComorbiditiesView> createState() => _EditComorbiditiesViewState();
}

class _EditComorbiditiesViewState extends State<EditComorbiditiesView> {
  String? selectedComorbidity1;
  String? selectedComorbidity2;
  String? selectedComorbidity3;
  String? selectedComorbidity4;
  String? selectedComorbidity5;
  String? selectedComorbidity6;

  final List<String> comorbidityOptions = [
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

  Map<String, dynamic> comorbiditiesMap = {};

  @override
  void initState() {
    super.initState();
    if (widget.role == 'family') {
      _loadComorbiditiesData();
    } else {
      _loadDirectComorbiditiesData();
    }
    _validateSelectedComorbidities();
  }

  void _loadComorbiditiesData() {
    final currentData = widget.comorbiditiesData[widget.familyId];

    if (currentData != null) {
      selectedComorbidity1 = currentData['selectedComorbidity1'];
      selectedComorbidity2 = currentData['selectedComorbidity2'];
      selectedComorbidity3 = currentData['selectedComorbidity3'];
      selectedComorbidity4 = currentData['selectedComorbidity4'];
      selectedComorbidity5 = currentData['selectedComorbidity5'];
      selectedComorbidity6 = currentData['selectedComorbidity6'];
    }
  }

  void _loadDirectComorbiditiesData() {
    selectedComorbidity1 = widget.comorbiditiesData['selectedComorbidity1'];
    selectedComorbidity2 = widget.comorbiditiesData['selectedComorbidity2'];
    selectedComorbidity3 = widget.comorbiditiesData['selectedComorbidity3'];
    selectedComorbidity4 = widget.comorbiditiesData['selectedComorbidity4'];
    selectedComorbidity5 = widget.comorbiditiesData['selectedComorbidity5'];
    selectedComorbidity6 = widget.comorbiditiesData['selectedComorbidity6'];
  }

  void _validateSelectedComorbidities() {
    selectedComorbidity1 = _validateDropdownValue(selectedComorbidity1);
    selectedComorbidity2 = _validateDropdownValue(selectedComorbidity2);
    selectedComorbidity3 = _validateDropdownValue(selectedComorbidity3);
    selectedComorbidity4 = _validateDropdownValue(selectedComorbidity4);
    selectedComorbidity5 = _validateDropdownValue(selectedComorbidity5);
    selectedComorbidity6 = _validateDropdownValue(selectedComorbidity6);
  }

  String? _validateDropdownValue(String? value) {
    if (value == null || comorbidityOptions.contains(value)) {
      return value;
    } else {
      print("Invalid value detected: $value. Resetting to null.");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BoldTextWidgetTheme(text: 'Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              _storeUserData();
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.blueAccent.shade700),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comorbidities'),
              ...List.generate(6, (index) {
                final comorbidityNumber = index + 1;
                return LighDarkDropDown(
                  hint: 'Comorbidity $comorbidityNumber',
                  items: comorbidityOptions,
                  value: _getSelectedComorbidity(comorbidityNumber),
                  onChanged: (value) {
                    setState(() {
                      _setSelectedComorbidity(comorbidityNumber, value);
                    });
                  },
                );
              }),
              InkWell(
                onTap: () {
                  _storeUserData();
                  print(
                      '85858855685786798743698476979875768576857698457677459876');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EditAlergicMedications(
                        familyId: widget.familyId,
                        userProfileData: widget.userProfileData,
                        userID: widget.userID,
                        role: widget.role,
                        allergicMedicationsData: widget.allergicMedicationsData,
                        comorbiditiesData: comorbiditiesMap,
                        currentMedicationsData: widget.currentMedicationsData,
                        medicalHistoryData: widget.medicalHistoryData,
                        surgicalHistoryData: widget.surgicalHistoryData,
                      ),
                    ),
                  );
                },
                child: BlueButton(text: 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _getSelectedComorbidity(int number) {
    switch (number) {
      case 1:
        return selectedComorbidity1;
      case 2:
        return selectedComorbidity2;
      case 3:
        return selectedComorbidity3;
      case 4:
        return selectedComorbidity4;
      case 5:
        return selectedComorbidity5;
      case 6:
        return selectedComorbidity6;
      default:
        return null;
    }
  }

  void _setSelectedComorbidity(int number, String? value) {
    if (value == 'Unselect') {
      value = null;
    }

    setState(() {
      switch (number) {
        case 1:
          selectedComorbidity1 = value;
          break;
        case 2:
          selectedComorbidity2 = value;
          break;
        case 3:
          selectedComorbidity3 = value;
          break;
        case 4:
          selectedComorbidity4 = value;
          break;
        case 5:
          selectedComorbidity5 = value;
          break;
        case 6:
          selectedComorbidity6 = value;
          break;
      }
    });
  }

  // void _setSelectedComorbidity(int number, String? value) {
  //   switch (number) {
  //     case 1:
  //       selectedComorbidity1 = value;
  //       break;
  //     case 2:
  //       selectedComorbidity2 = value;
  //       break;
  //     case 3:
  //       selectedComorbidity3 = value;
  //       break;
  //     case 4:
  //       selectedComorbidity4 = value;
  //       break;
  //     case 5:
  //       selectedComorbidity5 = value;
  //       break;
  //     case 6:
  //       selectedComorbidity6 = value;
  //       break;
  //   }
  // }

  void _storeUserData() {
    comorbiditiesMap['selectedComorbidity1'] = selectedComorbidity1 ?? '';
    comorbiditiesMap['selectedComorbidity2'] = selectedComorbidity2 ?? '';
    comorbiditiesMap['selectedComorbidity3'] = selectedComorbidity3 ?? '';
    comorbiditiesMap['selectedComorbidity4'] = selectedComorbidity4 ?? '';
    comorbiditiesMap['selectedComorbidity5'] = selectedComorbidity5 ?? '';
    comorbiditiesMap['selectedComorbidity6'] = selectedComorbidity6 ?? '';
    comorbiditiesMap['userId'] = widget.userID;

    final combinedData = {
      'userProfileData': widget.userProfileData,
      'allergicMedicationsData': widget.allergicMedicationsData,
      'comorbiditiesData': comorbiditiesMap,
      'currentMedicationsData': widget.currentMedicationsData,
      'medicalHistoryData': widget.medicalHistoryData,
      'surgicalHistoryData': widget.surgicalHistoryData,
    };

    // Handle combinedData as needed
  }
}
