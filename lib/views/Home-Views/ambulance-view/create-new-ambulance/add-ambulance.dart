
import 'package:flutter/material.dart';

import 'package:ecare/constants/linker.dart';

class AddAmbulanceView extends StatefulWidget {
  const AddAmbulanceView({super.key});

  @override
  State<AddAmbulanceView> createState() => _AddAmbulanceViewState();
}

class _AddAmbulanceViewState extends State<AddAmbulanceView> {
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

  // Method to save Ambulance Data
  Future<void> registerAmbulance() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Get current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a map of ambulance data
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      Map<String, dynamic> ambulanceData = {
        'district': districtName.text,
        'city': cityName.text,
        'address': address.text,
        'ambulanceRegistrationNumber': ambulanceRegistrationNumber.text,
        'ambulanceType': ambulanceType.text,
        'contactNumber': contactNumber.text,
        'pinCode': pinCode.text,
        'nameofambulanceservice': nameofambulanceservice.text,
        'id': id,
        'createdAt':
        FieldValue.serverTimestamp(), // To store when it was created
      };
      await FirebaseFirestore.instance.collection('ambulances').doc(userId).set({
        'id':userId,
      });
      // Save data under 'ambulances' -> userId -> 'userambulance' subcollection
      await FirebaseFirestore.instance
          .collection('ambulances')
          .doc(userId)
          .collection('userambulance')
          .doc(id)
          .set(ambulanceData);

      // On success, reset the form
      setState(() {
        districtName.clear();
        cityName.clear();
        address.clear();
        ambulanceRegistrationNumber.clear();
        ambulanceType.clear();
        contactNumber.clear();
        pinCode.clear();
        nameofambulanceservice.clear();
        nameofambulanceservice.clear();
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
                  controller: ambulanceType,
                  hintText: 'Type of Ambulance',
                  keyboardType: TextInputType.text),
                  
              SizedBox(height: 5.h),
              LightDarktextField(
                  controller: nameofambulanceservice,
                  hintText: 'Name of Ambulance Service',
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
                      onTap: registerAmbulance, // Call registerAmbulance method
                      child: BlueButton(text: 'Register'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
