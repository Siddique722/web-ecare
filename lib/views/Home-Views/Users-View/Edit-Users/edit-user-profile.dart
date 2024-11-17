import 'dart:io';
import 'package:ecare/views/Home-Views/Users-View/Edit-Users/edit-combrobities.dart';
import 'package:ecare/widgets/date-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:ecare/constants/linker.dart';

class UpdateScreen extends StatefulWidget {
  String role;
  String userid;
  String? familyId;
  final Map<String, dynamic> userData;
  final Map<String, dynamic> allergicMedicationsData;
  final Map<String, dynamic> comorbiditiesData;
  final Map<String, dynamic> currentMedicationsData;
  final Map<String, dynamic> medicalHistoryData;
  final Map<String, dynamic> surgicalHistoryData;

  UpdateScreen({
    Key? key,
    this.familyId,
    required this.userid,
    required this.role,
    required this.userData,
    required this.allergicMedicationsData,
    required this.comorbiditiesData,
    required this.currentMedicationsData,
    required this.medicalHistoryData,
    required this.surgicalHistoryData,
  }) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  XFile? _image;
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  String emergenct1belongs = '';
  String emergenct2belongs = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController primaryContactController =
      TextEditingController();
  final TextEditingController emergencyContact1Controller =
      TextEditingController();
  final TextEditingController emergencyContact2Controller =
      TextEditingController();
  late TextEditingController dateController;

