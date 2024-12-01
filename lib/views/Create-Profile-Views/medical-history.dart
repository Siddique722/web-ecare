// // import 'dart:io';
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:demo_app/views/Home-Views/Nav-Bar/nav-bar-.dart';
// // import 'package:demo_app/views/Verification-View/verify-view.dart';
// // import 'package:demo_app/widgets/blue-button.dart';
// // import 'package:demo_app/widgets/text-widgets.dart';
// // import 'package:demo_app/widgets/theme-text-field.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
//
// // class MedicalHistory extends StatefulWidget {
// //   String userID;
// //   String role;
// //   final Map<String, dynamic> userProfileData;
// //   final Map<String, dynamic> comorbiditiesData;
// //   final Map<String, dynamic> allergicMedicationsData;
// //   final Map<String, dynamic> currentMedicationsData;
//
// //   MedicalHistory({
// //     required this.userProfileData,
// //     required this.role,
// //     required this.comorbiditiesData,
// //     required this.allergicMedicationsData,
// //     required this.currentMedicationsData,
// //     required this.userID,
// //   });
//
// //   @override
// //   State<MedicalHistory> createState() => _MedicalHistoryState();
// // }
//
// // class _MedicalHistoryState extends State<MedicalHistory> {
// //   final TextEditingController medicalHistoryController1 =
// //       TextEditingController();
// //   final TextEditingController medicalHistoryController2 =
// //       TextEditingController();
// //   final TextEditingController surgicalHistoryController1 =
// //       TextEditingController();
// //   final TextEditingController surgicalHistoryController2 =
// //       TextEditingController();
//
// //   Map<String, dynamic> medicalHistoryData = {};
// //   Map<String, dynamic> surgicalHistoryData = {};
//
// //   @override
// //   void dispose() {
// //     medicalHistoryController1.dispose();
// //     medicalHistoryController2.dispose();
// //     surgicalHistoryController1.dispose();
// //     surgicalHistoryController2.dispose();
// //     super.dispose();
// //   }
//
// //   bool isLoading = false;
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         title: BoldTextWidgetTheme(text: 'Create Profile'),
// //         actions: [
// //           TextButton(
// //               onPressed: () async {
// //                 // Collect data into maps
// //                 medicalHistoryData['history1'] =
// //                     medicalHistoryController1.text ?? '';
// //                 medicalHistoryData['history2'] =
// //                     medicalHistoryController2.text ?? '';
// //                 medicalHistoryData['userId'] = widget.userID;
// //                 surgicalHistoryData['surgery1'] =
// //                     surgicalHistoryController1.text ?? '';
// //                 surgicalHistoryData['surgery2'] =
// //                     surgicalHistoryController2.text ?? '';
// //                 surgicalHistoryData['userID'] = widget.userID;
//
// //                 // Print all maps
// //                 print('User Profile Data: ${widget.userProfileData}');
// //                 print('Comorbidities Data: ${widget.comorbiditiesData}');
// //                 print(
// //                     'Allergic Medications Data: ${widget.allergicMedicationsData}');
// //                 print(
// //                     'Current Medications Data: ${widget.currentMedicationsData}');
// //                 print('Medical History Data: $medicalHistoryData');
// //                 print('Surgical History Data: $surgicalHistoryData');
// //                 if (widget.role == 'register') {
// //                   createUserProfile();
// //                 } else if (widget.role == 'family') {
// //                   createFamilyProfile();
// //                 }
// //               },
// //               child: Text(
// //                 'Skip',
// //                 style: TextStyle(color: Colors.blueAccent.shade700),
// //               ))
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
// //           child: Column(
// //             children: [
// //               BoldTextWidgetTheme(text: 'Other Medical History'),
// //               SimpleTextWidgetTheme(
// //                 text:
// //                     'Please provide the diagnosis, year of diagnosis and treatment done if any with minimum 3 lines',
// //               ),
// //               LightDarktextField(
// //                 controller: medicalHistoryController1,
// //                 hintText: 'Medical History',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: medicalHistoryController2,
// //                 hintText: 'Medical History',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               SizedBox(height: 20.0),
// //               BoldTextWidgetTheme(text: 'Other Surgical History'),
// //               SimpleTextWidgetTheme(
// //                 text:
// //                     'Please provide the diagnosis, year of diagnosis and treatment done if any with minimum 3 lines',
// //               ),
// //               LightDarktextField(
// //                 controller: surgicalHistoryController1,
// //                 hintText: 'Surgical History',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               LightDarktextField(
// //                 controller: surgicalHistoryController2,
// //                 hintText: 'Surgical History',
// //                 keyboardType: TextInputType.text,
// //               ),
// //               isLoading
// //                   ? CircularProgressIndicator()
// //                   : InkWell(
// //                       onTap: () async {
// //                         // Collect data into maps
// //                         medicalHistoryData['history1'] =
// //                             medicalHistoryController1.text ?? '';
// //                         medicalHistoryData['history2'] =
// //                             medicalHistoryController2.text ?? '';
// //                         medicalHistoryData['userId'] = widget.userID;
// //                         surgicalHistoryData['surgery1'] =
// //                             surgicalHistoryController1.text ?? '';
// //                         surgicalHistoryData['surgery2'] =
// //                             surgicalHistoryController2.text ?? '';
// //                         surgicalHistoryData['userID'] = widget.userID;
//
// //                         // Print all maps
// //                         print('User Profile Data: ${widget.userProfileData}');
// //                         print(
// //                             'Comorbidities Data: ${widget.comorbiditiesData}');
// //                         print(
// //                             'Allergic Medications Data: ${widget.allergicMedicationsData}');
// //                         print(
// //                             'Current Medications Data: ${widget.currentMedicationsData}');
// //                         print('Medical History Data: $medicalHistoryData');
// //                         print('Surgical History Data: $surgicalHistoryData');
// //                         if (widget.role == 'register') {
// //                           createUserProfile();
// //                         } else if (widget.role == 'family') {
// //                           createFamilyProfile();
// //                         }
// //                       },
// //                       child: BlueButton(
// //                         text: 'Update',
// //                       ),
// //                     ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
//
// //   Future<void> createUserProfile() async {
// //     try {
// //       setState(() {
// //         isLoading = true;
// //       });
//
// //       // Upload the profile image to Firebase Storage
// //       if (widget.userProfileData['profileImage'] != null) {
// //         File imageFile = widget.userProfileData['profileImage'];
// //         String fileName = '${widget.userID}_profileImage.png';
// //         Reference storageReference =
// //             FirebaseStorage.instance.ref().child('profileImages/$fileName');
// //         UploadTask uploadTask = storageReference.putFile(imageFile);
//
// //         // Wait for the upload to complete
// //         TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//
// //         // Download the URL of the uploaded image
// //         String downloadURL = await taskSnapshot.ref.getDownloadURL();
//
// //         // Store the download URL in the userProfileData map
// //         widget.userProfileData['profileImage'] = downloadURL;
// //       }
//
// //       // Save data to Firestore
// //       await FirebaseFirestore.instance
// //           .collection('userProfileData')
// //           .doc(widget.userID)
// //           .set(widget.userProfileData);
// //       //------------------1
// //       await FirebaseFirestore.instance
// //           .collection('comorbiditiesData')
// //           .doc(widget.userID)
// //           .set(widget.comorbiditiesData);
// //       //-----------------2
// //       await FirebaseFirestore.instance
// //           .collection('allergicMedicationsData')
// //           .doc(widget.userID)
// //           .set(widget.allergicMedicationsData);
// //       //-----------------3
// //       await FirebaseFirestore.instance
// //           .collection('currentMedicationsData')
// //           .doc(widget.userID)
// //           .set(widget.currentMedicationsData);
// //       //---------------4
// //       await FirebaseFirestore.instance
// //           .collection('medicalHistoryData')
// //           .doc(widget.userID)
// //           .set(medicalHistoryData);
// //       //---------------5
// //       await FirebaseFirestore.instance
// //           .collection('surgicalHistoryData')
// //           .doc(widget.userID)
// //           .set(surgicalHistoryData);
//
// //       // Navigate to VerifyView
// //       Navigator.pushReplacement(
// //         context,
// //         CupertinoPageRoute(
// //           builder: (context) => NavBarExample(),
// //         ),
// //       );
// //     } catch (e) {
// //       setState(() {
// //         isLoading = false;
// //       });
// //       print('Error: $e');
// //     }
// //   }
//
// //   Future<void> createFamilyProfile() async {
// //     try {
// //       setState(() {
// //         isLoading = true;
// //       });
//
// //       // Upload the profile image to Firebase Storage
// //       if (widget.userProfileData['profileImage'] != null) {
// //         File imageFile = widget.userProfileData['profileImage'];
// //         String fileName = '${widget.userID}_profileImage.png';
// //         Reference storageReference =
// //             FirebaseStorage.instance.ref().child('profileImages/$fileName');
// //         UploadTask uploadTask = storageReference.putFile(imageFile);
//
// //         // Wait for the upload to complete
// //         TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//
// //         // Download the URL of the uploaded image
// //         String downloadURL = await taskSnapshot.ref.getDownloadURL();
//
// //         // Store the download URL in the userProfileData map
// //         widget.userProfileData['profileImage'] = downloadURL;
// //       }
//
// //       // Save data to Firestore
// //       await FirebaseFirestore.instance
// //           .collection('familyUser')
// //           .doc(widget.userID)
// //           .collection('userProfileData')
// //           .add(widget.userProfileData);
// //       //------------------1
// //       await FirebaseFirestore.instance
// //           .collection('familyUser')
// //           .doc(widget.userID)
// //           .collection('comorbiditiesData')
// //           .add(widget.comorbiditiesData);
// //       //-----------------2
// //       await FirebaseFirestore.instance
// //           .collection('familyUser')
// //           .doc(widget.userID)
// //           .collection('allergicMedicationsData')
// //           .add(widget.allergicMedicationsData);
// //       //-----------------3
// //       await FirebaseFirestore.instance
// //           .collection('familyUser')
// //           .doc(widget.userID)
// //           .collection('currentMedicationsData')
// //           .add(widget.currentMedicationsData);
// //       //---------------4
// //       await FirebaseFirestore.instance
// //           .collection('familyUser')
// //           .doc(widget.userID)
// //           .collection('medicalHistoryData')
// //           .add(medicalHistoryData);
// //       //---------------5
// //       await FirebaseFirestore.instance
// //           .collection('familyUser')
// //           .doc(widget.userID)
// //           .collection('surgicalHistoryData')
// //           .add(surgicalHistoryData);
//
// //       // Navigate to VerifyView
// //       Navigator.pushReplacement(
// //         context,
// //         CupertinoPageRoute(
// //           builder: (context) => NavBarExample(),
// //         ),
// //       );
// //     } catch (e) {
// //       setState(() {
// //         isLoading = false;
// //       });
// //       print('Error: $e');
// //     }
// //   }
//
// //   // Future<void> createFamilyProfile() async {
// //   //   try {
// //   //     setState(() {
// //   //       isLoading = true;
// //   //     });
// //   //     await FirebaseFirestore.instance
// //   //         .collection('familyUser')
// //   //         .doc(widget.userID)
// //   //         .collection('userProfileData')
// //   //         .add(widget.userProfileData);
// //   //     //------------------1
// //   //     await FirebaseFirestore.instance
// //   //         .collection('familyUser')
// //   //         .doc(widget.userID)
// //   //         .collection('comorbiditiesData')
// //   //         .add(widget.comorbiditiesData);
// //   //     //-----------------2
// //   //     await FirebaseFirestore.instance
// //   //         .collection('familyUser')
// //   //         .doc(widget.userID)
// //   //         .collection('allergicMedicationsData')
// //   //         .add(widget.allergicMedicationsData);
// //   //     //-----------------3
// //   //     await FirebaseFirestore.instance
// //   //         .collection('familyUser')
// //   //         .doc(widget.userID)
// //   //         .collection('currentMedicationsData')
// //   //         .add(widget.currentMedicationsData);
// //   //     //---------------4
// //   //     await FirebaseFirestore.instance
// //   //         .collection('familyUser')
// //   //         .doc(widget.userID)
// //   //         .collection('medicalHistoryData')
// //   //         .add(medicalHistoryData);
// //   //     //---------------5
// //   //     await FirebaseFirestore.instance
// //   //         .collection('familyUser')
// //   //         .doc(widget.userID)
// //   //         .collection('surgicalHistoryData')
// //   //         .add(surgicalHistoryData);
// //   //     // Navigate to VerifyView
// //   //     Navigator.pushReplacement(
// //   //       context,
// //   //       CupertinoPageRoute(
// //   //         builder: (context) => NavBarExample(),
// //   //       ),
// //   //     );
// //   //   } catch (e) {
// //   //     setState(() {
// //   //       isLoading = false;
// //   //     });
// //   //   }
// //   // }
//
// //   // Future<void> createUserProfile() async {
// //   //   try {
// //   //     setState(() {
// //   //       isLoading = true;
// //   //     });
// //   //     await FirebaseFirestore.instance
// //   //         .collection('userProfileData')
// //   //         .doc(widget.userID)
// //   //         .set(widget.userProfileData);
// //   //     //------------------1
// //   //     await FirebaseFirestore.instance
// //   //         .collection('comorbiditiesData')
// //   //         .doc(widget.userID)
// //   //         .set(widget.comorbiditiesData);
// //   //     //-----------------2
// //   //     await FirebaseFirestore.instance
// //   //         .collection('allergicMedicationsData')
// //   //         .doc(widget.userID)
// //   //         .set(widget.allergicMedicationsData);
// //   //     //-----------------3
// //   //     await FirebaseFirestore.instance
// //   //         .collection('currentMedicationsData')
// //   //         .doc(widget.userID)
// //   //         .set(widget.currentMedicationsData);
// //   //     //---------------4
// //   //     await FirebaseFirestore.instance
// //   //         .collection('medicalHistoryData')
// //   //         .doc(widget.userID)
// //   //         .set(medicalHistoryData);
// //   //     //---------------5
// //   //     await FirebaseFirestore.instance
// //   //         .collection('surgicalHistoryData')
// //   //         .doc(widget.userID)
// //   //         .set(surgicalHistoryData);
// //   //     // Navigate to VerifyView
// //   //     Navigator.pushReplacement(
// //   //       context,
// //   //       CupertinoPageRoute(
// //   //         builder: (context) => NavBarExample(),
// //   //       ),
// //   //     );
// //   //   } catch (e) {
// //   //     setState(() {
// //   //       isLoading = false;
// //   //     });
// //   //   }
// //   // }
// // }
//
// import 'package:ecare/constants/linker.dart';
//
// ///TODO:-------
// ///
// import 'dart:io';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
//
// class MedicalHistory extends StatefulWidget {
//   final String? userID;
//   final String? role;
//   final Map<String, dynamic>? userProfileData;
//   final Map<String, dynamic>? comorbiditiesData;
//   final Map<String, dynamic>? allergicMedicationsData;
//   final Map<String, dynamic>? currentMedicationsData;
//
//   MedicalHistory({
//     this.userProfileData,
//     this.role,
//     this.comorbiditiesData,
//     this.allergicMedicationsData,
//     this.currentMedicationsData,
//     this.userID,
//   });
//
//   @override
//   State<MedicalHistory> createState() => _MedicalHistoryState();
// }
//
// class _MedicalHistoryState extends State<MedicalHistory> {
//   final TextEditingController medicalHistoryController1 =
//       TextEditingController();
//   final TextEditingController medicalHistoryController2 =
//       TextEditingController();
//   final TextEditingController surgicalHistoryController1 =
//       TextEditingController();
//   final TextEditingController surgicalHistoryController2 =
//       TextEditingController();
//
//   Map<String, dynamic> medicalHistoryData = {};
//   Map<String, dynamic> surgicalHistoryData = {};
//
//   bool isLoading = false;
//
//   @override
//   void dispose() {
//     medicalHistoryController1.dispose();
//     medicalHistoryController2.dispose();
//     surgicalHistoryController1.dispose();
//     surgicalHistoryController2.dispose();
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
//             onPressed: () async {
//               // Handle skipping profile creation
//               if (widget.role == 'register') {
//                 createUserProfile();
//               } else if (widget.role == 'family') {
//                 createFamilyProfile();
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
//               BoldTextWidgetTheme(text: 'Other Medical History'),
//               SimpleTextWidgetTheme(
//                 text:
//                     'Please provide the diagnosis, year of diagnosis and treatment done if any with minimum 3 lines',
//               ),
//               LightDarktextField(
//                 controller: medicalHistoryController1,
//                 hintText: 'Medical History',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: medicalHistoryController2,
//                 hintText: 'Medical History',
//                 keyboardType: TextInputType.text,
//               ),
//               SizedBox(height: 20.0),
//               BoldTextWidgetTheme(text: 'Other Surgical History'),
//               SimpleTextWidgetTheme(
//                 text:
//                     'Please provide the diagnosis, year of diagnosis and treatment done if any with minimum 3 lines',
//               ),
//               LightDarktextField(
//                 controller: surgicalHistoryController1,
//                 hintText: 'Surgical History',
//                 keyboardType: TextInputType.text,
//               ),
//               LightDarktextField(
//                 controller: surgicalHistoryController2,
//                 hintText: 'Surgical History',
//                 keyboardType: TextInputType.text,
//               ),
//               isLoading
//                   ? AppLoading()
//                   : InkWell(
//                       onTap: () async {
//                         // Upload profile image and save data
//                         await uploadProfileImageAndSaveData();
//                       },
//                       child: BlueButton(
//                         text: 'Update',
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> uploadProfileImageAndSaveData() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//
//       // Check if profileImage exists and is a valid string
//       if (widget.userProfileData!['profileImage'] != null &&
//           widget.userProfileData!['profileImage'].isNotEmpty &&
//           widget.userProfileData!['profileImage'] is String) {
//         // Convert the image path to a File object
//         File imageFile = File(widget.userProfileData!['profileImage']);
//
//         // Get the file name
//         String fileName = path.basename(imageFile.path);
//
//         // Upload the file to Firebase Storage
//         UploadTask uploadTask = FirebaseStorage.instance
//             .ref('profileImages/$fileName')
//             .putFile(imageFile);
//
//         // Get the download URL
//         TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//         String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//         // Update the userProfileData with the download URL
//         widget.userProfileData!['profileImage'] = downloadUrl;
//       } else {
//         // If no image is received, store an empty value
//         widget.userProfileData!['profileImage'] = '';
//       }
//
//       // Collect data into maps
//       medicalHistoryData['history1'] = medicalHistoryController1.text ?? '';
//       medicalHistoryData['history2'] = medicalHistoryController2.text ?? '';
//       medicalHistoryData['userId'] = widget.userID;
//       surgicalHistoryData['surgery1'] = surgicalHistoryController1.text ?? '';
//       surgicalHistoryData['surgery2'] = surgicalHistoryController2.text ?? '';
//       surgicalHistoryData['userID'] = widget.userID;
//
//       // Save data to Firestore based on role
//       if (widget.role == 'register') {
//         await createUserProfile();
//       } else if (widget.role == 'family') {
//         await createFamilyProfile();
//       }
//     } catch (e) {
//       print('Error uploading profile image: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   // Future<void> uploadProfileImageAndSaveData() async {
//   //   try {
//   //     setState(() {
//   //       isLoading = true;
//   //     });
//
//   //     // Check if the profileImage is a file path (String)
//   //     if (widget.userProfileData['profileImage'] is String) {
//   //       // Convert to a File object
//   //       File imageFile = File(widget.userProfileData['profileImage']);
//
//   //       // Get the file name
//   //       String fileName = path.basename(imageFile.path);
//
//   //       // Upload the file to Firebase Storage
//   //       UploadTask uploadTask = FirebaseStorage.instance
//   //           .ref('profileImages/$fileName')
//   //           .putFile(imageFile);
//
//   //       // Get the download URL
//   //       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//   //       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//   //       // Update the userProfileData with the download URL
//   //       widget.userProfileData['profileImage'] = downloadUrl;
//   //     }
//
//   //     // Collect data into maps
//   //     medicalHistoryData['history1'] = medicalHistoryController1.text ?? '';
//   //     medicalHistoryData['history2'] = medicalHistoryController2.text ?? '';
//   //     medicalHistoryData['userId'] = widget.userID;
//   //     surgicalHistoryData['surgery1'] = surgicalHistoryController1.text ?? '';
//   //     surgicalHistoryData['surgery2'] = surgicalHistoryController2.text ?? '';
//   //     surgicalHistoryData['userID'] = widget.userID;
//
//   //     // Save data to Firestore based on role
//   //     if (widget.role == 'register') {
//   //       await createUserProfile();
//   //     } else if (widget.role == 'family') {
//   //       await createFamilyProfile();
//   //     }
//   //   } catch (e) {
//   //     print('Error uploading profile image: $e');
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
//
//   Future<void> createFamilyProfile() async {
//     try {
//       // Generate a random 9-digit number for userfamilyId
//       String userfamilyId =
//           (Random().nextInt(900000000) + 100000000).toString();
//
//       // Add userfamilyId to each map
//       widget.userProfileData!['userfamilyId'] = userfamilyId;
//       widget.comorbiditiesData!['userfamilyId'] = userfamilyId;
//       widget.allergicMedicationsData!['userfamilyId'] = userfamilyId;
//       widget.currentMedicationsData!['userfamilyId'] = userfamilyId;
//       medicalHistoryData['userfamilyId'] = userfamilyId;
//       surgicalHistoryData['userfamilyId'] = userfamilyId;
//
//       await FirebaseFirestore.instance
//           .collection('familyUser')
//           .doc(widget.userID)
//           .set({
//         'docId': widget.userID, // Add docId field with userID value
//       });
//
//       await FirebaseFirestore.instance
//           .collection('familyUser')
//           .doc(widget.userID)
//           .collection('userProfileData')
//           .doc(userfamilyId)
//           .set(widget.userProfileData!);
//
//       await FirebaseFirestore.instance
//           .collection('familyUser')
//           .doc(widget.userID)
//           .collection('comorbiditiesData')
//           .doc(userfamilyId)
//           .set(widget.comorbiditiesData!);
//
//       await FirebaseFirestore.instance
//           .collection('familyUser')
//           .doc(widget.userID)
//           .collection('allergicMedicationsData')
//           .doc(userfamilyId)
//           .set(widget.allergicMedicationsData!);
//
//       await FirebaseFirestore.instance
//           .collection('familyUser')
//           .doc(widget.userID)
//           .collection('currentMedicationsData')
//           .doc(userfamilyId)
//           .set(widget.currentMedicationsData!);
//
//       await FirebaseFirestore.instance
//           .collection('familyUser')
//           .doc(widget.userID)
//           .collection('medicalHistoryData')
//           .doc(userfamilyId)
//           .set(medicalHistoryData);
//
//       await FirebaseFirestore.instance
//           .collection('familyUser')
//           .doc(widget.userID)
//           .collection('surgicalHistoryData')
//           .doc(userfamilyId)
//           .set(surgicalHistoryData);
//
//       // Navigate to NavBarExample
//       Navigator.pushReplacement(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => NavBarExample(),
//         ),
//       );
//     } catch (e) {
//       print('Error creating family profile: $e');
//     }
//   }
//
//   Future<void> createUserProfile() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('userProfileData')
//           .doc(widget.userID)
//           .set(widget.userProfileData!);
//
//       await FirebaseFirestore.instance
//           .collection('comorbiditiesData')
//           .doc(widget.userID)
//           .set(widget.comorbiditiesData!);
//
//       await FirebaseFirestore.instance
//           .collection('allergicMedicationsData')
//           .doc(widget.userID)
//           .set(widget.allergicMedicationsData!);
//       await FirebaseFirestore.instance
//           .collection('currentMedicationsData')
//           .doc(widget.userID)
//           .set(widget.currentMedicationsData!);
//
//       await FirebaseFirestore.instance
//           .collection('medicalHistoryData')
//           .doc(widget.userID)
//           .set(medicalHistoryData);
//
//       await FirebaseFirestore.instance
//           .collection('surgicalHistoryData')
//           .doc(widget.userID)
//           .set(surgicalHistoryData);
//
//       // Navigate to NavBarExample
//       Navigator.pushReplacement(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => NavBarExample(),
//         ),
//       );
//     } catch (e) {
//       print('Error creating user profile: $e');
//     }
//   }
// }
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

