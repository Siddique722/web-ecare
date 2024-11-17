import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecare/views/Home-Views/Users-View/show-users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:ecare/constants/linker.dart';

class ScanQRCodeHomw extends StatefulWidget {
  const ScanQRCodeHomw({super.key});

  @override
  State<ScanQRCodeHomw> createState() => _ScanQRCodeHomwState();
}

class _ScanQRCodeHomwState extends State<ScanQRCodeHomw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldTextWidgetTheme(text: 'Scan QR Code'),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => QRViewExample(),
                  ),
                );
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade900)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Scan QR code on your E-Care ID Card'),
                        Icon(Icons.qr_code_scanner_rounded)
                      ])),
            ),
            SizedBox(
              height: 20.h,
            ),
            SimpleTextWidgetTheme(
                text:
                    '**Your medical data cannot be accessed by anyone includeingthe doctor without your authentication'),
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });

      if (result != null) {
        controller.pauseCamera(); // Stop scanning when a result is found

        // Query Firestore to match the scanned data with the 'name' field in 'userProfileData' collection
        final userDoc = await FirebaseFirestore.instance
            .collection('userProfileData')
            .where('primaryContact', isEqualTo: result!.code)
            .get();
        //log('==============================================1');

        if (userDoc.docs.isNotEmpty) {
          final userData = userDoc.docs.first.data();
          final email = userData['email'];
       //  log('==============================================2');
          print('USer email=$email  =================================');
          // Stop the camera and navigate to the result screen
          controller.dispose();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeResultScreen(userData: userData),
            ),
          );
        } else {
          try {
            // Get all documents from the 'familyUser' collection
            final familyUserDocs =
                await FirebaseFirestore.instance.collection('familyUser').get();

            // Store all 'docId' field values in a list
            List<String> familyUserDocIds = [];
            for (var doc in familyUserDocs.docs) {
              // Assuming 'docId' is stored in each document in the 'familyUser' collection
              final docId = doc['docId'];
              familyUserDocIds.add(docId);
            }

            // Logging the total number of documents
            //log('Total number of documents in familyUser: ${familyUserDocIds.length}');

            bool userFound = false;

            // Loop through the list of 'docId' and check each subcollection
            for (var docId in familyUserDocIds) {
             // log('Checking for primaryContact in docId: $docId');

              // Get the 'userProfileData' subcollection for each 'familyUser' document
              final familyUserProfileData = await FirebaseFirestore.instance
                  .collection('familyUser')
                  .doc(docId)
                  .collection('userProfileData')
                  .where('primaryContact',
                      isEqualTo: result!.code) // Matching the QR code
                  .get();

              // If a match is found
              if (familyUserProfileData.docs.isNotEmpty) {
                final userData = familyUserProfileData.docs.first.data();
                final email = userData['email'];

                // Log found user data
              //  log('User found with email: $email');

                // Stop the camera and navigate to the result screen
                controller.dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QRCodeResultScreen(userData: userData),
                  ),
                );
                userFound = true;
                break; // Exit the loop if a match is found
              }
            }

            // If no user was found in any document
            if (!userFound) {
              // Handle the case where no match is found in both collections
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('No user found with this QR code: ${result!.code}'),
                ),
              );
              // Resume the camera
              controller.resumeCamera();
            }
          } catch (e) {
           // log('Error: $e');
          }
        }

        // else {
        //   // If no match in 'userProfileData', check in 'familyUser' collection's subcollection 'userProfileData'
        //   final familyUserDocs = await FirebaseFirestore.instance
        //       .collection('familyUser')
        //       //.doc('XnogReIrJJaw3GNJJCtMuaJdIKg2')
        //       //.collection('userProfileData')

        //       // .where('primaryContact', isEqualTo: result!.code)
        //       .get();
        //   CollectionReference collectionRef =
        //       FirebaseFirestore.instance.collection('familyUser');

        //   QuerySnapshot snapshot = await collectionRef.get();
        //   print('Total number of documents: ${snapshot.docs.length}');
        //   log('Number of documents in familyUser collection: ${familyUserDocs.docs.length}');
        //   log('==============================================3');
        //   if (familyUserDocs.docs.isNotEmpty) {
        //     log('Documents found in familyUser');
        //   } else {
        //     log('No documents found in familyUser');
        //   }
        //   log('${familyUserDocs.docs}==============================================4');
        //   bool userFound = false;
        //   for (var familyDoc in familyUserDocs.docs) {
        //     log('==============================================5');

        //     final familyUserProfileData = await familyDoc.reference
        //         .collection('userProfileData')
        //         .where('primaryContact', isEqualTo: result!.code)
        //         .get();

        //     // if (familyUserProfileData.docs.isNotEmpty) {
        //     if (familyUserDocs.docs.isNotEmpty) {
        //       final userData = familyUserProfileData.docs.first.data();
        //       final email = userData['email'];
        //       // Stop the camera and navigate to the result screen
        //       controller.dispose();
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => QRCodeResultScreen(userData: userData),
        //         ),
        //       );
        //       userFound = true;
        //       break;
        //     }
        //   }

        //   if (!userFound) {
        //     // Handle the case where no match is found in both collections
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //           content:
        //               Text('No user found with this QR code: ${result!.code}')),
        //     );
        //     // Resume the camera
        //     controller.resumeCamera();
        //   }

        // }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QRCodeResultScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  QRCodeResultScreen({required this.userData});

  @override
  _QRCodeResultScreenState createState() => _QRCodeResultScreenState();
}

class _QRCodeResultScreenState extends State<QRCodeResultScreen> {
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    // Send an authentication notification when the screen loads
    _sendAuthenticationEmail(
        widget.userData['email'], widget.userData['userId']);
  }

  // Simulate sending an authentication email
