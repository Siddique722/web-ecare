import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw; // PDF package
import 'package:open_file/open_file.dart'; // To open PDF file
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For loading effect
import 'package:pdf/pdf.dart'; // For PdfPageFormat
import 'package:ecare/constants/linker.dart';
import 'package:pdf/widgets.dart' as pw; // For pdf widgets

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  List<Map<String, dynamic>> _cartDataList =
      []; // Global list to store cart data

  Future<Map<String, dynamic>> _fetchUserProfileData(String userId) async {
    try {
      final userProfileSnapshot = await FirebaseFirestore.instance
          .collection('userProfileData')
          .doc(userId)
          .get();

      if (userProfileSnapshot.exists) {
        final userProfileData = userProfileSnapshot.data()!;
        final usersDataSnapshot = await FirebaseFirestore.instance
            .collection('UsersData')
            .where('userId', isEqualTo: userId)
            .get();

        String userEmail = 'No Email';
        String imageUrl = 'default_url'; // Default URL if no image found
        if (usersDataSnapshot.docs.isNotEmpty) {
          userEmail =
              usersDataSnapshot.docs.first.data()['userEmail'] ?? 'No Email';
          imageUrl = usersDataSnapshot.docs.first.data()['imageUrl'] ??
              'default_url'; // Get image URL
        }

        return {
          'emergencyContact1':
              userProfileData['emergencyContact1'] ?? 'No Contact',
          'emergencyContact2':
              userProfileData['emergencyContact2'] ?? 'No Contact',
          'primaryContact': userProfileData['primaryContact'] ?? 'No Contact',
          'userEmail': userEmail,
          'imageUrl': imageUrl, // Pass the image URL to the map
        };
      } else {
        return {
          'emergencyContact1': 'No Contact',
          'emergencyContact2': 'No Contact',
          'primaryContact': 'No Contact',
          'userEmail': 'No Email',
          'imageUrl': 'default_url', // Default URL
        };
      }
    } catch (e) {
      return {
        'emergencyContact1': 'Error Fetching',
        'emergencyContact2': 'Error Fetching',
        'primaryContact': 'Error Fetching',
        'userEmail': 'Error Fetching',
        'imageUrl': 'default_url', // Default URL in case of error
      };
    }
  }

