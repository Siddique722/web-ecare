
import 'package:ecare/views/Home-Views/Users-View/Edit-Users/editmedical-history.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';

// class EditCurrentOngoingMedications extends StatefulWidget {
//   final String role;
//   final String userID;
//   final Map<String, dynamic> userProfileData;
//   final Map<String, dynamic> allergicMedicationsData;
//   final Map<String, dynamic> comorbiditiesData;
//   final Map<String, dynamic> currentMedicationsData;
//   final Map<String, dynamic> medicalHistoryData;
//   final Map<String, dynamic> surgicalHistoryData;
//   String? familyId;

//   EditCurrentOngoingMedications({
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
//   State<EditCurrentOngoingMedications> createState() =>
//       _EditCurrentOngoingMedicationsState();
// }

// class _EditCurrentOngoingMedicationsState
//     extends State<EditCurrentOngoingMedications> {

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
//   void initState() {
//     super.initState();

//     // Assuming that userId is set somewhere before initState is called
//     // Extract the specific user's medication data from the nested map
//     if (widget.currentMedicationsData.containsKey(widget.familyId)) {
//       var userData = widget.currentMedicationsData[widget.familyId];
//       medicineController1.text = userData['medicine1'] ?? '';
//       medicineController2.text = userData['medicine2'] ?? '';
//       medicineController3.text = userData['medicine3'] ?? '';
//       medicineController4.text = userData['medicine4'] ?? '';
//       medicineController5.text = userData['medicine5'] ?? '';
//       medicineController6.text = userData['medicine6'] ?? '';
//       medicineController7.text = userData['medicine7'] ?? '';
//       medicineController8.text = userData['medicine8'] ?? '';
//       medicineController9.text = userData['medicine9'] ?? '';
//       medicineController10.text = userData['medicine10'] ?? '';
//     }
//   }

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
//           TextButton(
//             onPressed: () {
//               // Update currentMedicationsData with current field values
//               if (widget.currentMedicationsData.containsKey(widget.familyId)) {
//                 var userData = widget.currentMedicationsData[widget.familyId];
//                 userData['medicine1'] = medicineController1.text ?? '';
//                 userData['medicine2'] = medicineController2.text ?? '';
//                 userData['medicine3'] = medicineController3.text ?? '';
//                 userData['medicine4'] = medicineController4.text ?? '';
//                 userData['medicine5'] = medicineController5.text ?? '';
//                 userData['medicine6'] = medicineController6.text ?? '';
//                 userData['medicine7'] = medicineController7.text ?? '';
//                 userData['medicine8'] = medicineController8.text ?? '';
//                 userData['medicine9'] = medicineController9.text ?? '';
//                 userData['medicine10'] = medicineController10.text ?? '';
//                 print('currentMedicationsData=$currentMedicationsData');
//                 Navigator.push(
//                   context,
//                   CupertinoPageRoute(
//                     builder: (context) => MedicalHistory(
//                       role: widget.role,
//                       userID: widget.userID,
//                       userProfileData: widget.userProfileData,
//                       comorbiditiesData: widget.comorbiditiesData,
//                       allergicMedicationsData: widget.allergicMedicationsData,
//                       currentMedicationsData: widget.currentMedicationsData,
//                     ),
//                   ),
//                 );
//               }
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
//                   // Update currentMedicationsData with current field values
//                   if (widget.currentMedicationsData
//                       .containsKey(widget.familyId)) {
//                     var userData =
//                         widget.currentMedicationsData[widget.familyId];
//                     userData['medicine1'] = medicineController1.text ?? '';
//                     userData['medicine2'] = medicineController2.text ?? '';
//                     userData['medicine3'] = medicineController3.text ?? '';
//                     userData['medicine4'] = medicineController4.text ?? '';
//                     userData['medicine5'] = medicineController5.text ?? '';
//                     userData['medicine6'] = medicineController6.text ?? '';
//                     userData['medicine7'] = medicineController7.text ?? '';
//                     userData['medicine8'] = medicineController8.text ?? '';
//                     userData['medicine9'] = medicineController9.text ?? '';
//                     userData['medicine10'] = medicineController10.text ?? '';
//                     print('currentMedicationsData=$currentMedicationsData');
//                     Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (context) => EditMedicalHistory(
//                           role: widget.role,
//                           userID: widget.userID,
//                           familyId: widget.familyId,
//                           userProfileData: widget.userProfileData,
//                           comorbiditiesData: widget.comorbiditiesData,
//                           allergicMedicationsData:
//                               widget.allergicMedicationsData,
//                           currentMedicationsData: widget.currentMedicationsData,
//                           medicalHistoryData: widget.medicalHistoryData,
//                           surgicalHistoryData: widget.surgicalHistoryData,
//                         ),
//                       ),
//                     );
//                   }
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

