// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

import 'package:ecare/constants/linker.dart';

class UpdateAmbulanceView extends StatefulWidget {
  final String districtName;
  final String cityName;
  final String address;
  final String ambulanceRegistrationNumber;
  final String ambulanceType;
  final String contactNumber;
  final String pinCode;
  final String docId;
  final String nameofambulanceservice;
  const UpdateAmbulanceView(
      {super.key,
      required this.address,
      required this.ambulanceRegistrationNumber,
      required this.ambulanceType,
      required this.contactNumber,
      required this.pinCode,
      required this.docId,
      required this.districtName,
      required this.nameofambulanceservice,
      required this.cityName});

  @override
  State<UpdateAmbulanceView> createState() => _UpdateAmbulanceViewState();
}

class _UpdateAmbulanceViewState extends State<UpdateAmbulanceView> {
  // Text Controllers
  TextEditingController districtName = TextEditingController();
  TextEditingController cityName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController ambulanceRegistrationNumber = TextEditingController();
  TextEditingController ambulanceType = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController pinCode = TextEditingController();
    TextEditingController nameofambulanceservice = TextEditingController();


  // Loading State
  bool isLoading = false;
  // Error Message State
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    districtName.text = widget.districtName;
    cityName.text = widget.cityName;
    address.text = widget.address;
    ambulanceRegistrationNumber.text = widget.ambulanceRegistrationNumber;
    ambulanceType.text = widget.ambulanceType;
    contactNumber.text = widget.contactNumber;
    pinCode.text = widget.pinCode;
    nameofambulanceservice.text = widget.nameofambulanceservice;
  }

  // Method to save Ambulance Data
  Future<void> updateAmbulance() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Get current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a map of ambulance data
      Map<String, dynamic> ambulanceData = {
        'district': districtName.text,
        'city': cityName.text,
        'address': address.text,
        'ambulanceRegistrationNumber': ambulanceRegistrationNumber.text,
        'ambulanceType': ambulanceType.text,
        'contactNumber': contactNumber.text,
        'pinCode': pinCode.text,
        'nameofambulanceservice': nameofambulanceservice.text, // Add new field
        'createdAt':
            FieldValue.serverTimestamp(), // To store when it was created
      };

      // Save data under 'ambulances' -> userId -> 'userambulance' subcollection
      await FirebaseFirestore.instance
          .collection('ambulances')
          .doc(userId)
          .collection('userambulance')
          .doc(widget.docId)
          .update(ambulanceData);

      // On success, reset the form
      setState(() {
        districtName.clear();
        cityName.clear();
        address.clear();
        ambulanceRegistrationNumber.clear();
        ambulanceType.clear();
        contactNumber.clear();
        pinCode.clear();
        isLoading = false;
      });

      // Optionally show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ambulance registered successfully!'),
      ));
    } catch (e) {
      setState(() {
        errorMessage = "Failed to register ambulance: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              BoldTextWidgetTheme(text: 'Add New Ambulance'),
              SizedBox(height: 10.h),
              LightDarktextField(
                  controller: districtName,
                  hintText: 'District Name',
                  keyboardType: TextInputType.text),
              SizedBox(height: 5.h),
              LightDarktextField(
                  controller: cityName,
                  hintText: 'City Name',
                  keyboardType: TextInputType.text),
              SizedBox(height: 5.h),
              LightDarktextField(
                  controller: address,
                  hintText: 'Address',
                  keyboardType: TextInputType.text),
              SizedBox(height: 5.h),
              LightDarktextField(
                  controller: ambulanceRegistrationNumber,
                  hintText: 'Ambulance Registration Number',
                  keyboardType: TextInputType.text),
                 SizedBox(height: 5.h),
              LightDarktextField(
                  controller: nameofambulanceservice,
                  hintText: 'Name of Ambulance Service',
                  keyboardType: TextInputType.text),
              SizedBox(height: 5.h),
              LightDarktextField(
                  controller: ambulanceType,
                  hintText: 'Type of Ambulance',
                  keyboardType: TextInputType.text),
              SizedBox(height: 5.h),
              LightDarktextField(
                  controller: contactNumber,
                  hintText: 'Contact Number',
                  keyboardType: TextInputType.number),
              SizedBox(height: 5.h),
              LightDarktextField(
                  controller: pinCode,
                  hintText: 'Pin Code',
                  keyboardType: TextInputType.number),
              SizedBox(height: 5.h),

              // Show error message if any
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),

              SizedBox(height: 5.h),

              // Show loading or button based on loading state
              isLoading
                  ? AppLoading() // Loading Indicator
                  : InkWell(
                      onTap: updateAmbulance, // Call registerAmbulance method
                      child: BlueButton(text: 'Update'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
