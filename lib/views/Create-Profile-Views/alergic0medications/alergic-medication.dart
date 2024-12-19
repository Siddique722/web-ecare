
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';

// class AlergicMedications extends StatefulWidget {
//   String? role;
//   String? userId;
//   final Map<String, dynamic>? userProfileData;
//   final Map<String, dynamic>? comorbiditiesData;

//   AlergicMedications(
//       {this.userProfileData, this.role, this.comorbiditiesData, this.userId});

//   @override
//   State<AlergicMedications> createState() => _AlergicMedicationsState();
// }

import 'package:ecare/constants/linker.dart';

import 'package:flutter/cupertino.dart';

class AlergicMedications extends StatefulWidget {
  final String? role;
  final String? userId;
  final Map<String, dynamic>? userProfileData;
  final Map<String, dynamic>? comorbiditiesData;

  AlergicMedications({
    this.userProfileData,
    this.role,
    this.comorbiditiesData,
    this.userId,
  });

  @override
  State<AlergicMedications> createState() => _AlergicMedicationsState();
}

// class _AlergicMedicationsState extends State<AlergicMedications> {
//   Map<String, dynamic> allergicMedicationsData = {};
//
//   final TextEditingController medicineController1 = TextEditingController();
//   final TextEditingController medicineController2 = TextEditingController();
//   final TextEditingController medicineController3 = TextEditingController();
//   final TextEditingController medicineController4 = TextEditingController();
//   final TextEditingController medicineController5 = TextEditingController();
//
//   void _storeUserData() {
//     allergicMedicationsData['medicineController1'] =
//         medicineController1.text ?? '';
//     allergicMedicationsData['medicineController2'] =
//         medicineController2.text ?? '';
//     allergicMedicationsData['medicineController3'] =
//         medicineController3.text ?? '';
//     allergicMedicationsData['medicineController4'] =
//         medicineController4.text ?? '';
//     allergicMedicationsData['medicineController5'] =
//         medicineController5.text ?? '';
//     allergicMedicationsData['userId'] = widget.userId!;
//   }
//   // void _storeUserData() {
//   //   allergicMedicationsData['medicineController1'] = medicineController1.text;
//   //   allergicMedicationsData['medicineController2'] = medicineController2.text;
//   //   allergicMedicationsData['medicineController3'] = medicineController3.text;
//   //   allergicMedicationsData['medicineController4'] = medicineController4.text;
//   //   allergicMedicationsData['medicineController5'] = medicineController5.text;
//   //   allergicMedicationsData['userId'] = widget.userId!;
//   // }
//
//   @override
//   void dispose() {
//     medicineController1.dispose();
//     medicineController2.dispose();
//     medicineController3.dispose();
//     medicineController4.dispose();
//     medicineController5.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Check for potential null values before navigation
//     // if (widget.role == null ||
//     //     widget.userId == null ||
//     //     widget.userProfileData == null ||
//     //     widget.comorbiditiesData == null) {
//     //   return Scaffold(
//     //     body: Center(
//     //       child: Text(
//     //           'Some required data is missing. Please go back and try again.'),
//     //     ),
//     //   );
//     // }
//
//     // Make the screen responsive
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Create Profile'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _storeUserData();
//               print('object=$allergicMedicationsData');
//               Navigator.push(
//                 context,
//                 CupertinoPageRoute(
//                   builder: (context) => CurrentOngoingMedications(
//                     role: widget.role!,
//                     userID: widget.userId!,
//                     userProfileData: widget.userProfileData!,
//                     comorbiditiesData: widget.comorbiditiesData!,
//                     allergicMedicationsData: allergicMedicationsData,
//                   ),
//                 ),
//               );
//             },
//             child: Text(
//               'Skip',
//               style: TextStyle(color: Colors.blueAccent.shade700),
//             ),
//           )
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Adjust padding and layout based on screen size
//           bool isWideScreen = constraints.maxWidth > 800;
//           double horizontalPadding = isWideScreen ? 100.0 : 20.0;
//           double verticalPadding = isWideScreen ? 24.0 : 16.0;
//
//           return SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: horizontalPadding, vertical: verticalPadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   BoldTextWidgetTheme(text: 'Allergic Medications'),
//                   SizedBox(height: 20),
//                   LightDarktextField(
//                     controller: medicineController1,
//                     hintText: 'Name of the medicine',
//                     keyboardType: TextInputType.text,
//                   ),
//                   LightDarktextField(
//                     controller: medicineController2,
//                     hintText: 'Name of the medicine',
//                     keyboardType: TextInputType.text,
//                   ),
//                   LightDarktextField(
//                     controller: medicineController3,
//                     hintText: 'Name of the medicine',
//                     keyboardType: TextInputType.text,
//                   ),
//                   LightDarktextField(
//                     controller: medicineController4,
//                     hintText: 'Name of the medicine',
//                     keyboardType: TextInputType.text,
//                   ),
//                   LightDarktextField(
//                     controller: medicineController5,
//                     hintText: 'Name of the medicine',
//                     keyboardType: TextInputType.text,
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // _storeUserData();
//                           print('object=$allergicMedicationsData');
//                           Navigator.push(
//                             context,
//                             CupertinoPageRoute(
//                               builder: (context) => CurrentOngoingMedications(
//                                 role: widget.role!,
//                                 userID: widget.userId!,
//                                 userProfileData: widget.userProfileData!,
//                                 comorbiditiesData: widget.comorbiditiesData!,
//                                 allergicMedicationsData:
//                                     allergicMedicationsData!,
//                               ),
//                             ),
//                           );
//                         },
//                         child: BlueButton(
//                           text: 'Next',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class _AlergicMedicationsState extends State<AlergicMedications> {
  Map<String, dynamic> allergicMedicationsData = {};

  final TextEditingController medicineController1 = TextEditingController();
  final TextEditingController medicineController2 = TextEditingController();
  final TextEditingController medicineController3 = TextEditingController();
  final TextEditingController medicineController4 = TextEditingController();
  final TextEditingController medicineController5 = TextEditingController();

  void _storeUserData() {
    allergicMedicationsData['medicineController1'] =
        medicineController1.text ?? '';
    allergicMedicationsData['medicineController2'] =
        medicineController2.text ?? '';
    allergicMedicationsData['medicineController3'] =
        medicineController3.text ?? '';
    allergicMedicationsData['medicineController4'] =
        medicineController4.text ?? '';
    allergicMedicationsData['medicineController5'] =
        medicineController5.text ?? '';
    allergicMedicationsData['userId'] = widget.userId;
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
        title: BoldTextWidgetTheme(text: 'Create Profile'),
        actions: [
          //widget.role=='register'?
          TextButton(
            onPressed: () {
              _storeUserData();
              print('object=$allergicMedicationsData');
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CurrentOngoingMedications(
                    role: widget.role!,
                    userID: widget.userId!,
                    userProfileData: widget.userProfileData!,
                    comorbiditiesData: widget.comorbiditiesData!,
                    allergicMedicationsData: allergicMedicationsData!,
                  ),
                ),
              );
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.blueAccent.shade700),
            ),
          )
          //  :SizedBox()
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
                  allergicMedicationsData['medicine1'] =
                      medicineController1.text;
                  allergicMedicationsData['medicine2'] =
                      medicineController2.text;
                  allergicMedicationsData['medicine3'] =
                      medicineController3.text;
                  allergicMedicationsData['medicine4'] =
                      medicineController4.text;
                  allergicMedicationsData['medicine5'] =
                      medicineController5.text;
                  _storeUserData();
                  print('object=$allergicMedicationsData');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CurrentOngoingMedications(
                        role: widget.role!,
                        userID: widget.userId!,
                        userProfileData: widget.userProfileData!,
                        comorbiditiesData: widget.comorbiditiesData!,
                        allergicMedicationsData: allergicMedicationsData,
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
