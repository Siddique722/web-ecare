//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';

import 'package:ecare/constants/linker.dart';
import 'package:flutter/cupertino.dart';

// class CurrentOngoingMedications extends StatefulWidget {
//   final String? userID;
//   final String? role;
//   final Map<String, dynamic>? userProfileData;
//   final Map<String, dynamic>? comorbiditiesData;
//   final Map<String, dynamic>? allergicMedicationsData;
//
//   CurrentOngoingMedications({
//     this.role,
//     this.userProfileData,
//     this.comorbiditiesData,
//     this.allergicMedicationsData,
//     this.userID,
//   });
//
//   @override
//   State<CurrentOngoingMedications> createState() =>
//       _CurrentOngoingMedicationsState();
// }

// class _CurrentOngoingMedicationsState extends State<CurrentOngoingMedications> {
//   Map<String, dynamic>? currentMedicationsData = {};
//
//   final TextEditingController medicineController1 = TextEditingController();
//   final TextEditingController medicineController2 = TextEditingController();
//   final TextEditingController medicineController3 = TextEditingController();
//   final TextEditingController medicineController4 = TextEditingController();
//   final TextEditingController medicineController5 = TextEditingController();
//   final TextEditingController medicineController6 = TextEditingController();
//   final TextEditingController medicineController7 = TextEditingController();
//   final TextEditingController medicineController8 = TextEditingController();
//   final TextEditingController medicineController9 = TextEditingController();
//   final TextEditingController medicineController10 = TextEditingController();
//
//   @override
//   void dispose() {
//     medicineController1.dispose();
//     medicineController2.dispose();
//     medicineController3.dispose();
//     medicineController4.dispose();
//     medicineController5.dispose();
//     medicineController6.dispose();
//     medicineController7.dispose();
//     medicineController8.dispose();
//     medicineController9.dispose();
//     medicineController10.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Create Profile'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _storeCurrentMedicationsData();
//               if (_isValidData()) {
//                 Navigator.push(
//                   context,
//                   CupertinoPageRoute(
//                     builder: (context) => MedicalHistory(
//                       role: widget.role!,
//                       userID: widget.userID!,
//                       userProfileData: widget.userProfileData!,
//                       comorbiditiesData: widget.comorbiditiesData!,
//                       allergicMedicationsData: widget.allergicMedicationsData!,
//                       currentMedicationsData: currentMedicationsData!,
//                     ),
//                   ),
//                 );
//               } else {
//                 _showErrorDialog();
//               }
//             },
//             child: Text(
//               'Skip',
//               style: TextStyle(color: Colors.blueAccent.shade700),
//             ),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Adjust padding based on screen width for responsiveness
//           double padding = constraints.maxWidth > 600 ? 40.0 : 20.0;
//
//           return SingleChildScrollView(
//             child: Padding(
//               padding:
//                   EdgeInsets.symmetric(horizontal: padding, vertical: 16.0),
//               child: Column(
//                 children: [
//                   BoldTextWidgetTheme(text: 'Current Ongoing Medications'),
//                   _buildTextFields(),
//                   InkWell(
//                     onTap: () {
//                       _storeCurrentMedicationsData();
//                       if (_isValidData()) {
//                         Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => MedicalHistory(
//                               role: widget.role!,
//                               userID: widget.userID!,
//                               userProfileData: widget.userProfileData!,
//                               comorbiditiesData: widget.comorbiditiesData!,
//                               allergicMedicationsData:
//                                   widget.allergicMedicationsData!,
//                               currentMedicationsData: currentMedicationsData!,
//                             ),
//                           ),
//                         );
//                       } else {
//                         _showErrorDialog();
//                       }
//                     },
//                     child: BlueButton(
//                       text: 'Next',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _storeCurrentMedicationsData() {
//     currentMedicationsData = {
//       'medicine1': medicineController1.text!,
//       'medicine2': medicineController2.text!,
//       'medicine3': medicineController3.text!,
//       'medicine4': medicineController4.text!,
//       'medicine5': medicineController5.text!,
//       'medicine6': medicineController6.text!,
//       'medicine7': medicineController7.text!,
//       'medicine8': medicineController8.text!,
//       'medicine9': medicineController9.text!,
//       'medicine10': medicineController10.text!,
//     };
//   }
//
//   bool _isValidData() {
//     return widget.role != null &&
//         widget.userID != null &&
//         widget.userProfileData != null &&
//         widget.comorbiditiesData != null &&
//         widget.allergicMedicationsData != null;
//   }
//
//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text('Please provide all necessary information.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextFields() {
//     return Column(
//       children: [
//         LightDarktextField(
//           controller: medicineController1,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController2,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController3,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController4,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController5,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController6,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController7,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController8,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController9,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//         LightDarktextField(
//           controller: medicineController10,
//           hintText: 'Name of the medicine',
//           keyboardType: TextInputType.text,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ongoing-controller.dart';

class CurrentOngoingMedications extends StatelessWidget {
  final String? userID;
  final String? role;
  final Map<String, dynamic>? userProfileData;
  final Map<String, dynamic>? comorbiditiesData;
  final Map<String, dynamic>? allergicMedicationsData;

