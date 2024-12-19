import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecare/views/Create-Profile-Views/combrobities.dart';
import 'package:ecare/widgets/date-field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:ecare/constants/linker.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  final String? role;

  const CreateProfileScreen({super.key, this.role});
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

// class _CreateProfileScreenState extends State<CreateProfileScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final ImagePicker _picker = ImagePicker();
//   XFile? _image;
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController primaryContactController =
//       TextEditingController();
//   final TextEditingController emergencyContact1Controller =
//       TextEditingController();
//   final TextEditingController emergencyContact2Controller =
//       TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//
//   String? selectedGender;
//   String? emergencyContact1Relation;
//   String? emergencyContact2Relation;
//   String? selectedBloodGroup;
//
//   String userID = '';
//   String useremail = '';
//   fetchUser() async {
//     User? userData = await FirebaseAuth.instance.currentUser;
//     userID = userData!.uid;
//     useremail = userData!.email!;
//   }
//
//   Map<String, dynamic> userProfileData = {};
//
//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = pickedFile;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUser();
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         dateController.text = DateFormat('dd/MM/yyyy').format(picked);
//       });
//     }
//   }
//
//   void _storeUserData() {
//     if (_formKey.currentState?.validate() ?? false) {
//       userProfileData['name'] =
//           nameController.text.isNotEmpty ? nameController.text : '';
//       userProfileData['primaryContact'] =
//           primaryContactController.text.isNotEmpty
//               ? primaryContactController.text
//               : '';
//       userProfileData['emergencyContact1'] =
//           emergencyContact1Controller.text.isNotEmpty
//               ? emergencyContact1Controller.text
//               : '';
//       userProfileData['relation1'] = emergencyContact1Relation ?? '';
//       userProfileData['emergencyContact2'] =
//           emergencyContact2Controller.text.isNotEmpty
//               ? emergencyContact2Controller.text
//               : '';
//       userProfileData['relation2'] = emergencyContact2Relation ?? '';
//       userProfileData['gender'] = selectedGender ?? '';
//       userProfileData['bloodGroup'] = selectedBloodGroup ?? '';
//       userProfileData['dateOfBirth'] =
//           dateController.text.isNotEmpty ? dateController.text : '';
//       userProfileData['profileImage'] = _image?.path ?? '';
//       userProfileData['userId'] = userID;
//       userProfileData['email'] = useremail;
//       userProfileData['refferId'] = _generateRandomCode();
//
//       FirebaseFirestore.instance
//           .collection('Users')
//           .doc(userID)
//           .set(userProfileData)
//           .then((value) {
//         print("User Profile Data Stored Successfully");
//       }).catchError((error) {
//         print("Failed to store user profile data: $error");
//       });
//
//       Navigator.push(
//         context,
//         CupertinoDialogRoute(
//             builder: (context) => ComorbitiesView(
//                   role: widget.role,
//                   userProfileData: userProfileData,
//                   userID: userID,
//                 ),
//             context: context),
//       );
//     }
//   }
//
//   String _generateRandomCode() {
//     const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//     const numbers = '0123456789';
//     Random random = Random();
//
//     String randomDigits =
//         List.generate(4, (index) => numbers[random.nextInt(10)]).join();
//     String randomAlphabets =
//         List.generate(3, (index) => letters[random.nextInt(26)]).join();
//
//     return randomDigits + randomAlphabets;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final isWideScreen = screenSize.width > 800;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Center(
//               child: Container(
//                 width: isWideScreen ? 600 : double.infinity, // Responsive width
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 20.0),
//                     BoldTextWidgetTheme(text: 'Create Profile'),
//                     SizedBox(height: 20.0),
//                     GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         width: isWideScreen ? 150.0 : 100.0,
//                         height: isWideScreen ? 150.0 : 100.0,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).secondaryHeaderColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             if (_image != null)
//                               ClipOval(
//                                 child: Image.file(
//                                   File(_image!.path),
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                             else
//                               Icon(
//                                 Icons.camera_alt,
//                                 color: Theme.of(context).primaryIconTheme.color,
//                                 size: isWideScreen ? 60.0 : 40.0,
//                               ),
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: IconButton(
//                                 icon: Icon(Icons.add_a_photo),
//                                 onPressed: _pickImage,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     LightDarktextField(
//                       keyboardType: TextInputType.text,
//                       controller: nameController,
//                       hintText: 'Full Name',
//                     ),
//                     LightDarktextField(
//                       controller: primaryContactController,
//                       hintText: 'Primary Contact Number',
//                       keyboardType: TextInputType.phone,
//                     ),
//                     LightDarktextField(
//                       controller: emergencyContact1Controller,
//                       hintText: 'Emergency Contact Number 1',
//                       keyboardType: TextInputType.phone,
//                     ),
//                     LighDarkDropDown(
//                       hint: 'Emergency contact 1 belongs to...',
//                       items: [
//                         'Grand Mother',
//                         'Grand Father',
//                         'Brother',
//                         'Father',
//                         'Friend',
//                         'Mother',
//                         'Son',
//                         'Husband',
//                         'Wife',
//                         'Daughter',
//                         'Sister'
//                       ],
//                       value: emergencyContact1Relation,
//                       onChanged: (value) {
//                         setState(() {
//                           emergencyContact1Relation = value;
//                         });
//                       },
//                     ),
//                     LightDarktextField(
//                       controller: emergencyContact2Controller,
//                       hintText: 'Emergency Contact Number 2',
//                       keyboardType: TextInputType.phone,
//                     ),
//                     LighDarkDropDown(
//                       hint: 'Emergency contact 2 belongs to...',
//                       items: [
//                         'Grand Mother',
//                         'Grand Father',
//                         'Brother',
//                         'Father',
//                         'Friend',
//                         'Mother',
//                         'Son',
//                         'Husband',
//                         'Wife',
//                         'Daughter',
//                         'Sister'
//                       ],
//                       value: emergencyContact2Relation,
//                       onChanged: (value) {
//                         setState(() {
//                           emergencyContact2Relation = value;
//                         });
//                       },
//                     ),
//                     LighDarkDropDown(
//                       hint: 'Blood Group',
//                       items: [
//                         'UnKnown',
//                         'O Positive',
//                         'O Negative',
//                         'A Negative',
//                         'AB Negative',
//                         'B Negative',
//                         'B Positive',
//                         'A Positive',
//                         'AB Positive'
//                       ],
//                       value: selectedBloodGroup,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedBloodGroup = value;
//                         });
//                       },
//                     ),
//                     LighDarkDropDown(
//                       hint: 'Gender',
//                       items: ['Male', 'Female', 'Other'],
//                       value: selectedGender,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedGender = value;
//                         });
//                       },
//                     ),
//                     LightDarkDateField(
//                       controller: dateController,
//                       hintText: 'Date of Birth',
//                       onTap: _selectDate,
//                     ),
//                     SizedBox(height: 20.0),
//                     InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             CupertinoDialogRoute(
//                                 builder: (context) => ComorbitiesView(
//                                       role: widget.role,
//                                       userProfileData: userProfileData,
//                                       userID: userID,
//                                     ),
//                                 context: context),
//                           );
//                           // _storeUserData();
//                         },
//                         child: BlueButton(text: 'Next')),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

///-------Fully worked with web during debug
class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController primaryContactController =
      TextEditingController();
  final TextEditingController emergencyContact1Controller =
      TextEditingController();
  final TextEditingController emergencyContact2Controller =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? selectedGender;
  String? emergencyContact1Relation;
  String? emergencyContact2Relation;
  String? selectedBloodGroup;

  String userID = '';
  String useremail = '';
  fetchUser() async {
    User? userData = await FirebaseAuth.instance.currentUser;
    userID = userData!.uid;
    useremail = userData!.email!;
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Map<String, dynamic> userProfileData = {};

  String imagePath = ''; // To store Base64 string
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Convert the file to Base64
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _image = pickedFile;
          imagePath = base64Encode(bytes); // Save as Base64 string
        });
        print('Image successfully selected and converted to Base64.');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _storeUserData() {
    if (_formKey.currentState?.validate() ?? false) {
      // Storing profile data into the userProfileData map
      userProfileData['name'] =
          nameController.text.isNotEmpty ? nameController.text : '';
      userProfileData['primaryContact'] =
          primaryContactController.text.isNotEmpty
              ? primaryContactController.text
              : '';
      userProfileData['emergencyContact1'] =
          emergencyContact1Controller.text.isNotEmpty
              ? emergencyContact1Controller.text
              : '';
      userProfileData['relation1'] = emergencyContact1Relation != null
          ? emergencyContact1Relation
          : ''; // Store empty if not selected
      userProfileData['emergencyContact2'] =
          emergencyContact2Controller.text.isNotEmpty
              ? emergencyContact2Controller.text
              : '';
      userProfileData['relation2'] = emergencyContact2Relation != null
          ? emergencyContact2Relation
          : ''; // Store empty if not selected

      userProfileData['gender'] = selectedGender != null
          ? selectedGender
          : ''; // Store empty if not selected
      userProfileData['bloodGroup'] = selectedBloodGroup != null
          ? selectedBloodGroup
          : ''; // Store empty if not selected
      userProfileData['dateOfBirth'] =
          dateController.text.isNotEmpty ? dateController.text : '';
      userProfileData['profileImage'] =
          //_image?.path
          imagePath ?? ''; // Store empty if no image is selected
      userProfileData['userId'] = userID;
      userProfileData['email'] =
          useremail; // Adding the user email to the data map for reference
      userProfileData['refferId'] = _generateRandomCode();

      print('User Profile Data: $userProfileData'); // Print the map values

      // Store the data in Firestore
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userID)
          .set(userProfileData)
          .then((value) {
        print("User Profile Data Stored Successfully");
      }).catchError((error) {
        print("Failed to store user profile data: $error");
      });

      // Navigate to the next screen
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ComorbitiesView(
                  role: widget.role,
                  userProfileData: userProfileData,
                  userID: userID,
                )),
      );
    }
  }

  String _generateRandomCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    Random random = Random();

    // Generate 4 random digits
    String randomDigits =
        List.generate(4, (index) => numbers[random.nextInt(10)]).join();
    // Generate 3 random alphabets
    String randomAlphabets =
        List.generate(3, (index) => letters[random.nextInt(26)]).join();

    // Combine them into a 6-character string
    return randomDigits + randomAlphabets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                BoldTextWidgetTheme(text: 'Create Profile'),
                SizedBox(height: 20.0),
                _buildProfileImage(),
                SizedBox(height: 20.0),
                LightDarktextField(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  hintText: 'Full Name',
                ),
                LightDarktextField(
                  controller: primaryContactController,
                  hintText: 'Primary Contact Number',
                  keyboardType: TextInputType.phone,
                  labelText: 'Emergency Contact 2',
                ),
                LightDarktextField(
                  labelText:
                      'Emergency Contact 2', // Label provided, validation enabled
                  controller: emergencyContact1Controller,
                  hintText: 'Emergency Contact Number 1',
                  keyboardType: TextInputType.phone,
                ),
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
                LightDarktextField(
                  labelText:
                      'Emergency Contact 2', // Label provided, validation enabled
                  controller: emergencyContact2Controller,
                  hintText: 'Emergency Contact Number 2',
                  keyboardType: TextInputType.phone,
                ),
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
                LightDarkDateField(
                  controller: dateController,
                  hintText: 'Date of Birth',
                  onTap: _selectDate,
                ),
                SizedBox(height: 20.0),
                InkWell(
                    onTap: () {
                      _storeUserData();
                    },
                    child: BlueButton(text: 'Next')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          shape: BoxShape.circle,
        ),
        child: _image != null
            ? (kIsWeb
                ? ClipOval(
                    child: Image.network(
                      _image!.path, // Use the path as URL for web
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipOval(
                    child: Image.file(
                      File(_image!.path), // Use the file for mobile
                      fit: BoxFit.cover,
                    ),
                  ))
            : Icon(
                Icons.camera_alt,
                color: Theme.of(context).primaryIconTheme.color,
                size: 40.0,
              ),
      ),
    );
  }
}