// Updated PDF creation method to include start and end range
  Future<void> _createAndSavePDF(int start, int end) async {
    try {
      final pdf = pw.Document();
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/order_data.pdf';

      // Validate range
      if (start < 0 || end > _cartDataList.length || start >= end) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid range selected')),
        );
        return;
      }

      // Filter cart data based on range
      final filteredData = _cartDataList.sublist(start, end);

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            pw.ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Name: ${item['name']}'),
                    pw.Text('Blood Group: ${item['blood']}'),
                    pw.Text('Date of Birth: ${item['dob']}'),
                    pw.Text('Order Number: ${item['orderNumber']}'),
                    pw.Text('Price: ${item['price']}'),
                    pw.Text('Primary Contact: ${item['primaryContact']}'),
                    pw.Text(
                        'Emergency Contact 1: ${item['emergencyContact1']}'),
                    pw.Text(
                        'Emergency Contact 2: ${item['emergencyContact2']}'),
                    pw.Text('User Email: ${item['userEmail']}'),
                    pw.Text('Pin Code: ${item['pinCode']}'),
                    pw.Text('Address: ${item['address']}'),
                    pw.Text('Order Date: ${item['date']}'),
                    pw.SizedBox(height: 10),
                    pw.Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      );

      final file = File(path);
      await file.writeAsBytes(await pdf.save());

      _showDownloadCompleteDialog(file);
    } catch (e) {
      print('Error creating PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create PDF: $e'),
        ),
      );
    }
  }

  // Future<void> _createAndSavePDF() async {
  //   try {
  //     final pdf = pw.Document();
  //     final directory = await getApplicationDocumentsDirectory();
  //     final path = '${directory.path}/order_data.pdf';
  //     print("PDF generated item List length: ${_cartDataList.length}");

  //     // Create a multi-page PDF to handle large data
  //     pdf.addPage(
  //       pw.MultiPage(
  //         pageFormat: PdfPageFormat.a4,
  //         build: (context) => [
  //           pw.ListView.builder(
  //             itemCount: _cartDataList.length,
  //             itemBuilder: (context, index) {
  //               print("Index = $index");
  //               return pw.Column(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Text('Name: ${_cartDataList[index]['name']}'),
  //                   pw.Text('Blood Group: ${_cartDataList[index]['blood']}'),
  //                   pw.Text('Date of Birth: ${_cartDataList[index]['dob']}'),
  //                   pw.Text(
  //                       'Order Number: ${_cartDataList[index]['orderNumber']}'),
  //                   pw.Text('Price: ${_cartDataList[index]['price']}'),
  //                   pw.Text(
  //                       'Primary Contact: ${_cartDataList[index]['primaryContact']}'),
  //                   pw.Text(
  //                       'Emergency Contact 1: ${_cartDataList[index]['emergencyContact1']}'),
  //                   pw.Text(
  //                       'Emergency Contact 2: ${_cartDataList[index]['emergencyContact2']}'),
  //                   pw.Text('User Email: ${_cartDataList[index]['userEmail']}'),
  //                   pw.Text('Pin Code: ${_cartDataList[index]['pinCode']}'),
  //                   pw.Text('Address: ${_cartDataList[index]['address']}'),
  //                   pw.Text('Order Date: ${_cartDataList[index]['date']}'),
  //                   pw.SizedBox(height: 10),
  //                   pw.Divider(),
  //                 ],
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     );

  //     final file = File(path);
  //     await file.writeAsBytes(await pdf.save());

  //     _showDownloadCompleteDialog(file);
  //   } catch (e) {
  //     print('Error creating PDF: $e'); // Log the error
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Failed to create PDF: $e'),
  //     ));
  //   }
  // }