  CurrentOngoingMedications({
    this.role,
    this.userProfileData,
    this.comorbiditiesData,
    this.allergicMedicationsData,
    this.userID,
  });

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final controller = Get.put(CurrentMedicationsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BoldTextWidgetTheme(text: 'Create Profile'),
        actions: [
          TextButton(
            onPressed: () => controller.checkAndNavigate(
              role,
              userID,
              userProfileData,
              comorbiditiesData,
              allergicMedicationsData,
              context,
            ),
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
              BoldTextWidgetTheme(text: 'Current Ongoing Medications'),
              // Use Obx to listen for changes to the controller
              ...List.generate(
                10,
                (index) => LightDarktextField(
                  controller: controller.medicineControllers[index],
                  hintText: 'Name of the medicine',
                  keyboardType: TextInputType.text,
                ),
              ),
              InkWell(
                onTap: () => controller.checkAndNavigate(
                  role,
                  userID,
                  userProfileData,
                  comorbiditiesData,
                  allergicMedicationsData,
                  context,
                ),
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


///-----------fully worked web code
// class CurrentOngoingMedications extends StatefulWidget {
//   String? userID;
//   String? role;
//   final Map<String, dynamic>? userProfileData;
//   final Map<String, dynamic>? comorbiditiesData;
//   final Map<String, dynamic>? allergicMedicationsData;

//   CurrentOngoingMedications({
//     this.role,
//     this.userProfileData,
//     this.comorbiditiesData,
//     this.allergicMedicationsData,
//     this.userID,
//   });

//   @override
//   State<CurrentOngoingMedications> createState() =>
//       _CurrentOngoingMedicationsState();
// }

// class _CurrentOngoingMedicationsState extends State<CurrentOngoingMedications> {
//   Map<String, dynamic> currentMedicationsData = {};

//   final TextEditingController medicineController1 = TextEditingController();
//   final TextEditingController medicineController2 = TextEditingController();
//   final TextEditingController medicineController3 = TextEditingController();
//   final TextEditingController medicineController4 = TextEditingController();
//   final TextEditingController medicineController5 = TextEditingController();
//   final TextEditingController medicineController6 = TextEditingController();
//   final TextEditingController medicineController7 = TextEditingController();
//   final TextEditingController medicineController8 = TextEditingController();
//   final TextEditingController medicineController9 = TextEditingController();
//   final TextEditingController medicineController10 = TextEditingController();

//   @override
//   void dispose() {
//     medicineController1.dispose();
//     medicineController2.dispose();
//     medicineController3.dispose();
//     medicineController4.dispose();
//     medicineController5.dispose();
//     medicineController6.dispose();
//     medicineController7.dispose();
//     medicineController8.dispose();
//     medicineController9.dispose();
//     medicineController10.dispose();
//     super.dispose();
//   }

//   void checkAndNavigate() {
//     // Collecting all entered medication names
//     List<String> medications = [
//       medicineController1.text.trim(),
//       medicineController2.text.trim(),
//       medicineController3.text.trim(),
//       medicineController4.text.trim(),
//       medicineController5.text.trim(),
//       medicineController6.text.trim(),
//       medicineController7.text.trim(),
//       medicineController8.text.trim(),
//       medicineController9.text.trim(),
//       medicineController10.text.trim(),
//     ];

//     // Removing empty entries
//     medications.removeWhere((med) => med.isEmpty);

//     // Checking for duplicates
//     Set<String> uniqueMedications = Set<String>();
//     for (String med in medications) {
//       if (uniqueMedications.contains(med)) {
//         Fluttertoast.showToast(
//           msg: "No repeated medications",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//         );
//         return; // Exit the function if duplicates are found
//       }
//       uniqueMedications.add(med);
//     }

//     // Populate currentMedicationsData
//     for (int i = 0; i < medications.length; i++) {
//       currentMedicationsData['medicine${i + 1}'] = medications[i];
//     }

//     // Navigate to the next screen
//     Navigator.push(
//       context,
//       CupertinoPageRoute(
//         builder: (context) => MedicalHistory(
//           role: widget.role!,
//           userID: widget.userID!,
//           userProfileData: widget.userProfileData!,
//           comorbiditiesData: widget.comorbiditiesData!,
//           allergicMedicationsData: widget.allergicMedicationsData!,
//           currentMedicationsData: currentMedicationsData,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Create Profile'),
//         actions: [
//           TextButton(
//             onPressed: checkAndNavigate,
//             child: Text(
//               'Skip',
//               style: TextStyle(color: Colors.blueAccent.shade700),
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
//           child: Column(
//             children: [
//               BoldTextWidgetTheme(text: 'Current Ongoing Medications'),
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
//               LightDarktextField(
//                 controller: medicineController6,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController7,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController8,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController9,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController10,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               InkWell(
//                 onTap: checkAndNavigate,
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

///-----------------------------------------------

// class CurrentOngoingMedications extends StatefulWidget {
//   String? userID;
//   String? role;
//   final Map<String, dynamic>? userProfileData;
//   final Map<String, dynamic>? comorbiditiesData;
//   final Map<String, dynamic>? allergicMedicationsData;

//   CurrentOngoingMedications({
//     this.role,
//     this.userProfileData,
//     this.comorbiditiesData,
//     this.allergicMedicationsData,
//     this.userID,
//   });

//   @override
//   State<CurrentOngoingMedications> createState() =>
//       _CurrentOngoingMedicationsState();
// }

// class _CurrentOngoingMedicationsState extends State<CurrentOngoingMedications> {
//   Map<String, dynamic> currentMedicationsData = {};

//   final TextEditingController medicineController1 = TextEditingController();
//   final TextEditingController medicineController2 = TextEditingController();
//   final TextEditingController medicineController3 = TextEditingController();
//   final TextEditingController medicineController4 = TextEditingController();
//   final TextEditingController medicineController5 = TextEditingController();
//   final TextEditingController medicineController6 = TextEditingController();
//   final TextEditingController medicineController7 = TextEditingController();
//   final TextEditingController medicineController8 = TextEditingController();
//   final TextEditingController medicineController9 = TextEditingController();
//   final TextEditingController medicineController10 = TextEditingController();

//   @override
//   void dispose() {
//     medicineController1.dispose();
//     medicineController2.dispose();
//     medicineController3.dispose();
//     medicineController4.dispose();
//     medicineController5.dispose();
//     medicineController6.dispose();
//     medicineController7.dispose();
//     medicineController8.dispose();
//     medicineController9.dispose();
//     medicineController10.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Create Profile'),
//         actions: [
//           // widget.role=='register'?
//           TextButton(
//               onPressed: () {
//                 currentMedicationsData['medicine1'] =
//                     medicineController1.text ?? '';
//                 currentMedicationsData['medicine2'] =
//                     medicineController2.text ?? '';
//                 currentMedicationsData['medicine3'] =
//                     medicineController3.text ?? '';
//                 currentMedicationsData['medicine4'] =
//                     medicineController4.text ?? '';
//                 currentMedicationsData['medicine5'] =
//                     medicineController5.text ?? '';
//                 currentMedicationsData['medicine6'] =
//                     medicineController6.text ?? '';
//                 currentMedicationsData['medicine7'] =
//                     medicineController7.text ?? '';
//                 currentMedicationsData['medicine8'] =
//                     medicineController8.text ?? '';
//                 currentMedicationsData['medicine9'] =
//                     medicineController9.text ?? '';
//                 currentMedicationsData['medicine10'] =
//                     medicineController10.text ?? '';
//                 print('currentMedicationsData=$currentMedicationsData');
//                 Navigator.push(
//                   context,
//                   CupertinoPageRoute(
//                     builder: (context) => MedicalHistory(
//                       role: widget.role!,
//                       userID: widget.userID!,
//                       userProfileData: widget.userProfileData!,
//                       comorbiditiesData: widget.comorbiditiesData!,
//                       allergicMedicationsData: widget.allergicMedicationsData!,
//                       currentMedicationsData: currentMedicationsData,
//                     ),
//                   ),
//                 );
//               },
//               child: Text(
//                 'Skip',
//                 style: TextStyle(color: Colors.blueAccent.shade700),
//               ))

//           //    :SizedBox()
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
//           child: Column(
//             children: [
//               BoldTextWidgetTheme(text: 'Current Ongoing Medications'),
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
//               LightDarktextField(
//                 controller: medicineController6,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController7,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController8,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController9,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicineController10,
//                 hintText: 'Name of the medicine',
//                 keyboardType: TextInputType.text,
//               ),
//               InkWell(
//                 onTap: () {
//                   currentMedicationsData['medicine1'] =
//                       medicineController1.text ?? '';
//                   currentMedicationsData['medicine2'] =
//                       medicineController2.text ?? '';
//                   currentMedicationsData['medicine3'] =
//                       medicineController3.text ?? '';
//                   currentMedicationsData['medicine4'] =
//                       medicineController4.text ?? '';
//                   currentMedicationsData['medicine5'] =
//                       medicineController5.text ?? '';
//                   currentMedicationsData['medicine6'] =
//                       medicineController6.text ?? '';
//                   currentMedicationsData['medicine7'] =
//                       medicineController7.text ?? '';
//                   currentMedicationsData['medicine8'] =
//                       medicineController8.text ?? '';
//                   currentMedicationsData['medicine9'] =
//                       medicineController9.text ?? '';
//                   currentMedicationsData['medicine10'] =
//                       medicineController10.text ?? '';
//                   print('currentMedicationsData=$currentMedicationsData');
//                   Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                       builder: (context) => MedicalHistory(
//                         role: widget.role!,
//                         userID: widget.userID!,
//                         userProfileData: widget.userProfileData!,
//                         comorbiditiesData: widget.comorbiditiesData!,
//                         allergicMedicationsData:
//                             widget.allergicMedicationsData!,
//                         currentMedicationsData: currentMedicationsData,
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