class MedicalHistory extends StatefulWidget {
  final String? userID;
  final String? role;
  final Map<String, dynamic>? userProfileData;
  final Map<String, dynamic>? comorbiditiesData;
  final Map<String, dynamic>? allergicMedicationsData;
  final Map<String, dynamic>? currentMedicationsData;

  MedicalHistory({
    this.userProfileData,
    this.role,
    this.comorbiditiesData,
    this.allergicMedicationsData,
    this.currentMedicationsData,
    this.userID,
  });

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final TextEditingController medicalHistoryController1 =
  TextEditingController();
  final TextEditingController medicalHistoryController2 =
  TextEditingController();
  final TextEditingController surgicalHistoryController1 =
  TextEditingController();
  final TextEditingController surgicalHistoryController2 =
  TextEditingController();

  Map<String, dynamic> medicalHistoryData = {};
  Map<String, dynamic> surgicalHistoryData = {};

  bool isLoading = false;

  @override
  void dispose() {
    medicalHistoryController1.dispose();
    medicalHistoryController2.dispose();
    surgicalHistoryController1.dispose();
    surgicalHistoryController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BoldTextWidgetTheme(text: 'Create Profile'),
        actions: [
          TextButton(
            onPressed: () async {
              // Handle skipping profile creation
              if (widget.role == 'register') {
                createUserProfile();
              } else if (widget.role == 'family') {
                createFamilyProfile();
              }
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
              BoldTextWidgetTheme(text: 'Other Medical History'),
              SimpleTextWidgetTheme(
                text:
                'Please provide the diagnosis, year of diagnosis and treatment done if any with minimum 3 lines',
              ),
              LightDarktextField(
                controller: medicalHistoryController1,
                hintText: 'Medical History',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: medicalHistoryController2,
                hintText: 'Medical History',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),
              BoldTextWidgetTheme(text: 'Other Surgical History'),
              SimpleTextWidgetTheme(
                text:
                'Please provide the diagnosis, year of diagnosis and treatment done if any with minimum 3 lines',
              ),
              LightDarktextField(
                controller: surgicalHistoryController1,
                hintText: 'Surgical History',
                keyboardType: TextInputType.text,
              ),
              LightDarktextField(
                controller: surgicalHistoryController2,
                hintText: 'Surgical History',
                keyboardType: TextInputType.text,
              ),
              isLoading
                  ? AppLoading()
                  : InkWell(
                onTap: () async {
                  // Upload profile image and save data
                  await uploadProfileImageAndSaveData();
                },
                child: BlueButton(
                  text: 'Update',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> uploadProfileImageAndSaveData() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (widget.userProfileData!['profileImage'] != null &&
          widget.userProfileData!['profileImage'].isNotEmpty &&
          widget.userProfileData!['profileImage'] is String) {
        // Convert the image path to a File object
        File imageFile = File(widget.userProfileData!['profileImage']);
        Uint8List fileBytes = base64Decode(widget.userProfileData!['profileImage']);
        // Get the file name
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        // Upload the file to Firebase Storage
        UploadTask uploadTask = FirebaseStorage.instance
            .ref('profileImages/$fileName')
            .putData(fileBytes);

        // Get the download URL
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Update the userProfileData with the download URL
        widget.userProfileData!['profileImage'] = downloadUrl;
      } else {
        // If no image is received, store an empty value
        widget.userProfileData!['profileImage'] = '';
      }
      // String? downloadUrl = '';
      //
      // // Select a file using FilePicker
      // FilePickerResult? result = await FilePicker.platform.pickFiles(
      //   type: FileType.image,
      //   allowMultiple: false,
      // );
      //
      // if (result != null) {
      //   Uint8List? fileBytes = result.files.first.bytes;
      //   String fileName = result.files.first.name;
      //
      //   // Upload file to Firebase Storage
      //   UploadTask uploadTask = FirebaseStorage.instance
      //       .ref('profileImages/$fileName')
      //       .putData(fileBytes!);
      //
      //   TaskSnapshot taskSnapshot = await uploadTask;
      //   downloadUrl = await taskSnapshot.ref.getDownloadURL();
      //
      //   // Update the userProfileData with the download URL
      //   widget.userProfileData!['profileImage'] = downloadUrl;
      // } else {
      //   // If no image is selected, store an empty value
      //   widget.userProfileData!['profileImage'] = '';
      // }

      // Collect data into maps
      medicalHistoryData['history1'] = medicalHistoryController1.text;
      medicalHistoryData['history2'] = medicalHistoryController2.text;
      medicalHistoryData['userId'] = widget.userID;
      surgicalHistoryData['surgery1'] = surgicalHistoryController1.text;
      surgicalHistoryData['surgery2'] = surgicalHistoryController2.text;
      surgicalHistoryData['userID'] = widget.userID;

      // Save data to Firestore
      if (widget.role == 'register') {
        await createUserProfile();
      } else if (widget.role == 'family') {
        await createFamilyProfile();
      }
    } catch (e) {
      print('Error uploading profile image: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  Future<void> createFamilyProfile() async {
    try {
      // Generate a random 9-digit number for userfamilyId
      String userfamilyId =
      (Random().nextInt(900000000) + 100000000).toString();

      // Add userfamilyId to each map
      widget.userProfileData!['userfamilyId'] = userfamilyId;
      widget.comorbiditiesData!['userfamilyId'] = userfamilyId;
      widget.allergicMedicationsData!['userfamilyId'] = userfamilyId;
      widget.currentMedicationsData!['userfamilyId'] = userfamilyId;
      medicalHistoryData['userfamilyId'] = userfamilyId;
      surgicalHistoryData['userfamilyId'] = userfamilyId;

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .set({
        'docId': widget.userID, // Add docId field with userID value
      });

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('userProfileData')
          .doc(userfamilyId)
          .set(widget.userProfileData!);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('comorbiditiesData')
          .doc(userfamilyId)
          .set(widget.comorbiditiesData!);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('allergicMedicationsData')
          .doc(userfamilyId)
          .set(widget.allergicMedicationsData!);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('currentMedicationsData')
          .doc(userfamilyId)
          .set(widget.currentMedicationsData!);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('medicalHistoryData')
          .doc(userfamilyId)
          .set(medicalHistoryData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('surgicalHistoryData')
          .doc(userfamilyId)
          .set(surgicalHistoryData);

      // Navigate to NavBarExample
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => NavBarExample(),
        ),
      );
    } catch (e) {
      print('Error creating family profile: $e');
    }
  }

  Future<void> createUserProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection('userProfileData')
          .doc(widget.userID)
          .set(widget.userProfileData!);

      await FirebaseFirestore.instance
          .collection('comorbiditiesData')
          .doc(widget.userID)
          .set(widget.comorbiditiesData!);

      await FirebaseFirestore.instance
          .collection('allergicMedicationsData')
          .doc(widget.userID)
          .set(widget.allergicMedicationsData!);
      await FirebaseFirestore.instance
          .collection('currentMedicationsData')
          .doc(widget.userID)
          .set(widget.currentMedicationsData!);

      await FirebaseFirestore.instance
          .collection('medicalHistoryData')
          .doc(widget.userID)
          .set(medicalHistoryData);

      await FirebaseFirestore.instance
          .collection('surgicalHistoryData')
          .doc(widget.userID)
          .set(surgicalHistoryData);

      // Navigate to NavBarExample
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => NavBarExample(),
        ),
      );
    } catch (e) {
      print('Error creating user profile: $e');
    }
  }
}