// Method to show dialog for range input
  void _showRangeDialog() {
    final TextEditingController startController = TextEditingController();
    final TextEditingController endController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Range'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: startController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Starting Card Number',
              ),
            ),
            TextField(
              controller: endController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ending Card Number',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final start = int.tryParse(startController.text) ?? 1;
              final end =
                  int.tryParse(endController.text) ?? _cartDataList.length;
              _createAndSavePDF(
                  start - 1, end); // Adjust indices (1-based to 0-based)
            },
            child: Text('Generate PDF'),
          ),
        ],
      ),
    );
  }

  void _showDownloadCompleteDialog(File file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Download Complete'),
        content:
            Text('The PDF has been downloaded. Would you like to open it?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              OpenFile.open(file.path);
            },
            child: Text('Open'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin View'),
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('CartData')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final cartData = snapshot.data?.docs ?? [];

          if (cartData.isEmpty) {
            return Center(child: Text('No Data Available'));
          }

          return FutureBuilder<List<Widget>>(
            future: Future.wait(cartData.asMap().entries.map((entry) async {
              final index = entry.key + 1; // Add 1 to start index from 1
              final doc = entry.value; // Get the document data
              final data = doc.data() as Map<String, dynamic>;
              final userId = data['userId'] ?? 'No UserId';
              final userProfileData = await _fetchUserProfileData(userId);

              // Add cart item to the global cart data list
              final cartItem = {
                'index': index, // Add the index to the cart item data
                'name': data['name'] ?? 'No Name',
                'blood': data['blood'] ?? 'No Blood Group',
                'dob': data['dob'] ?? 'No Date of Birth',
                'orderNumber': data['orderNumber'] ?? 'No Order Number',
                'price': data['price'] ?? 'No Price',
                'pinCode': data['pinCode'],
                'date': data['date'],
                'address': data['address'],
                'primaryContact': userProfileData['primaryContact'],
                'emergencyContact1': userProfileData['emergencyContact1'],
                'emergencyContact2': userProfileData['emergencyContact2'],
                'userEmail': userProfileData['userEmail'],
                'imageUrl':
                    userProfileData['imageUrl'], // Image URL from user profile
              };

              _cartDataList.add(cartItem); // Populate the global list
              print("Showing items in cart length:${cartItem.length}");
              return ExpansionTile(
                leading: CircleAvatar(
                  radius: 30, // Adjust size for better proportion
                  backgroundImage: NetworkImage(cartItem['imageUrl']),
                  onBackgroundImageError: (exception, stackTrace) {
                    print('Error loading image: $exception');
                  },
                  child: Icon(
                    Icons.person,
                    size: 30, // Adjust icon size
                    color: Colors.white,
                  ), // Fallback icon when image fails
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.whiteColor)),
                title: Padding(
                  padding: EdgeInsets.all(16.0), // Padding inside the card
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.zero, // Remove default padding from ListTile
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${cartItem['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0, // Larger font for the name
                          ),
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            "$index",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(
                          top: 8.0), // Padding between title and subtitle
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email: ${cartItem['userEmail']}',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Blood Group: ${cartItem['blood']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Date of Birth: ${cartItem['dob']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Order Number: ${cartItem['orderNumber']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 8.0),
                        Divider(),
                        SizedBox(height: 8.0),
                        Text(
                          'Price: ${cartItem['price']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Primary Contact: ${cartItem['primaryContact']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Emergency Contact 1: ${cartItem['emergencyContact1']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Emergency Contact 2: ${cartItem['emergencyContact2']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Pin Code: ${cartItem['pinCode']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Address: ${cartItem['address']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Order Date: ${cartItem['date']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              // return Card(
              //   margin: EdgeInsets.all(8.0),
              //   child: ListTile(
              //     leading: CircleAvatar(
              //       backgroundImage: NetworkImage(cartItem['imageUrl']),
              //       backgroundColor: Colors.grey[200],
              //       onBackgroundImageError: (exception, stackTrace) {
              //         print('Error loading image: $exception');
              //       },
              //       child: Icon(Icons.person), // Fallback icon when image fails
              //     ),
              //     title: Stack(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text("${cartItem['name']}"),
              //             CircleAvatar(child: Text("$index")),
              //           ],
              //         ),
              //       ],
              //     ),
              //     subtitle: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text('Blood Group: ${cartItem['blood']}'),
              //         Text('Date of Birth: ${cartItem['dob']}'),
              //         Text('Order Number: ${cartItem['orderNumber']}'),
              //         Text('Price: ${cartItem['price']}'),
              //         Text('Primary Contact: ${cartItem['primaryContact']}'),
              //         Text(
              //             'Emergency Contact 1: ${cartItem['emergencyContact1']}'),
              //         Text(
              //             'Emergency Contact 2: ${cartItem['emergencyContact2']}'),
              //         Text('User Email: ${cartItem['userEmail']}'),
              //         Text('Pin Code: ${cartItem['pinCode']}'),
              //         Text('Address: ${cartItem['address']}'),
              //         Text('Order Date: ${cartItem['date']}'),
              //       ],
              //     ),
              //   ),
              // );
            }).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitCircle(color: Colors.blue),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final cards = snapshot.data ?? [];

              return ListView(
                children: cards,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blueColor,
        onPressed: _showRangeDialog,
        child: Icon(Icons.download),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.blueColor,
      //   onPressed: () async {
      //     setState(() {
      //       showDialog(
      //         barrierDismissible: false,
      //         context: context,
      //         builder: (context) => Center(
      //           child: SpinKitCircle(color: Colors.blue),
      //         ),
      //       );
      //     });

      //     try {
      //       await _createAndSavePDF(); // Use the global list to create PDF
      //     } catch (e) {
      //       Navigator.pop(context); // Close the loading dialog
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text('Error: ${e.toString()}'),
      //           backgroundColor: Colors.red,
      //         ),
      //       );
      //     }
      //   },
      //   child: Icon(Icons.download),
      // ),
    );
  }
}
