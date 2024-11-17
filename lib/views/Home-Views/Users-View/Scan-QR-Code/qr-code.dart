// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_app/views/Home-Views/Users-View/show-users.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
 import 'package:ecare/views/Home-Views/Users-View/show-users.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => QRViewExample(),
            //       ),
            //     );
            //   },
            //   child: Text('Start QR Code Scan'),
            // ),
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
          // Expanded(
          //   flex: 1,
          //   child: Center(
          //     child: (result != null)
          //         ? Text(
          //             'Barcode Type: ${result!.format}   Data: ${result!.code}')
          //         : Text('Scan a code'),
          //   ),
          // ),
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

        if (userDoc.docs.isNotEmpty) {
          final userData = userDoc.docs.first.data();
          // Stop the camera and navigate to the result screen
          controller.dispose();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeResultScreen(userData: userData),
            ),
          );
        } else {
          // If no match in 'userProfileData', check in 'familyUser' collection's subcollection 'userProfileData'
          final familyUserDocs =
              await FirebaseFirestore.instance.collection('familyUser').get();

          bool userFound = false;

          for (var familyDoc in familyUserDocs.docs) {
            final familyUserProfileData = await familyDoc.reference
                .collection('userProfileData')
                .where('name', isEqualTo: result!.code)
                .get();

            if (familyUserProfileData.docs.isNotEmpty) {
              final userData = familyUserProfileData.docs.first.data();
              // Stop the camera and navigate to the result screen
              controller.dispose();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodeResultScreen(userData: userData),
                ),
              );
              userFound = true;
              break;
            }
          }

          if (!userFound) {
            // Handle the case where no match is found in both collections
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('No user found with this QR code: ${result!.code}')),
            );
            // Resume the camera
            controller.resumeCamera();
          }
        }
      }
    });
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) async {
  //     setState(() {
  //       result = scanData;
  //     });

  //     if (result != null) {
  //       controller.pauseCamera(); // Stop scanning when a result is found

  //       // Query Firestore to match the scanned data with the 'name' field
  //       final userDoc = await FirebaseFirestore.instance
  //           .collection('userProfileData')
  //           .where('name', isEqualTo: result!.code)
  //           .get();

  //       if (userDoc.docs.isNotEmpty) {
  //         final userData = userDoc.docs.first.data();
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => QRCodeResultScreen(userData: userData),
  //           ),
  //         );
  //       } else {
  //         // Handle the case where no match is found
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //               content:
  //                   Text('No user found with this QR code.${result!.code}')),
  //         );
  //         controller.resumeCamera();
  //       }
  //     }
  //   });
  // }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QRCodeResultScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  QRCodeResultScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () async {
            print('button pressing---');
            String user = userData['userId'];
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
                await _fetchUserDataCollection('allergicMedicationsData', user);
            final comorbiditiesData =
                await _fetchUserDataCollection('comorbiditiesData', user);
            final currentMedicationsData =
                await _fetchUserDataCollection('currentMedicationsData', user);
            final medicalHistoryData =
                await _fetchUserDataCollection('medicalHistoryData', user);
            final surgicalHistoryData =
                await _fetchUserDataCollection('surgicalHistoryData', user);

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(
                  role: 'family',
                  image: userData!['profileImage'],
                  gender: userData!['gender'] ?? 'No Data',
                  primary: userData!['primaryContact'] ?? 'No Primary Contact',
                  emergencyContact1:
                      userData!['emergencyContact1'] ?? 'No EmergencyContact1',
                  emergencyContact2:
                      userData!['emergencyContact2'] ?? 'No EmergencyContact2',
                  name: userData!['name'] ?? 'No Name',
                  bloodGroup: userData!['bloodGroup'] ?? 'No Blood Group',
                  dateOfBirth: userData!['dateOfBirth'] ?? 'No DOB',
                  allergicMedicationsData: allergicMedicationsData,
                  comorbiditiesData: comorbiditiesData,
                  currentMedicationsData: currentMedicationsData,
                  medicalHistoryData: medicalHistoryData,
                  surgicalHistoryData: surgicalHistoryData,
                ),
              ),
            );

            // child: ListTile(
            //   leading: CircleAvatar(
            //     backgroundImage: NetworkImage(userData!['profileImage']),
            //     radius: 30,
            //   ),
            //   title: Text(
            //     userData!['name'] ?? 'No Name',
            //   ),
            //   subtitle: Text(
            //     'Blood Group: ${userData!['bloodGroup'] ?? 'No Blood Group'}\nDate of Birth: ${userData!['dateOfBirth'] ?? 'No DOB'}',
            //   ),
            // ),
          },
          child: Card(
            elevation: 4.0,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  title: Text(
                    'Name: ${userData['name']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Blood Group: ${userData['bloodGroup']}\nDate of Birth: ${userData['dateOfBirth']}',
                    style: TextStyle(fontSize: 16),
                  ),
                )

                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Name: ${userData['name']}',
                //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //       ),
                //       SizedBox(height: 10),
                //       Text(
                //         'User ID: ${userData['userId']}',
                //         style: TextStyle(fontSize: 16),
                //       ),
                //       SizedBox(height: 10),
                //       Text(
                //         'Blood Group: ${userData['bloodGroup']}',
                //         style: TextStyle(fontSize: 16),
                //       ),
                //       SizedBox(height: 10),
                //       Text(
                //         'Date of Birth: ${userData['dateOfBirth']}',
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ],
                //   ),
                ),
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
          //  .collection(collectionName)
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
