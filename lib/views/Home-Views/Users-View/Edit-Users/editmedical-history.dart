import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:ecare/constants/linker.dart';

class EditMedicalHistory extends StatefulWidget {
  final String role;
  final String userID;
  final Map<String, dynamic> userProfileData;
  final Map<String, dynamic> allergicMedicationsData;
  final Map<String, dynamic> comorbiditiesData;
  final Map<String, dynamic> currentMedicationsData;
  final Map<String, dynamic> medicalHistoryData;
  final Map<String, dynamic> surgicalHistoryData;
  String? familyId;

  EditMedicalHistory({
    required this.userProfileData,
    required this.userID,
    this.familyId,
    required this.role,
    required this.allergicMedicationsData,
    required this.comorbiditiesData,
    required this.currentMedicationsData,
    required this.medicalHistoryData,
    required this.surgicalHistoryData,
  });

  @override
  State<EditMedicalHistory> createState() => _EditMedicalHistoryState();
}

class _EditMedicalHistoryState extends State<EditMedicalHistory> {

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
  void initState() {
    // TODO: implement initState
    super.initState();
    //userfamilyIdfield = widget.familyId;
    print('=-=-=-=-=-=-=-=-=-=-=-=-userfamilyIdfield======${widget.familyId}');
    print('Medical History Data:${widget.medicalHistoryData}');
    print('Surgical History Data:${widget.surgicalHistoryData}');
    print(
        '------------------------------------------------------------------------');
    medicalHistoryController1.text =
        widget.medicalHistoryData['history1'] ?? '';
    medicalHistoryController2.text =
        widget.medicalHistoryData['history2'] ?? '';

    surgicalHistoryController1.text =
        widget.medicalHistoryData['surgery1'] ?? '';
    surgicalHistoryController2.text =
        widget.medicalHistoryData['surgery2'] ?? '';
  }

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
        title: BoldTextWidgetTheme(text: 'Edit Profile'),
        // actions: [
        //   TextButton(
        //     onPressed: () async {
        //       // Handle skipping profile creation
        //       if (widget.role == 'register') {
        //         createUserProfile();
        //       } else if (widget.role == 'family') {
        //         createFamilyProfile();
        //       }
        //     },
        //     child: Text(
        //       'Skip',
        //       style: TextStyle(color: Colors.blueAccent.shade700),
        //     ),
        //   ),
        // ],
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
                  ? CircularProgressIndicator()
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

      if (widget.userProfileData['profileImage'] != null &&
          widget.userProfileData['profileImage'].isNotEmpty) {
        File imageFile = File(widget.userProfileData['profileImage']);

        if (imageFile.existsSync()) {
          String fileName = path.basename(imageFile.path);

          UploadTask uploadTask = FirebaseStorage.instance
              .ref('EditprofileImages/$fileName')
              .putFile(imageFile);

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();

          widget.userProfileData['profileImage'] = downloadUrl;
        } else {
          print('File does not exist at path: ${imageFile.path}');
          // Handle the file not existing
        }
      }

      // Continue with saving data to Firestore...
      medicalHistoryData['history1'] = medicalHistoryController1.text ?? '';
      medicalHistoryData['history2'] = medicalHistoryController2.text ?? '';
      medicalHistoryData['userId'] = widget.userID;
      surgicalHistoryData['surgery1'] = surgicalHistoryController1.text ?? '';
      surgicalHistoryData['surgery2'] = surgicalHistoryController2.text ?? '';