// This will send an authentication request and listen for real-time updates.
  Future<void> _sendAuthenticationEmail(String email, String userId) async {
    // Send authentication request by writing to Firestore
    await FirebaseFirestore.instance
        .collection('authenticationRequests')
        .doc(userId)
        .set({
      'email': email,
      'status': 'pending', // status will be updated when the user authenticates
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('Sending authentication request to $email');

    // Listen to changes in the document for real-time updates
    FirebaseFirestore.instance
        .collection('authenticationRequests')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          final status = data['status'];
          if (status == 'approved') {
            // User authenticated successfully
            print('Authentication approved');
            setState(() {
              isAuthenticated = true;
            });
            // Optionally, navigate to the next screen or update UI
          } else if (status == 'declined') {
            // User declined the request
            print('Authentication declined');
            setState(() {
              isAuthenticated = false;
            });
            // Show a message and ask the user to scan again
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Authentication declined. Please scan the QR code again.'),
            ));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isAuthenticated
            ? InkWell(
                onTap: () async {
                  print('button pressing---');
                  String user = widget.userData['userId'];
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 20),
                            Text('Loading...'),
                          ],
                        ),
                      );
                    },
                  );

                  final allergicMedicationsData =
                      await _fetchUserDataCollection(
                          'allergicMedicationsData', user);
                  final comorbiditiesData =
                      await _fetchUserDataCollection('comorbiditiesData', user);
                  final currentMedicationsData = await _fetchUserDataCollection(
                      'currentMedicationsData', user);
                  final medicalHistoryData = await _fetchUserDataCollection(
                      'medicalHistoryData', user);
                  final surgicalHistoryData = await _fetchUserDataCollection(
                      'surgicalHistoryData', user);

                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(
                        role: 'family',
                        image: widget.userData!['profileImage'],
                        gender: widget.userData!['gender'] ?? 'No Data',
                        primary: widget.userData!['primaryContact'] ??
                            'No Primary Contact',
                        emergencyContact1:
                            widget.userData!['emergencyContact1'] ??
                                'No EmergencyContact1',
                        emergencyContact2:
                            widget.userData!['emergencyContact2'] ??
                                'No EmergencyContact2',
                        name: widget.userData!['name'] ?? 'No Name',
                        bloodGroup:
                            widget.userData!['bloodGroup'] ?? 'No Blood Group',
                        dateOfBirth:
                            widget.userData!['dateOfBirth'] ?? 'No DOB',
                        allergicMedicationsData: allergicMedicationsData,
                        comorbiditiesData: comorbiditiesData,
                        currentMedicationsData: currentMedicationsData,
                        medicalHistoryData: medicalHistoryData,
                        surgicalHistoryData: surgicalHistoryData,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Text(
                          'Name: ${widget.userData['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Blood Group: ${widget.userData['bloodGroup']}\nDate of Birth: ${widget.userData['dateOfBirth']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ),
              )
            : Center(
                child: Text(
                  'Please wait while we authenticate your request...',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserDataCollection(
      String collectionName, String userID) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userID)
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print('No document found for the provided userID.');
        return {};
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }
}

// class QRCodeResultScreen extends StatelessWidget {
//   final Map<String, dynamic> userData;

//   QRCodeResultScreen({required this.userData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: InkWell(
//           onTap: () async {
//             print('button pressing---');
//             String user = userData['userId'];
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   content: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(width: 20),
//                       Text('Loading...'),
//                     ],
//                   ),
//                 );
//               },
//             );

//             final allergicMedicationsData =
//                 await _fetchUserDataCollection('allergicMedicationsData', user);
//             final comorbiditiesData =
//                 await _fetchUserDataCollection('comorbiditiesData', user);
//             final currentMedicationsData =
//                 await _fetchUserDataCollection('currentMedicationsData', user);
//             final medicalHistoryData =
//                 await _fetchUserDataCollection('medicalHistoryData', user);
//             final surgicalHistoryData =
//                 await _fetchUserDataCollection('surgicalHistoryData', user);

//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => UserDetailScreen(
//                   role: 'family',
//                   image: userData!['profileImage'],
//                   gender: userData!['gender'] ?? 'No Data',
//                   primary: userData!['primaryContact'] ?? 'No Primary Contact',
//                   emergencyContact1:
//                       userData!['emergencyContact1'] ?? 'No EmergencyContact1',
//                   emergencyContact2:
//                       userData!['emergencyContact2'] ?? 'No EmergencyContact2',
//                   name: userData!['name'] ?? 'No Name',
//                   bloodGroup: userData!['bloodGroup'] ?? 'No Blood Group',
//                   dateOfBirth: userData!['dateOfBirth'] ?? 'No DOB',
//                   allergicMedicationsData: allergicMedicationsData,
//                   comorbiditiesData: comorbiditiesData,
//                   currentMedicationsData: currentMedicationsData,
//                   medicalHistoryData: medicalHistoryData,
//                   surgicalHistoryData: surgicalHistoryData,
//                 ),
//               ),
//             );
//           },
//           child: Card(
//             elevation: 4.0,
//             child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ListTile(
//                   title: Text(
//                     'Name: ${userData['name']}',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     'Blood Group: ${userData['bloodGroup']}\nDate of Birth: ${userData['dateOfBirth']}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 )),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<Map<String, dynamic>> _fetchUserDataCollection(
//       String collectionName, String userID) async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection(collectionName)
//           .doc(userID)
//           //  .collection(collectionName)
//           .get();

//       if (snapshot.exists) {
//         return snapshot.data() as Map<String, dynamic>;
//       } else {
//         print('No document found for the provided userID.');
//         return {};
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//       return {};
//     }
//   }
// }
