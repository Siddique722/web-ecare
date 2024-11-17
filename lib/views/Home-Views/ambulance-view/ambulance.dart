// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/Home-Views/ambulance-view/create-new-ambulance/add-ambulance.dart';
import 'package:ecare/views/Home-Views/ambulance-view/create-new-ambulance/view-ambulances.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AmbulanceView extends StatefulWidget {
  const AmbulanceView({super.key});

  @override
  State<AmbulanceView> createState() => _AmbulanceViewState();
}

class _AmbulanceViewState extends State<AmbulanceView> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(); // FocusNode to detect focus
  List<Map<String, dynamic>> filteredAmbulances = [];

  @override
  void initState() {
    super.initState();
    fetchFilteredAmbulances('.'); // Fetch all ambulances initially

    // Listen for focus changes to trigger UI updates
    searchFocusNode.addListener(() {
      setState(() {}); // Update the UI when focus changes
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> fetchFilteredAmbulances(String searchTerm) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('ambulances')
        .doc(userId)
        .collection('userambulance')
        .get();

    List<Map<String, dynamic>> allAmbulances = snapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    setState(() {
      filteredAmbulances = allAmbulances.where((ambulance) {
        final district = ambulance['district']?.toString().toLowerCase() ?? '';
        final city = ambulance['city']?.toString().toLowerCase() ?? '';
        final ambulanceRegistrationNumber =
            ambulance['ambulanceRegistrationNumber']
                    ?.toString()
                    .toLowerCase() ??
                '';
        final ambulanceType =
            ambulance['ambulanceType']?.toString().toLowerCase() ?? '';
        final pinCode = ambulance['pinCode']?.toString().toLowerCase() ?? '';

        return district.contains(searchTerm.toLowerCase()) ||
            city.contains(searchTerm.toLowerCase()) ||
            ambulanceRegistrationNumber.contains(searchTerm.toLowerCase()) ||
            ambulanceType.contains(searchTerm.toLowerCase()) ||
            pinCode.contains(searchTerm.toLowerCase());
      }).toList();
    });
  }

  void onSearchChanged(String searchTerm) {
    fetchFilteredAmbulances(searchTerm);
  }

  Future<void> _launchDialer(String contactNumber) async {
    final phoneNumber = 'tel:$contactNumber'; 
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ambulance Options'),
                content: Text('Please choose an option:'),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AvailableAmbulancesView()));
                    },
                    child: BlueButton(
                      text: 'Registered Ambulances',
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddAmbulanceView()));
                    },
                    child: BlueButton(
                      text: 'New Ambulance',
                    ),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: AppColors.blueColor,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Search bar
            TextField(
              controller: searchController,
              focusNode: searchFocusNode, // Attach FocusNode to the search bar
              decoration: InputDecoration(
                labelText: 'Search Ambulance',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: onSearchChanged,
            ),
            SizedBox(height: 10.h),
            // Show hint text only when search bar is focused
            if (searchFocusNode.hasFocus)
              Text(
                'You can search with your city, PIN code, or district.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            SizedBox(height: 10.h),
            BoldTextWidgetTheme(text: 'Government Ambulance'),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () => _launchDialer('108'),
              child: BlueButton(
                text: 'Dial 108',
              ),
            ),
            SizedBox(height: 10.h),
            BoldTextWidgetTheme(text: 'Private Ambulance'),
            SizedBox(height: 10.h),

            Expanded(
              child: filteredAmbulances.isEmpty
                  ? Center(
                      child: Text(
                        'No ambulances found matching your search.',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredAmbulances.length,
                      itemBuilder: (context, index) {
                        final ambulance = filteredAmbulances[index];
                        final contactNumber = ambulance['contactNumber'];

                        return Card(
                          child: ListTile(
                            title: Text('District: ${ambulance['district']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('City: ${ambulance['city']}'),
                                Text(
                                    'Ambulance Reg. No: ${ambulance['ambulanceRegistrationNumber']}'),
                                Text('Type: ${ambulance['ambulanceType']}'),
                                Text('Pin Code: ${ambulance['pinCode']}'),
                              ],
                            ),
                            onTap: () {
                              if (contactNumber != null &&
                                  contactNumber.isNotEmpty) {
                                _launchDialer(contactNumber);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Contact number not available')),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