  String? selectedGender;
  String? selectedBloodGroup;
  String? selectedItem;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with the data from the previous screen
    //_image = widget.userData['profileImage'] ?? '';
    print(
        'familyId==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-${widget.familyId}');
    print('Image PAth:${widget.userData['profileImage']}');
    nameController.text = widget.userData['name'] ?? '';
    primaryContactController.text = widget.userData['primaryContact'] ?? '';
    emergencyContact1Controller.text =
        widget.userData['emergencyContact1'] ?? '';
    emergencyContact2Controller.text =
        widget.userData['emergencyContact2'] ?? '';
    emergenct1belongs = widget.userData['relation1'] ?? '';
    emergenct2belongs = widget.userData['relation2'] ?? '';
    emergencyContact1Relation = widget.userData['relation1'] ?? '';
    emergencyContact2Relation = widget.userData['relation2'] ?? '';
    selectedGender = widget.userData['gender'] ?? 'Other';
    selectedBloodGroup = widget.userData['bloodGroup'] ?? 'UnKnown';
    dateController =
        TextEditingController(text: widget.userData['dateOfBirth'] ?? '');
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  String? emergencyContact1Relation;
  String? emergencyContact2Relation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!.path))
                          : NetworkImage(widget.userData['profileImage']),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Full Name Field
              Text('Full Name'),
              LightDarktextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                hintText: 'Full Name',
              ),
              SizedBox(height: 10),

              // Primary Contact Number Field
              Text('Primary Contact Number'),
              LightDarktextField(
                controller: primaryContactController,
                hintText: 'Primary Contact Number',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),

              // Emergency Contact 1 Field
              Text('Emergency Contact 1'),
              LightDarktextField(
                controller: emergencyContact1Controller,
                hintText: 'Emergency Contact 1',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),

              // Emergency Contact 2 Field
              Text('Emergency Contact 2'),
              LightDarktextField(
                controller: emergencyContact2Controller,
                hintText: 'Emergency Contact 2',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              Text('Emergency Contact 1 belongs to...'), //$emergenct1belongs'),
              LighDarkDropDown(
                hint: 'Emergency contact 1 belongs to...',
                items: [
                  'Grand Mother',
                  'Grand Father',
                  'Brother',
                  'Father',
                  'Friend',
                  'Mother',
                  'Son',
                  'Husband',
                  'Wife',
                  'Daughter',
                  'Sister'
                ],
                value: emergencyContact1Relation,
                onChanged: (value) {
                  setState(() {
                    emergencyContact1Relation = value;
                  });
                },
              ),

              Text('Emergency Contact 2 belongs to...'),
              LighDarkDropDown(
                hint: 'Emergency contact 2 belongs to...',
                items: [
                  'Grand Mother',
                  'Grand Father',
                  'Brother',
                  'Father',
                  'Friend',
                  'Mother',
                  'Son',
                  'Husband',
                  'Wife',
                  'Daughter',
                  'Sister'
                ],
                value: emergencyContact2Relation,
                onChanged: (value) {
                  setState(() {
                    emergencyContact2Relation = value;
                  });
                },
              ),
              // Gender Dropdown
              Text('Gender'),
              LighDarkDropDown(
                hint: 'Gender',
                items: ['Male', 'Female', 'Other'],
                value: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // Blood Group Dropdown
              Text('Blood Group'),
              LighDarkDropDown(
                hint: 'Blood Group',
                items: [
                  'UnKnown',
                  'O Positive',
                  'O Negative',
                  'A Negative',
                  'AB Negative',
                  'B Negative',
                  'B Positive',
                  'A Positive',
                  'AB Positive'
                ],
                value: selectedBloodGroup,
                onChanged: (value) {
                  setState(() {
                    selectedBloodGroup = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // Date of Birth Field
              Text('Date of Birth'),
              LightDarkDateField(
                controller: dateController,
                hintText: 'Date of Birth',
                onTap: _selectDate,
              ),
              SizedBox(height: 20),

              // Next Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap: _submitData, child: BlueButton(text: 'Next')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Edit Profile'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             // Existing data fields
  //             GestureDetector(
  //               onTap: _pickImage,
  //               child: CircleAvatar(
  //                 radius: 50,
  //                 backgroundImage: _image != null
  //                     ? FileImage(File(_image!.path))
  //                     : NetworkImage(widget.userData['profileImage']),
  //               ),
  //             ),
  //             LightDarktextField(
  //               keyboardType: TextInputType.text,
  //               controller: nameController,
  //               hintText: 'Full Name',
  //             ),
  //             LightDarktextField(
  //               controller: primaryContactController,
  //               hintText: 'Primary Contact Number',
  //               keyboardType: TextInputType.phone,
  //             ),
  //             LightDarktextField(
  //               controller: emergencyContact1Controller,
  //               hintText: 'Emergency Contact 1',
  //               keyboardType: TextInputType.phone,
  //             ),
  //             LightDarktextField(
  //               controller: emergencyContact2Controller,
  //               hintText: 'Emergency Contact 2',
  //               keyboardType: TextInputType.phone,
  //             ),
  //             LighDarkDropDown(
  //               hint: 'Gender',
  //               items: ['Male', 'Female', 'Other'],
  //               value: selectedGender,
  //               onChanged: (value) {
  //                 setState(() {
  //                   selectedGender = value;
  //                 });
  //               },
  //             ),
  //             LighDarkDropDown(
  //               hint: 'Blood Group',
  //               items: [
  //                 'UnKnown',
  //                 'O Positive',
  //                 'O Negative',
  //                 'A Negative',
  //                 'AB Negative',
  //                 'B Negative',
  //                 'B Positive',
  //                 'A Positive',
  //                 'AB Positive'
  //               ],
  //               value: selectedBloodGroup,
  //               onChanged: (value) {
  //                 setState(() {
  //                   selectedBloodGroup = value;
  //                 });
  //               },
  //             ),
  //             SizedBox(height: 10.h),
  //             // Static Dropdown List
  //             LightDarkDateField(
  //               controller: dateController,
  //               hintText: 'Date of Birth',
  //               onTap: _selectDate,
  //             ),
  //             InkWell(onTap: _submitData, child: BlueButton(text: 'Next'))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _submitData() {
    final updatedUserData = {
      'name': nameController.text,
      'primaryContact': primaryContactController.text,
      'emergencyContact1': emergencyContact1Controller.text,
      'emergencyContact2': emergencyContact2Controller.text,
      'gender': selectedGender,
      'bloodGroup': selectedBloodGroup,
      'dateOfBirth': dateController.text,
      'profileImage':
          _image != null ? _image!.path : widget.userData['profileImage'],
    };
    // print('comorbiditiesData:${widget.comorbiditiesData}');
    // print('allergicMedicationsData:${widget.allergicMedicationsData}');
    // print('currentMedicationsData:${widget.currentMedicationsData}');
    // print('medicalHistoryData:${widget.medicalHistoryData}');
    // print('surgicalHistoryData:${widget.comorbiditiesData}');
    print('User ID:${widget.userid}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditComorbiditiesView(
          userProfileData: updatedUserData,
          familyId: widget.familyId,
          userID: widget.userid, // Pass userID if available
          role: widget.role, // Pass appropriate role
          allergicMedicationsData: widget.allergicMedicationsData,
          comorbiditiesData: widget.comorbiditiesData,
          currentMedicationsData: widget.currentMedicationsData,
          medicalHistoryData: widget.medicalHistoryData,
          surgicalHistoryData: widget.surgicalHistoryData,
        ),
      ),
    );
  }
}