// // class _EditCurrentOngoingMedicationsState
// //     extends State<EditCurrentOngoingMedications> {
// //   Map<String, dynamic> currentMedicationsData = {};

// //   final TextEditingController medicineController1 = TextEditingController();
// //   final TextEditingController medicineController2 = TextEditingController();
// //   final TextEditingController medicineController3 = TextEditingController();
// //   final TextEditingController medicineController4 = TextEditingController();
// //   final TextEditingController medicineController5 = TextEditingController();
// //   final TextEditingController medicineController6 = TextEditingController();
// //   final TextEditingController medicineController7 = TextEditingController();
// //   final TextEditingController medicineController8 = TextEditingController();
// //   final TextEditingController medicineController9 = TextEditingController();
// //   final TextEditingController medicineController10 = TextEditingController();
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     print('famile currentMedicationsData:${widget.currentMedicationsData}');
// //     medicineController1.text = widget.currentMedicationsData['medicine1'] ?? '';
// //     medicineController2.text = widget.currentMedicationsData['medicine2'] ?? '';
// //     medicineController3.text = widget.currentMedicationsData['medicine3'] ?? '';
// //     medicineController4.text = widget.currentMedicationsData['medicine4'] ?? '';
// //     medicineController5.text = widget.currentMedicationsData['medicine5'] ?? '';
// //     medicineController6.text = widget.currentMedicationsData['medicine6'] ?? "";
// //     medicineController7.text = widget.currentMedicationsData['medicine7'] ?? "";
// //     medicineController8.text = widget.currentMedicationsData['medicine8'] ?? '';
// //     medicineController9.text = widget.currentMedicationsData['medicine9'] ?? '';
// //     medicineController10.text =
// //         widget.currentMedicationsData['medicine10'] ?? '';
// //   }

// //   @override
// //   void dispose() {
// //     medicineController1.dispose();
// //     medicineController2.dispose();
// //     medicineController3.dispose();
// //     medicineController4.dispose();
// //     medicineController5.dispose();
// //     medicineController6.dispose();
// //     medicineController7.dispose();
// //     medicineController8.dispose();
// //     medicineController9.dispose();
// //     medicineController10.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         title: BoldTextWidgetTheme(text: 'Create Profile'),
// //         actions: [
// //           // widget.role=='register'?
// //           TextButton(
// //               onPressed: () {
// //                 currentMedicationsData['medicine1'] =
// //                     medicineController1.text ?? '';
// //                 currentMedicationsData['medicine2'] =
// //                     medicineController2.text ?? '';
// //                 currentMedicationsData['medicine3'] =
// //                     medicineController3.text ?? '';
// //                 currentMedicationsData['medicine4'] =
// //                     medicineController4.text ?? '';
// //                 currentMedicationsData['medicine5'] =
// //                     medicineController5.text ?? '';
// //                 currentMedicationsData['medicine6'] =
// //                     medicineController6.text ?? '';
// //                 currentMedicationsData['medicine7'] =
// //                     medicineController7.text ?? '';
// //                 currentMedicationsData['medicine8'] =
// //                     medicineController8.text ?? '';
// //                 currentMedicationsData['medicine9'] =
// //                     medicineController9.text ?? '';
// //                 currentMedicationsData['medicine10'] =
// //                     medicineController10.text ?? '';
// //                 print('currentMedicationsData=$currentMedicationsData');
// //                 Navigator.push(
// //                   context,
// //                   CupertinoPageRoute(
// //                     builder: (context) => MedicalHistory(
// //                       role: widget.role,
// //                       userID: widget.userID,
// //                       userProfileData: widget.userProfileData,
// //                       comorbiditiesData: widget.comorbiditiesData,
// //                       allergicMedicationsData: widget.allergicMedicationsData,
// //                       currentMedicationsData: currentMedicationsData,
// //                     ),
// //                   ),
// //                 );
// //               },
// //               child: Text(
// //                 'Skip',
// //                 style: TextStyle(color: Colors.blueAccent.shade700),
// //               ))

