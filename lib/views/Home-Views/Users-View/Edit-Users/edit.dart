import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditUserScreen extends StatefulWidget {
  String role;
  final String image;
  final String gender;
  final String primary;
  final String emergencyContact1;
  final String emergencyContact2;
  final String name;
  final String bloodGroup;
  final String dateOfBirth;
  final Map<String, dynamic> allergicMedicationsData;
  final Map<String, dynamic> comorbiditiesData;
  final Map<String, dynamic> currentMedicationsData;
  final Map<String, dynamic> medicalHistoryData;
  final Map<String, dynamic> surgicalHistoryData;

  EditUserScreen({
    Key? key,
    required this.role,
    required this.image,
    required this.gender,
    required this.primary,
    required this.emergencyContact1,
    required this.emergencyContact2,
    required this.name,
    required this.bloodGroup,
    required this.dateOfBirth,
    required this.allergicMedicationsData,
    required this.comorbiditiesData,
    required this.currentMedicationsData,
    required this.medicalHistoryData,
    required this.surgicalHistoryData,
  }) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  File? _imageFile;
  String? _selectedGender;
  String? _selectedBloodGroup;
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _bloodGroups = [
    'Unknown',
    'O Positive',
    'O Negative',
    'A Negative',
    'AB Negative',
    'B Negative',
    'B Positive',
    'A Positive',
    'AB Positive'
  ];
  final List<String> _comorbidities = [
    'History of stroke/hemorrhage',
    'Thyroid disease',
    'Liver disease',
    'Cancer',
    'Hypertension',
    'Pancreatic disease',
    'Kidney disease',
    'Cardiac disease',
    'Diabetes',
    'Dyslipidemia (cholesterol)'
  ];

  late Map<String, String?> _selectedComorbidities;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _primaryContactController =
      TextEditingController();
  final TextEditingController _emergencyContact1Controller =
      TextEditingController();
  final TextEditingController _emergencyContact2Controller =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  bool _isLoading = false; // Loading state
  final TextEditingController _allergicMedicationsController =
      TextEditingController();
  final TextEditingController _currentMedicationsController =
      TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _surgicalHistoryController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender.isNotEmpty ? widget.gender : null;
    _selectedBloodGroup =
        widget.bloodGroup.isNotEmpty ? widget.bloodGroup : null;

    // Initialize selected comorbidities map
    _selectedComorbidities = {
      for (var key in _comorbidities) key: widget.comorbiditiesData[key] ?? null
    };

    // Initialize text controllers with existing values
    _nameController.text = widget.name;
    _primaryContactController.text = widget.primary;
    _emergencyContact1Controller.text = widget.emergencyContact1;
    _emergencyContact2Controller.text = widget.emergencyContact2;
    _dateOfBirthController.text = widget.dateOfBirth;

    // Initialize new text controllers with existing map values
    _allergicMedicationsController.text =
        widget.allergicMedicationsData.values.join(', ');
    _currentMedicationsController.text =
        widget.currentMedicationsData.values.join(', ');
    _medicalHistoryController.text =
        widget.medicalHistoryData.values.join(', ');
    _surgicalHistoryController.text =
        widget.surgicalHistoryData.values.join(', ');
  }

  Future<void> _saveFamily() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(
        msg: "User not logged in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      return;
    }

    String? profileImageUrl = widget.image; // Default to the current image URL

    try {
      if (_imageFile != null) {
        // If a new image is selected, upload it to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child(
            'familyUser/${user.uid}/${DateTime.now().millisecondsSinceEpoch}');
        final uploadTask = storageRef.putFile(_imageFile!);
        final snapshot = await uploadTask;
        profileImageUrl = await snapshot.ref.getDownloadURL();
      }

      // Get the latest values from text fields and dropdowns
      final name = _nameController.text.trim();
      final primaryContact = _primaryContactController.text.trim();
      final emergencyContact1 = _emergencyContact1Controller.text.trim();
      final emergencyContact2 = _emergencyContact2Controller.text.trim();
      final dateOfBirth = _dateOfBirthController.text.trim();

      // Prepare the data to be updated in Firestore
      final dataToUpdate = {
        'profileImage': profileImageUrl ?? '',
        'name': name,
        'gender': _selectedGender ?? '',
        'primaryContact': primaryContact,
        'emergencyContact1': emergencyContact1,
        'emergencyContact2': emergencyContact2,
        'bloodGroup': _selectedBloodGroup ?? '',
        'dateOfBirth': dateOfBirth,
        'comorbidities': _selectedComorbidities,
        // Add other fields here as needed
      };

      // Query the document based on userID
      final querySnapshot = await FirebaseFirestore.instance
          .collection('familyUser')
          .doc(user.uid)
          .collection('userProfileData')
          .where('name',
              isEqualTo: widget
                  .name) // Ensure 'name' is unique or use a unique identifier
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference
        final docRef = querySnapshot.docs.first.reference;

        // Print data to be updated
        print('Data to be updated: $dataToUpdate');

        // Update the Firestore document
        await docRef.update(dataToUpdate);

        // Show success toast
        Fluttertoast.showToast(
          msg: "Data updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        print('Data updated successfully');
      } else {
        // Show error toast if user profile not found
        Fluttertoast.showToast(
          msg: "User profile not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        print('User profile not found');
      }
    } catch (e) {
      // Show error toast on exception
      Fluttertoast.showToast(
        msg: "Error saving data: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print('Error saving data: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      //Navigator.pop(context, true);
      Navigator.of(context).pop(true); // Go back to the previous screen
    }
  }

  Future<void> _saveData() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(
        msg: "User not logged in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      return;
    }

    String? profileImageUrl = widget.image; // Default to the current image URL

    try {
      if (_imageFile != null) {
        // If a new image is selected, upload it to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('userProfileImages/${user.uid}');
        final uploadTask = storageRef.putFile(_imageFile!);
        final snapshot = await uploadTask;
        profileImageUrl = await snapshot.ref.getDownloadURL();
      }

      // Get the latest values from text fields and dropdowns
      String name = _nameController.text;
      String primaryContact = _primaryContactController.text;
      String emergencyContact1 = _emergencyContact1Controller.text;
      String emergencyContact2 = _emergencyContact2Controller.text;
      String dateOfBirth = _dateOfBirthController.text;

      // Prepare the data to be updated in Firestore
      final dataToUpdate = {
        'profileImage': profileImageUrl ?? '',
        'name': name,
        'gender': _selectedGender ?? '',
        'primaryContact': primaryContact,
        'emergencyContact1': emergencyContact1,
        'emergencyContact2': emergencyContact2,
        'bloodGroup': _selectedBloodGroup ?? '',
        'dateOfBirth': dateOfBirth,
        'comorbidities': _selectedComorbidities,
        // Add other fields here as needed
      };

      // Query the document based on userID
      final querySnapshot = await FirebaseFirestore.instance
          .collection('userProfileData')
          .where('userId', isEqualTo: user.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference
        final docRef = querySnapshot.docs.first.reference;

        // Print data to be updated
        print('Data to be updated: $dataToUpdate');

        // Update the Firestore document
        await docRef.update(dataToUpdate);

        // Show success toast
        Fluttertoast.showToast(
          msg: "Data updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        print('Data updated successfully');
      } else {
        // Show error toast if user profile not found
        Fluttertoast.showToast(
          msg: "User profile not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        print('User profile not found');
      }
    } catch (e) {
      // Show error toast on exception
      Fluttertoast.showToast(
        msg: "Error saving data: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print('Error saving data: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      Navigator.pop(context, true);
      // Navigator.of(context).pop(); // Go back to the previous screen
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Details'),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: widget.role == 'family' ? _saveFamily : _saveData,
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueAccent.shade700),
                  )
                : Text(
                    'Save',
                    style: TextStyle(color: Colors.blueAccent.shade700),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : widget.image.isNotEmpty
                        ? NetworkImage(widget.image)
                        : null,
                radius: 50,
                child: _imageFile == null && widget.image.isEmpty
                    ? Icon(Icons.camera_alt, size: 50, color: Colors.grey[800])
                    : null,
                onBackgroundImageError: (exception, stackTrace) {
                  print('Error loading image: $exception');
                },
              ),
            ),
            SizedBox(height: 16),
            _buildTextField('Name', _nameController),
            _buildDropdown('Gender', _genders, _selectedGender, (value) {
              setState(() {
                _selectedGender = value;
              });
            }),
            _buildTextField('Primary Contact', _primaryContactController),
            _buildTextField(
                'Emergency Contact 1', _emergencyContact1Controller),
            _buildTextField(
                'Emergency Contact 2', _emergencyContact2Controller),
            _buildDropdown('Blood Group', _bloodGroups, _selectedBloodGroup,
                (value) {
              setState(() {
                _selectedBloodGroup = value;
              });
            }),
            _buildTextField('Date of Birth', _dateOfBirthController),
            _buildTextField(
                'Allergic Medications', _allergicMedicationsController),
            _buildTextField(
                'Current Medications', _currentMedicationsController),
            _buildTextField('Medical History', _medicalHistoryController),
            _buildTextField('Surgical History', _surgicalHistoryController),
            ..._buildComorbiditiesDropdowns(), // Add comorbidities dropdowns
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Edit User Details'),
  //       backgroundColor: Colors.transparent,
  //       actions: [
  //         TextButton(
  //           onPressed:
  //               _isLoading ? null : _saveData, // Disable button during loading
  //           child: _isLoading
  //               ? CircularProgressIndicator(
  //                   valueColor: AlwaysStoppedAnimation<Color>(
  //                       Colors.blueAccent.shade700),
  //                 )
  //               : Text(
  //                   'Save',
  //                   style: TextStyle(color: Colors.blueAccent.shade700),
  //                 ),
  //         ),
  //       ],
  //     ),
  //     body: SingleChildScrollView(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           GestureDetector(
  //             onTap: _pickImage,
  //             child: CircleAvatar(
  //               backgroundImage: _imageFile != null
  //                   ? FileImage(_imageFile!)
  //                   : widget.image.isNotEmpty
  //                       ? NetworkImage(widget.image)
  //                       : null,
  //               radius: 50,
  //               child: _imageFile == null && widget.image.isEmpty
  //                   ? Icon(Icons.camera_alt, size: 50, color: Colors.grey[800])
  //                   : null,
  //               onBackgroundImageError: (exception, stackTrace) {
  //                 print('Error loading image: $exception');
  //               },
  //             ),
  //           ),
  //           SizedBox(height: 16),
  //           _buildTextField('Name', _nameController),
  //           _buildDropdown('Gender', _genders, _selectedGender, (value) {
  //             setState(() {
  //               _selectedGender = value;
  //             });
  //           }),
  //           _buildTextField('Primary Contact', _primaryContactController),
  //           _buildTextField('Emergency Contact 1', _emergencyContact1Controller),
  //           _buildTextField('Emergency Contact 2', _emergencyContact2Controller),
  //           _buildDropdown('Blood Group', _bloodGroups, _selectedBloodGroup,
  //               (value) {
  //             setState(() {
  //               _selectedBloodGroup = value;
  //             });
  //           }),
  //           _buildTextField('Date of Birth', _dateOfBirthController),
  //           ..._buildComorbiditiesDropdowns(), // Add comorbidities dropdowns
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildComorbiditiesDropdowns() {
    return _comorbidities.map((comorbidity) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: DropdownButtonFormField<String>(
          value: _selectedComorbidities[comorbidity],
          items: [
            DropdownMenuItem<String>(
              value: 'Yes',
              child: Text('Yes'),
            ),
            DropdownMenuItem<String>(
              value: 'No',
              child: Text('No'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _selectedComorbidities[comorbidity] = value;
            });
          },
          decoration: InputDecoration(
            labelText: comorbidity,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class LightDarkTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextInputType keyboardType;

  const LightDarkTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorStyle: TextStyle(color: Colors.red),
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        validator: (value) {
          if (labelText == null || controller.text.isEmpty) {
            return null;
          }
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}

class LightDarkDropDown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const LightDarkDropDown({
    Key? key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}

//   File? _imageFile;
//   String? _selectedGender;
//   String? _selectedBloodGroup;
//   final List<String> _genders = ['Male', 'Female', 'Other'];
//   final List<String> _bloodGroups = [
//     'Unknown',
//     'O Positive',
//     'O Negative',
//     'A Negative',
//     'AB Negative',
//     'B Negative',
//     'B Positive',
//     'A Positive',
//     'AB Positive'
//   ];
//   final List<String> _comorbidities = [
//     'History of stroke/hemorrhage',
//     'Thyroid disease',
//     'Liver disease',
//     'Cancer',
//     'Hypertension',
//     'Pancreatic disease',
//     'Kidney disease',
//     'Cardiac disease',
//     'Diabetes',
//     'Dyslipidemia (cholesterol)'
//   ];
//   late Map<String, String?> _selectedComorbidities;
//   void _saveData() async {
//     print('button pressing');
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return; // Ensure user is logged in
//     String? profileImageUrl = widget.image; // Default to the current image URL
//     if (_imageFile != null) {
//       // If a new image is selected, upload it to Firebase Storage
//       final storageRef =
//           FirebaseStorage.instance.ref().child('userProfileImages/${user.uid}');
//       final uploadTask = storageRef.putFile(_imageFile!);
//       final snapshot = await uploadTask;
//       profileImageUrl = await snapshot.ref.getDownloadURL();
//     }
//     // Prepare the data to be updated in Firestore
//     final dataToUpdate = {
//       'profileImage': profileImageUrl ?? '',
//       'name': _getTextOrEmpty(widget.name),
//       'gender': _selectedGender ?? '',
//       'primaryContact': _getTextOrEmpty(widget.primary),
//       'emergencyContact1': _getTextOrEmpty(widget.emergencyContact1),
//       'emergencyContact2': _getTextOrEmpty(widget.emergencyContact2),
//       'bloodGroup': _selectedBloodGroup ?? '',
//       'dateOfBirth': _getTextOrEmpty(widget.dateOfBirth),
//     };
//     // Query the document based on userID
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('userProfileData')
//         .where('userID', isEqualTo: user.uid)
//         .limit(1)
//         .get();
//     if (querySnapshot.docs.isNotEmpty) {
//       // Get the document reference
//       final docRef = querySnapshot.docs.first.reference;
//       // Update the Firestore document
//       await docRef.update(dataToUpdate);
//       print('Data updated successfully');
//     } else {
//       print('User profile not found');
//     }
//   }
// // Helper method to handle empty text fields
//   String _getTextOrEmpty(String initialValue) {
//     return initialValue.isNotEmpty ? initialValue : '';
//   }
//   @override
//   void initState() {
//     super.initState();
//     _selectedGender = widget.gender.isNotEmpty ? widget.gender : null;
//     _selectedBloodGroup =
//         widget.bloodGroup.isNotEmpty ? widget.bloodGroup : null;
//     // Initialize selected comorbidities map
//     _selectedComorbidities = {
//       for (var key in widget.comorbiditiesData.keys)
//         key: widget.comorbiditiesData[key].isNotEmpty
//             ? widget.comorbiditiesData[key]
//             : null
//     };
//   }
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit User Details'),
//         backgroundColor: Colors.transparent,
//         actions: [
//           TextButton(
//             onPressed: () {
//               _saveData();
//             },
//             child: Text(
//               'Save',
//               style: TextStyle(color: Colors.blueAccent.shade700),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: _pickImage,
//               child: CircleAvatar(
//                 backgroundImage: _imageFile != null
//                     ? FileImage(_imageFile!)
//                     : widget.image.isNotEmpty
//                         ? NetworkImage(widget.image)
//                         : null,
//                 radius: 50,
//                 child: _imageFile == null && widget.image.isEmpty
//                     ? Icon(Icons.camera_alt, size: 50, color: Colors.grey[800])
//                     : null,
//                 onBackgroundImageError: (exception, stackTrace) {
//                   print('Error loading image: $exception');
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             _buildTextField('Name', widget.name),
//             _buildDropdown('Gender', _genders, _selectedGender, (value) {
//               setState(() {
//                 _selectedGender = value;
//               });
//             }),
//             _buildTextField('Primary Contact', widget.primary),
//             _buildTextField('Emergency Contact 1', widget.emergencyContact1),
//             _buildTextField('Emergency Contact 2', widget.emergencyContact2),
//             _buildDropdown('Blood Group', _bloodGroups, _selectedBloodGroup,
//                 (value) {
//               setState(() {
//                 _selectedBloodGroup = value;
//               });
//             }),
//             _buildTextField('Date of Birth', widget.dateOfBirth),
//             ..._buildComorbiditiesDropdowns(),
//             _buildMapFields(
//                 'Allergic Medications', widget.allergicMedicationsData),
//             _buildMapFields(
//                 'Current Medications', widget.currentMedicationsData),
//             _buildMapFields('Medical History', widget.medicalHistoryData),
//             _buildMapFields('Surgical History', widget.surgicalHistoryData),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//   List<Widget> _buildComorbiditiesDropdowns() {
//     List<Widget> dropdowns = [];
//     widget.comorbiditiesData.forEach((key, value) {
//       dropdowns.add(_buildDropdown(
//           key, _comorbidities, _selectedComorbidities[key], (newValue) {
//         setState(() {
//           _selectedComorbidities[key] = newValue;
//         });
//       }));
//     });
//     return dropdowns;
//   }
//   Widget _buildTextField(String label, String initialValue) {
//     return LightDarkTextField(
//       controller: TextEditingController(text: initialValue),
//       hintText: label,
//       labelText: label,
//       keyboardType: TextInputType.text,
//     );
//   }
//   Widget _buildDropdown(
//     String title,
//     List<String> items,
//     String? selectedValue,
//     ValueChanged<String?> onChanged,
//   ) {
//     // Remove duplicates from items list
//     final uniqueItems = items.toSet().toList();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         LightDarkDropDown(
//           hint: 'Please select',
//           items: uniqueItems,
//           value: uniqueItems.contains(selectedValue) ? selectedValue : null,
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
//   Widget _buildMapFields(String title, Map<String, dynamic> data) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         for (var entry in data.entries)
//           LightDarkTextField(
//             controller: TextEditingController(text: entry.value.toString()),
//             hintText: entry.key,
//             keyboardType: TextInputType.text,
//           ),
//       ],
//     );
//   }
// }