// import 'package:demo_app/views/Create-Profile-Views/ongoing-medication.dart';
// import 'package:demo_app/views/Home-Views/Nav-Bar/nav-bar-.dart';
// import 'package:demo_app/views/Home-Views/Users-View/Edit-Users/editcurrent-ongoing.dart';
// import 'package:demo_app/widgets/blue-button.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:demo_app/widgets/theme-text-field.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class EditAlergicMedications extends StatefulWidget {
//   final String role;
//   final String userID;
//   final Map<String, dynamic> userProfileData;
//   final Map<String, dynamic> allergicMedicationsData;
//   final Map<String, dynamic> comorbiditiesData;
//   final Map<String, dynamic> currentMedicationsData;
//   final Map<String, dynamic> medicalHistoryData;
//   final Map<String, dynamic> surgicalHistoryData;
//   String? familyId;

//   EditAlergicMedications({
//     required this.userProfileData,
//     this.familyId,
//     required this.userID,
//     required this.role,
//     required this.allergicMedicationsData,
//     required this.comorbiditiesData,
//     required this.currentMedicationsData,
//     required this.medicalHistoryData,
//     required this.surgicalHistoryData,
//   });

//   @override
//   State<EditAlergicMedications> createState() => _EditAlergicMedicationsState();
// }

// class _EditAlergicMedicationsState extends State<EditAlergicMedications> {
//   Map<String, dynamic> allergicMedicationsData = {};
//   final TextEditingController medicineController1 = TextEditingController();
//   final TextEditingController medicineController2 = TextEditingController();
//   final TextEditingController medicineController3 = TextEditingController();
//   final TextEditingController medicineController4 = TextEditingController();
//   final TextEditingController medicineController5 = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     // Identify the correct data entry based on userID or familyId
//     final dataKey = widget.familyId ?? widget.userID;

//     if (widget.allergicMedicationsData.containsKey(dataKey)) {
//       final userMedicationsData = widget.allergicMedicationsData[dataKey];

//       // Initialize text controllers with data
//       medicineController1.text =
//           userMedicationsData['medicineController1'] ?? '';
//       medicineController2.text =
//           userMedicationsData['medicineController2'] ?? '';
//       medicineController3.text =
//           userMedicationsData['medicineController3'] ?? '';
//       medicineController4.text =
//           userMedicationsData['medicineController4'] ?? '';
//       medicineController5.text =
//           userMedicationsData['medicineController5'] ?? '';
//     } else {
//       print("No data found for the provided ID.");
//     }
//   }

//   void _storeUserData() {
//     final dataKey = widget.familyId ?? widget.userID;
//     allergicMedicationsData[dataKey] = {
//       'medicineController1': medicineController1.text,
//       'medicineController2': medicineController2.text,
//       'medicineController3': medicineController3.text,
//       'medicineController4': medicineController4.text,
//       'medicineController5': medicineController5.text,
//       'userId': widget.userID,
//     };
//   }

//   @override
//   void dispose() {
//     medicineController1.dispose();
//     medicineController2.dispose();
//     medicineController3.dispose();
//     medicineController4.dispose();
//     medicineController5.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Create Profile'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _storeUserData();
//               Navigator.push(
//                 context,
//                 CupertinoPageRoute(
//                   builder: (context) => CurrentOngoingMedications(
//                     role: widget.role,
//                     userID: widget.userID,
//                     userProfileData: widget.userProfileData,
//                     comorbiditiesData: widget.comorbiditiesData,
//                     allergicMedicationsData: allergicMedicationsData,
//                   ),
//                 ),
//               );
//             },
//             child: Text(
//               'Skip',
//               style: TextStyle(color: Colors.blueAccent.shade700),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
//           child: Column(
//             children: [
//               BoldTextWidgetTheme(text: 'Allergic Medications'),
//               LightDarktextField(
//                 controller: medicineController1,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController2,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController3,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController4,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController5,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               InkWell(
//                 onTap: () {
//                   _storeUserData();
//                   Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                       builder: (context) => EditCurrentOngoingMedications(
//                         role: widget.role,
//                         familyId: widget.familyId,
//                         userID: widget.userID,
//                         userProfileData: widget.userProfileData,
//                         comorbiditiesData: widget.comorbiditiesData,
//                         allergicMedicationsData: allergicMedicationsData,
//                         currentMedicationsData: widget.currentMedicationsData,
//                         medicalHistoryData: widget.medicalHistoryData,
//                         surgicalHistoryData: widget.surgicalHistoryData,
//                       ),
//                     ),
//                   );
//                 },
//                 child: BlueButton(
//                   text: 'Next',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class _EditAlergicMedicationsState extends State<EditAlergicMedications> {
// //   Map<String, dynamic> allergicMedicationsData = {};