// //           //    :SizedBox()
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
// //           child: Column(
// //             children: [
// //               BoldTextWidgetTheme(text: 'Current Ongoing Medications'),
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
// //               LightDarktextField(
// //                 controller: medicineController6,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController7,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController8,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController9,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicineController10,
// //                 hintText: 'Name of the medicine',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               InkWell(
// //                 onTap: () {
// //                   currentMedicationsData['medicine1'] =
// //                       medicineController1.text ?? '';
// //                   currentMedicationsData['medicine2'] =
// //                       medicineController2.text ?? '';
// //                   currentMedicationsData['medicine3'] =
// //                       medicineController3.text ?? '';
// //                   currentMedicationsData['medicine4'] =
// //                       medicineController4.text ?? '';
// //                   currentMedicationsData['medicine5'] =
// //                       medicineController5.text ?? '';
// //                   currentMedicationsData['medicine6'] =
// //                       medicineController6.text ?? '';
// //                   currentMedicationsData['medicine7'] =
// //                       medicineController7.text ?? '';
// //                   currentMedicationsData['medicine8'] =
// //                       medicineController8.text ?? '';
// //                   currentMedicationsData['medicine9'] =
// //                       medicineController9.text ?? '';
// //                   currentMedicationsData['medicine10'] =
// //                       medicineController10.text ?? '';
// //                   print('currentMedicationsData=$currentMedicationsData');
// //                   Navigator.push(
// //                     context,
// //                     CupertinoPageRoute(
// //                       builder: (context) => EditMedicalHistory(
// //                         role: widget.role,
// //                         userID: widget.userID,
// //                         familyId: widget.familyId,
// //                         userProfileData: widget.userProfileData,
// //                         comorbiditiesData: widget.comorbiditiesData,
// //                         allergicMedicationsData: widget.allergicMedicationsData,
// //                         currentMedicationsData: currentMedicationsData,
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

///-----------------------------------------------------------------------------
///
class EditCurrentOngoingMedications extends StatefulWidget {
  final String role;
  final String userID;
  final Map<String, dynamic> userProfileData;
  final Map<String, dynamic> allergicMedicationsData;
  final Map<String, dynamic> comorbiditiesData;
  final Map<String, dynamic> currentMedicationsData;
  final Map<String, dynamic> medicalHistoryData;
  final Map<String, dynamic> surgicalHistoryData;
  String? familyId;

  EditCurrentOngoingMedications({
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
  State<EditCurrentOngoingMedications> createState() =>
      _EditCurrentOngoingMedicationsState();
}

class _EditCurrentOngoingMedicationsState
    extends State<EditCurrentOngoingMedications> {
  Map<String, dynamic> currentMedicationsData = {};

  final TextEditingController medicineController1 = TextEditingController();
  final TextEditingController medicineController2 = TextEditingController();
  final TextEditingController medicineController3 = TextEditingController();
  final TextEditingController medicineController4 = TextEditingController();
  final TextEditingController medicineController5 = TextEditingController();
  final TextEditingController medicineController6 = TextEditingController();
  final TextEditingController medicineController7 = TextEditingController();
  final TextEditingController medicineController8 = TextEditingController();
  final TextEditingController medicineController9 = TextEditingController();
  final TextEditingController medicineController10 = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.role == 'family' && widget.familyId != null) {
      if (widget.currentMedicationsData.containsKey(widget.familyId)) {
        var userData = widget.currentMedicationsData[widget.familyId];
        medicineController1.text = userData['medicine1'] ?? '';
        medicineController2.text = userData['medicine2'] ?? '';
        medicineController3.text = userData['medicine3'] ?? '';
        medicineController4.text = userData['medicine4'] ?? '';
        medicineController5.text = userData['medicine5'] ?? '';
        medicineController6.text = userData['medicine6'] ?? '';
        medicineController7.text = userData['medicine7'] ?? '';
        medicineController8.text = userData['medicine8'] ?? '';
        medicineController9.text = userData['medicine9'] ?? '';
        medicineController10.text = userData['medicine10'] ?? '';
      }
    } else if (widget.role == 'admin') {
      medicineController1.text =
          widget.currentMedicationsData['medicine1'] ?? '';
      medicineController2.text =
          widget.currentMedicationsData['medicine2'] ?? '';
      medicineController3.text =
          widget.currentMedicationsData['medicine3'] ?? '';
      medicineController4.text =
          widget.currentMedicationsData['medicine4'] ?? '';
      medicineController5.text =
          widget.currentMedicationsData['medicine5'] ?? '';
      medicineController6.text =
          widget.currentMedicationsData['medicine6'] ?? '';
      medicineController7.text =
          widget.currentMedicationsData['medicine7'] ?? '';
      medicineController8.text =
          widget.currentMedicationsData['medicine8'] ?? '';
      medicineController9.text =
          widget.currentMedicationsData['medicine9'] ?? '';
      medicineController10.text =
          widget.currentMedicationsData['medicine10'] ?? '';
    }
  }