      if (widget.role == 'admin') {
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

  // Future<void> uploadProfileImageAndSaveData() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });

  //     // Check if the profileImage is a file path (String)
  //     if (widget.userProfileData['profileImage'] is String) {
  //       // Convert to a File object
  //       File imageFile = File(widget.userProfileData['profileImage']);

  //       // Get the file name
  //       String fileName = path.basename(imageFile.path);

  //       // Upload the file to Firebase Storage
  //       UploadTask uploadTask = FirebaseStorage.instance
  //           .ref('profileImages/$fileName')
  //           .putFile(imageFile);

  //       // Get the download URL
  //       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
  //       String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  //       // Update the userProfileData with the download URL
  //       widget.userProfileData['profileImage'] = downloadUrl;
  //     }

  //     // Collect data into maps
  //     medicalHistoryData['history1'] = medicalHistoryController1.text ?? '';
  //     medicalHistoryData['history2'] = medicalHistoryController2.text ?? '';
  //     medicalHistoryData['userId'] = widget.userID;
  //     surgicalHistoryData['surgery1'] = surgicalHistoryController1.text ?? '';
  //     surgicalHistoryData['surgery2'] = surgicalHistoryController2.text ?? '';
  //    // surgicalHistoryData['userID'] = widget.userID;

  //     // Save data to Firestore based on role
  //     if (widget.role == 'register') {
  //       await createUserProfile();
  //     } else if (widget.role == 'family') {
  //       await createFamilyProfile();
  //     }
  //   } catch (e) {
  //     print('Error uploading profile image: $e');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> createFamilyProfile() async {
    try {
      // Generate a random 9-digit number for userfamilyId

      // Add userfamilyId to each map
      widget.userProfileData['userfamilyId'] = widget.familyId;
      widget.comorbiditiesData['userfamilyId'] = widget.familyId;
      widget.allergicMedicationsData['userfamilyId'] = widget.familyId;
      widget.currentMedicationsData['userfamilyId'] = widget.familyId;
      medicalHistoryData['userfamilyId'] = widget.familyId;
      surgicalHistoryData['userfamilyId'] = widget.familyId;
      print('--------------------------------------------------------------');
      print('user profile:${widget.userProfileData}');
      print('combordities:${widget.comorbiditiesData}');
      print('allergic medicaitions:${widget.allergicMedicationsData}');
      print('medicalhistory data:${widget.medicalHistoryData}');
      print('surgical history Data:${widget.surgicalHistoryData}');
      print('---------------------------------------------------');
      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('userProfileData')
          .doc(widget.familyId)
          .update(widget.userProfileData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('comorbiditiesData')
          .doc(widget.familyId)
          .update(widget.comorbiditiesData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('allergicMedicationsData')
          .doc(widget.familyId)
          .update(widget.allergicMedicationsData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('currentMedicationsData')
          .doc(widget.familyId)
          .update(widget.currentMedicationsData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('medicalHistoryData')
          .doc(widget.familyId)
          .update(medicalHistoryData);

      await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(widget.userID)
          .collection('surgicalHistoryData')
          .doc(widget.familyId)
          .update(surgicalHistoryData);

      // Navigate to NavBarExample
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => NavBarExample(),
        ),
      );
    } catch (e) {
      print('--------------------------------------------------------------');
      print('user profile:${widget.userProfileData}');
      print('combordities:${widget.comorbiditiesData}');
      print('allergic medicaitions:${widget.allergicMedicationsData}');
      print('medicalhistory data:${widget.medicalHistoryData}');
      print('surgical history Data:${widget.surgicalHistoryData}');
      print('User ID:${widget.userID}');
      print('Family ID:${widget.familyId}');
      print('---------------------------------------------------');
      print('Error creating family profile: $e,Role:${widget.role}');
    }
  }

  Future<void> createUserProfile() async {
    try {
      print(widget.userID);

      await FirebaseFirestore.instance
          .collection('userProfileData')
          .doc(widget.userID)
          .update(widget.userProfileData);

      await FirebaseFirestore.instance
          .collection('comorbiditiesData')
          .doc(widget.userID)
          .update(widget.comorbiditiesData);

      await FirebaseFirestore.instance
          .collection('allergicMedicationsData')
          .doc(widget.userID)
          .update(widget.allergicMedicationsData);

      await FirebaseFirestore.instance
          .collection('currentMedicationsData')
          .doc(widget.userID)
          .update(widget.currentMedicationsData);

      await FirebaseFirestore.instance
          .collection('medicalHistoryData')
          .doc(widget.userID)
          .update(medicalHistoryData);

      await FirebaseFirestore.instance
          .collection('surgicalHistoryData')
          .doc(widget.userID)
          .update(surgicalHistoryData);

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