// //   final TextEditingController medicineController1 = TextEditingController();
// //   final TextEditingController medicineController2 = TextEditingController();
// //   final TextEditingController medicineController3 = TextEditingController();
// //   final TextEditingController medicineController4 = TextEditingController();
// //   final TextEditingController medicineController5 = TextEditingController();
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     print('allergicMedicationsData:${widget.allergicMedicationsData}');
// //     medicineController1.text =
// //         widget.allergicMedicationsData['medicineController1'] ?? '';
// //     medicineController2.text =
// //         widget.allergicMedicationsData['medicineController2'] ?? '';
// //     medicineController3.text =
// //         widget.allergicMedicationsData['medicineController3'] ?? '';
// //     medicineController4.text =
// //         widget.allergicMedicationsData['medicineController4'] ?? '';
// //     medicineController5.text =
// //         widget.allergicMedicationsData['medicineController5'] ?? '';
// //   }

// //   void _storeUserData() {
// //     allergicMedicationsData['medicineController1'] =
// //         medicineController1.text ?? '';
// //     allergicMedicationsData['medicineController2'] =
// //         medicineController2.text ?? '';
// //     allergicMedicationsData['medicineController3'] =
// //         medicineController3.text ?? '';
// //     allergicMedicationsData['medicineController4'] =
// //         medicineController4.text ?? '';
// //     allergicMedicationsData['medicineController5'] =
// //         medicineController5.text ?? '';
// //     allergicMedicationsData['userId'] = widget.userID;
// //   }

// //   @override
// //   void dispose() {
// //     medicineController1.dispose();
// //     medicineController2.dispose();
// //     medicineController3.dispose();
// //     medicineController4.dispose();
// //     medicineController5.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         title: BoldTextWidgetTheme(text: 'Create Profile'),
// //         actions: [
// //           //widget.role=='register'?
// //           TextButton(
// //             onPressed: () {
// //               _storeUserData();
// //               print('object=$allergicMedicationsData');
// //               Navigator.push(
// //                 context,
// //                 CupertinoPageRoute(
// //                   builder: (context) => CurrentOngoingMedications(
// //                     role: widget.role,
// //                     userID: widget.userID,
// //                     userProfileData: widget.userProfileData,
// //                     comorbiditiesData: widget.comorbiditiesData,
// //                     allergicMedicationsData: allergicMedicationsData,
// //                   ),
// //                 ),
// //               );
// //             },
// //             child: Text(
// //               'Skip',
// //               style: TextStyle(color: Colors.blueAccent.shade700),
// //             ),
// //           )
// //           //  :SizedBox()
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
// //           child: Column(
// //             children: [
// //               BoldTextWidgetTheme(text: 'Allergic Medications'),
// //               LightDarktextField(
// //                 controller: medicineController1,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController2,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController3,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController4,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController5,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               InkWell(
// //                 onTap: () {
// //                   // allergicMedicationsData['medicine1'] =
// //                   //     medicineController1.text;
// //                   // allergicMedicationsData['medicine2'] =
// //                   //     medicineController2.text;
// //                   // allergicMedicationsData['medicine3'] =
// //                   //     medicineController3.text;
// //                   // allergicMedicationsData['medicine4'] =
// //                   //     medicineController4.text;
// //                   // allergicMedicationsData['medicine5'] =
// //                   //     medicineController5.text;
// //                   _storeUserData();
// //                   print('object=$allergicMedicationsData');
// //                   Navigator.push(
// //                     context,
// //                     CupertinoPageRoute(
// //                       builder: (context) => EditCurrentOngoingMedications(
// //                         role: widget.role,
// //                         familyId: widget.familyId,
// //                         userID: widget.userID,
// //                         userProfileData: widget.userProfileData,
// //                         comorbiditiesData: widget.comorbiditiesData,
// //                         allergicMedicationsData: allergicMedicationsData,
// //                         currentMedicationsData: widget.currentMedicationsData,
// //                         medicalHistoryData: widget.medicalHistoryData,
// //                         surgicalHistoryData: widget.surgicalHistoryData,
// //                       ),
// //                     ),
// //                   );
// //                 },
// //                 child: BlueButton(
// //                   text: 'Next',
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/Home-Views/Users-View/Edit-Users/editcurrent-ongoing.dart';
import 'package:flutter/cupertino.dart';

///------------------------
///
class EditAlergicMedications extends StatefulWidget {
  final String role;
  final String userID;
  final Map<String, dynamic> userProfileData;
  final Map<String, dynamic> allergicMedicationsData;
  final Map<String, dynamic> comorbiditiesData;
  final Map<String, dynamic> currentMedicationsData;
  final Map<String, dynamic> medicalHistoryData;
  final Map<String, dynamic> surgicalHistoryData;
  String? familyId;