  @override
  void dispose() {
    medicineController1.dispose();
    medicineController2.dispose();
    medicineController3.dispose();
    medicineController4.dispose();
    medicineController5.dispose();
    medicineController6.dispose();
    medicineController7.dispose();
    medicineController8.dispose();
    medicineController9.dispose();
    medicineController10.dispose();
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
              if (widget.role == 'family' && widget.familyId != null) {
                currentMedicationsData['medicine1'] =
                    medicineController1.text ??
                        widget.currentMedicationsData['medicine1'];
                currentMedicationsData['medicine2'] =
                    medicineController2.text ?? '';
                currentMedicationsData['medicine3'] =
                    medicineController3.text ?? '';
                currentMedicationsData['medicine4'] =
                    medicineController4.text ?? '';
                currentMedicationsData['medicine5'] =
                    medicineController5.text ?? '';
                currentMedicationsData['medicine6'] =
                    medicineController6.text ?? '';
                currentMedicationsData['medicine7'] =
                    medicineController7.text ?? '';
                currentMedicationsData['medicine8'] =
                    medicineController8.text ?? '';
                currentMedicationsData['medicine9'] =
                    medicineController9.text ?? '';
                currentMedicationsData['medicine10'] =
                    medicineController10.text ?? '';
                // if (widget.currentMedicationsData
                //     .containsKey(widget.familyId)) {

                //   // var userData = widget.currentMedicationsData[widget.familyId];
                //   // userData['medicine1'] = medicineController1.text ?? '';
                //   // userData['medicine2'] = medicineController2.text ?? '';
                //   // userData['medicine3'] = medicineController3.text ?? '';
                //   // userData['medicine4'] = medicineController4.text ?? '';
                //   // userData['medicine5'] = medicineController5.text ?? '';
                //   // userData['medicine6'] = medicineController6.text ?? '';
                //   // userData['medicine7'] = medicineController7.text ?? '';
                //   // userData['medicine8'] = medicineController8.text ?? '';
                //   // userData['medicine9'] = medicineController9.text ?? '';
                //   // userData['medicine10'] = medicineController10.text ?? '';
                //   print('currentMedicationsData=$currentMedicationsData');
                // }
              } else if (widget.role == 'admin') {
                currentMedicationsData['medicine1'] =
                    medicineController1.text ??
                        widget.currentMedicationsData['medicine1'];
                currentMedicationsData['medicine2'] =
                    medicineController2.text ?? '';
                currentMedicationsData['medicine3'] =
                    medicineController3.text ?? '';
                currentMedicationsData['medicine4'] =
                    medicineController4.text ?? '';
                currentMedicationsData['medicine5'] =
                    medicineController5.text ?? '';
                currentMedicationsData['medicine6'] =
                    medicineController6.text ?? '';
                currentMedicationsData['medicine7'] =
                    medicineController7.text ?? '';
                currentMedicationsData['medicine8'] =
                    medicineController8.text ?? '';
                currentMedicationsData['medicine9'] =
                    medicineController9.text ?? '';
                currentMedicationsData['medicine10'] =
                    medicineController10.text ?? '';
                print('currentMedicationsData=$currentMedicationsData');
              }
              print('medical history:${widget.medicalHistoryData}');
              print('surgical history:${widget.surgicalHistoryData}');
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => EditMedicalHistory(
                    role: widget.role,
                    userID: widget.userID,
                    familyId: widget.familyId,
                    userProfileData: widget.userProfileData,
                    comorbiditiesData: widget.comorbiditiesData,
                    allergicMedicationsData: widget.allergicMedicationsData,
                    currentMedicationsData: currentMedicationsData,
                    medicalHistoryData: widget.medicalHistoryData,
                    surgicalHistoryData: widget.surgicalHistoryData,
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
              BoldTextWidgetTheme(text: 'Current Ongoing Medications'),
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
              LightDarktextField(
                controller: medicineController6,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController7,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController8,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController9,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicineController10,
                hintText: 'Name of the medicine',
                keyboardType: TextInputType.text,
              ),
              InkWell(
                onTap: () {
                  if (widget.role == 'family' && widget.familyId != null) {
                    currentMedicationsData['medicine1'] =
                        medicineController1.text ??
                            widget.currentMedicationsData['medicine1'];
                    currentMedicationsData['medicine2'] =
                        medicineController2.text ?? '';
                    currentMedicationsData['medicine3'] =
                        medicineController3.text ?? '';
                    currentMedicationsData['medicine4'] =
                        medicineController4.text ?? '';
                    currentMedicationsData['medicine5'] =
                        medicineController5.text ?? '';
                    currentMedicationsData['medicine6'] =
                        medicineController6.text ?? '';
                    currentMedicationsData['medicine7'] =
                        medicineController7.text ?? '';
                    currentMedicationsData['medicine8'] =
                        medicineController8.text ?? '';
                    currentMedicationsData['medicine9'] =
                        medicineController9.text ?? '';
                    currentMedicationsData['medicine10'] =
                        medicineController10.text ?? '';
                    // if (widget.currentMedicationsData
                    //     .containsKey(widget.familyId)) {

                    //   // var userData = widget.currentMedicationsData[widget.familyId];
                    //   // userData['medicine1'] = medicineController1.text ?? '';
                    //   // userData['medicine2'] = medicineController2.text ?? '';
                    //   // userData['medicine3'] = medicineController3.text ?? '';
                    //   // userData['medicine4'] = medicineController4.text ?? '';
                    //   // userData['medicine5'] = medicineController5.text ?? '';
                    //   // userData['medicine6'] = medicineController6.text ?? '';
                    //   // userData['medicine7'] = medicineController7.text ?? '';
                    //   // userData['medicine8'] = medicineController8.text ?? '';
                    //   // userData['medicine9'] = medicineController9.text ?? '';
                    //   // userData['medicine10'] = medicineController10.text ?? '';
                    //   print('currentMedicationsData=$currentMedicationsData');
                    // }
                  } else if (widget.role == 'admin') {
                    currentMedicationsData['medicine1'] =
                        medicineController1.text ??
                            widget.currentMedicationsData['medicine1'];
                    currentMedicationsData['medicine2'] =
                        medicineController2.text ?? '';
                    currentMedicationsData['medicine3'] =
                        medicineController3.text ?? '';
                    currentMedicationsData['medicine4'] =
                        medicineController4.text ?? '';
                    currentMedicationsData['medicine5'] =
                        medicineController5.text ?? '';
                    currentMedicationsData['medicine6'] =
                        medicineController6.text ?? '';
                    currentMedicationsData['medicine7'] =
                        medicineController7.text ?? '';
                    currentMedicationsData['medicine8'] =
                        medicineController8.text ?? '';
                    currentMedicationsData['medicine9'] =
                        medicineController9.text ?? '';
                    currentMedicationsData['medicine10'] =
                        medicineController10.text ?? '';
                    print('currentMedicationsData=$currentMedicationsData');
                  }
                  print('medical history:${widget.medicalHistoryData}');
                  print('surgical history:${widget.surgicalHistoryData}');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EditMedicalHistory(
                        role: widget.role,
                        userID: widget.userID,
                        familyId: widget.familyId,
                        userProfileData: widget.userProfileData,
                        comorbiditiesData: widget.comorbiditiesData,
                        allergicMedicationsData: widget.allergicMedicationsData,
                        currentMedicationsData: currentMedicationsData,
                        medicalHistoryData: widget.medicalHistoryData,
                        surgicalHistoryData: widget.surgicalHistoryData,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Save & Continue',
                    style: TextStyle(color: Colors.blueAccent.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