  EditAlergicMedications({
    required this.userProfileData,
    this.familyId,
    required this.userID,
    required this.role,
    required this.allergicMedicationsData,
    required this.comorbiditiesData,
    required this.currentMedicationsData,
    required this.medicalHistoryData,
    required this.surgicalHistoryData,
  });

  @override
  State<EditAlergicMedications> createState() => _EditAlergicMedicationsState();
}

class _EditAlergicMedicationsState extends State<EditAlergicMedications> {
  Map<String, dynamic> allergicMedicationsData = {};

  final TextEditingController medicineController1 = TextEditingController();
  final TextEditingController medicineController2 = TextEditingController();
  final TextEditingController medicineController3 = TextEditingController();
  final TextEditingController medicineController4 = TextEditingController();
  final TextEditingController medicineController5 = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Role-based initialization
    if (widget.role == 'family') {
      _initializeForFamily();
    } else if (widget.role == 'admin') {
      _initializeForAdmin();
    }
  }

  void _initializeForFamily() {
    final dataKey = widget.familyId ?? widget.userID;

    if (widget.allergicMedicationsData.containsKey(dataKey)) {
      final userMedicationsData = widget.allergicMedicationsData[dataKey];

      medicineController1.text =
          userMedicationsData['medicineController1'] ?? '';
      medicineController2.text =
          userMedicationsData['medicineController2'] ?? '';
      medicineController3.text =
          userMedicationsData['medicineController3'] ?? '';
      medicineController4.text =
          userMedicationsData['medicineController4'] ?? '';
      medicineController5.text =
          userMedicationsData['medicineController5'] ?? '';
    } else {
      print("No data found for the provided ID.");
    }
  }

  void _initializeForAdmin() {
    medicineController1.text =
        widget.allergicMedicationsData['medicineController1'] ?? '';
    medicineController2.text =
        widget.allergicMedicationsData['medicineController2'] ?? '';
    medicineController3.text =
        widget.allergicMedicationsData['medicineController3'] ?? '';
    medicineController4.text =
        widget.allergicMedicationsData['medicineController4'] ?? '';
    medicineController5.text =
        widget.allergicMedicationsData['medicineController5'] ?? '';
  }

  void _storeUserData() {
    if (widget.role == 'family') {
      final dataKey = widget.familyId ?? widget.userID;
      allergicMedicationsData['medicineController1'] = medicineController1.text;
      allergicMedicationsData['medicineController2'] = medicineController2.text;
      allergicMedicationsData['medicineController3'] = medicineController3.text;
      allergicMedicationsData['medicineController4'] = medicineController4.text;
      allergicMedicationsData['medicineController5'] = medicineController5.text;
      allergicMedicationsData['userId'] = widget.userID;
      // allergicMedicationsData[dataKey] = {
      //   'medicineController1': medicineController1.text,
      //   'medicineController2': medicineController2.text,
      //   'medicineController3': medicineController3.text,
      //   'medicineController4': medicineController4.text,
      //   'medicineController5': medicineController5.text,
      //   'userId': widget.userID,
      // };
    } else if (widget.role == 'admin') {
      allergicMedicationsData['medicineController1'] = medicineController1.text;
      allergicMedicationsData['medicineController2'] = medicineController2.text;
      allergicMedicationsData['medicineController3'] = medicineController3.text;
      allergicMedicationsData['medicineController4'] = medicineController4.text;
      allergicMedicationsData['medicineController5'] = medicineController5.text;
      allergicMedicationsData['userId'] = widget.userID;
    }
  }

  @override
  void dispose() {
    medicineController1.dispose();
    medicineController2.dispose();
    medicineController3.dispose();
    medicineController4.dispose();
    medicineController5.dispose();
    super.dispose();
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
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CurrentOngoingMedications(
                    role: widget.role,
                    userID: widget.userID,
                    userProfileData: widget.userProfileData,
                    comorbiditiesData: widget.comorbiditiesData,
                    allergicMedicationsData: allergicMedicationsData,
                  ),
                ),
              );
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.blueAccent.shade700),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              BoldTextWidgetTheme(text: 'Allergic Medications'),
              LightDarktextField(
                controller: medicineController1,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController2,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController3,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController4,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController5,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              InkWell(
                onTap: () {
                  _storeUserData();
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EditCurrentOngoingMedications(
                        role: widget.role,
                        familyId: widget.familyId,
                        userID: widget.userID,
                        userProfileData: widget.userProfileData,
                        comorbiditiesData: widget.comorbiditiesData,
                        allergicMedicationsData: allergicMedicationsData,
                        currentMedicationsData: widget.currentMedicationsData,
                        medicalHistoryData: widget.medicalHistoryData,
                        surgicalHistoryData: widget.surgicalHistoryData,
                      ),
                    ),
                  );
                },
                child: BlueButton(
                  text: 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
