// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart'; // Import the file_picker package
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart'; // For opening PDF links

import 'dart:io';

import 'package:ecare/constants/linker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowDocuments extends StatefulWidget {
  final String folder;
  final String userID;
  final String document;
  String folderID;

  ShowDocuments({
    super.key,
    required this.document,
    required this.folderID,
    required this.folder,
    required this.userID,
  });

  @override
  State<ShowDocuments> createState() => _ShowDocumentsState();
}

// class _ShowDocumentsState extends State<ShowDocuments> {
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   XFile? _selectedFile;
//   bool _isLoading = false;
//   String _fileType = ''; // To store the type of the file selected
//
//   Future<void> _submitData() async {
//     if (_selectedFile == null ||
//         _nameController.text.isEmpty ||
//         _dobController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill all the fields and upload a file.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true; // Start loading
//     });
//
//     Navigator.pop(context); // Close the bottom sheet
//
//     try {
//       String fileUrl = '';
//       final file = File(_selectedFile!.path);
//       final fileName = '${DateTime.now().millisecondsSinceEpoch}.${_fileType}';
//       final storageRef = FirebaseStorage.instance.ref().child(
//           'folderData/${widget.userID}/$fileName');
//
//       print('Uploading file to ${storageRef.fullPath}');
//
//       final uploadTask = storageRef.putFile(file);
//
//       // Monitor upload progress
//       uploadTask.snapshotEvents.listen((event) {
//         print('Upload task event: ${event.state}');
//         print('Progress: ${event.bytesTransferred}/${event.totalBytes}');
//       }).onError((error) {
//         print('Upload task error: $error');
//       });
//
//       await uploadTask.whenComplete(() async {
//         fileUrl = await storageRef.getDownloadURL();
//         print('File uploaded successfully. File URL: $fileUrl');
//       });
//
//       final snapshot = await FirebaseFirestore.instance
//           .collection('folderData')
//           .where('userId', isEqualTo: widget.userID)
//           .get();
//
//       if (snapshot.docs.isNotEmpty) {
//         final folderDoc = snapshot.docs.first;
//
//         await folderDoc.reference.collection(widget.document).add({
//           'name': _nameController.text,
//           'description': _dobController.text,
//           'file': fileUrl,
//           'fileType': _fileType,
//           'documentType': widget.document,
//           'userId': widget.userID,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Document added successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('No matching user ID found.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error uploading file: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       print('Error uploading file: $e'); // Print the error for debugging
//     } finally {
//       setState(() {
//         _isLoading = false; // Stop loading after submission
//       });
//     }
//   }
//   Future<void> testUpload() async {
//     try {
//       final file = File('/path/to/your/file.jpg');
//       final storageRef = FirebaseStorage.instance.ref().child('testUpload/${DateTime.now().millisecondsSinceEpoch}.jpg');
//
//       print('Uploading file to ${storageRef.fullPath}');
//
//       await storageRef.putFile(file);
//       final fileUrl = await storageRef.getDownloadURL();
//       print('File uploaded successfully. File URL: $fileUrl');
//     } catch (e) {
//       print('Error uploading file: $e');
//     }
//   }
//
//   void _openBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             left: 16,
//             right: 16,
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 16),
//                 LightDarktextField(
//                   controller: _nameController,
//                   hintText: 'File name',
//                   keyboardType: TextInputType.text,
//                 ),
//                 SizedBox(height: 10),
//                 LightDarktextField(
//                   controller: _dobController,
//                   hintText: 'Description',
//                   keyboardType: TextInputType.text,
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton.icon(
//                       icon: Icon(Icons.file_upload),
//                       label: Text('Select Image'),
//                       onPressed: () async {
//                         try {
//                           final pickedFile = await _picker.pickImage(
//                               source: ImageSource.gallery);
//                           if (pickedFile != null) {
//                             setState(() {
//                               _selectedFile = pickedFile;
//                               _fileType = 'image'; // Set file type as image
//                             });
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Image selected successfully!'),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('No image selected.'),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );
//                           }
//                         } catch (e) {
//                           print('Error selecting image: $e');
//                         }
//                       },
//                     ),
//                     SizedBox(width: 8),
//                     ElevatedButton.icon(
//                       icon: Icon(Icons.picture_as_pdf),
//                       label: Text('Select PDF'),
//                       onPressed: () async {
//                         try {
//                           final pickedFile = await FilePicker.platform.pickFiles(
//                             type: FileType.custom,
//                             allowedExtensions: ['pdf'],
//                           );
//                           if (pickedFile != null) {
//                             setState(() {
//                               _selectedFile = XFile(pickedFile.files.single.path!);
//                               _fileType = 'pdf'; // Set file type as PDF
//                             });
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('PDF selected successfully!'),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('No PDF selected.'),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );
//                           }
//                         } catch (e) {
//                           print('Error selecting PDF: $e');
//                         }
//                       },
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//                 SizedBox(width: 8),
//                 InkWell(
//                   onTap: _submitData,
//                   child: BlueButton(width: 130, text: 'Submit'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(widget.document),
//       ),
//       body: _isLoading
//           ? Center(child: Text('Loading...'))
//           : StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('folderData')
//             .doc(widget.folderID)
//             .collection(widget.document)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No data available'));
//           }
//
//           final documents = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               final document = documents[index];
//               final name = document['name'] as String?;
//               final description = document['description'] as String?;
//               final fileUrl = document['file'] as String?;
//               final fileType = document['fileType'] as String?;
//
//               return Card(
//                 child: ListTile(
//                   leading: fileType == 'image'
//                       ? fileUrl != null ? Image.network(fileUrl) : null
//                       : Icon(Icons.picture_as_pdf),
//                   title: Text(name ?? ''),
//                   subtitle: Text(description ?? ''),
//                   onTap: () {
//                     if (fileType == 'pdf' && fileUrl != null) {
//                       // Open PDF file in web browser
//                       _launchURL(fileUrl);
//                     }
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueAccent.shade700,
//         onPressed: () => _openBottomSheet(context),
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Could not open the URL.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }

class _ShowDocumentsState extends State<ShowDocuments> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  XFile? _selectedFile;
  bool _isLoading = false;
  String _fileType = ''; // To store the type of the file selected
  Future<void> _submitData() async {
    if (_selectedFile == null || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all the fields and upload a file.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    Navigator.pop(context); // Close the bottom sheet

    try {
      String fileUrl = '';
      final file = File(_selectedFile!.path);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.${_fileType}';
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('folderData/${widget.userID}/$fileName');

      print('Uploading file to ${storageRef.fullPath}');

      final uploadTask = storageRef.putFile(file);

      // Monitor upload progress
      uploadTask.snapshotEvents.listen((event) {
        print('Upload task event: ${event.state}');
        print('Progress: ${event.bytesTransferred}/${event.totalBytes}');
      }).onError((error) {
        print('Upload task error: $error');
      });

      await uploadTask.whenComplete(() async {
        fileUrl = await storageRef.getDownloadURL();
        print('File uploaded successfully. File URL: $fileUrl');
      });

      // Get the current date in the format yyyy-MM-dd
      final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final snapshot = await FirebaseFirestore.instance
          .collection('folderData')
          .where('userId', isEqualTo: widget.userID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final folderDoc = snapshot.docs.first;

        await folderDoc.reference.collection(widget.document).add({
          'name': _nameController.text,
          'description': _dobController.text,
          'file': fileUrl,
          'fileType': _fileType,
          'documentType': widget.document,
          'userId': widget.userID,
          'dateAdded': currentDate, // Store the current date here
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No matching user ID found.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading file: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error uploading file: $e'); // Print the error for debugging
    } finally {
      setState(() {
        _isLoading = false; // Stop loading after submission
      });
    }
  }

  Future<void> _openFile(String fileUrl, String fileType) async {
    if (fileType == 'pdf') {
      if (await canLaunch(fileUrl)) {
        await launch(fileUrl); // Open the PDF URL in the browser
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open the PDF.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if (fileType == 'image') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewerScreen(imageUrl: fileUrl),
        ),
      );
    }
  }

  void _showEditDialog(
    String docId,
    String currentName,
  ) {
    final _editNameController = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Document'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _editNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              // TextFormField(
              //   controller: _editDescriptionController,
              //   decoration: InputDecoration(labelText: 'Description'),
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateDocument(
                  docId,
                  _editNameController.text,
                );
                Navigator.of(context).pop(); // Close the dialog after updating
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateDocument(String docId, String updatedName) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('folderData')
          .doc(widget.folderID)
          .collection(widget.document)
          .doc(docId);

      await docRef.update({
        'name': updatedName,
        // 'description': updatedDescription,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating document: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error updating document: $e'); // Print the error for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.document),
      ),
      body: _isLoading
          ? Center(child: Text('Loading...'))
          :
          // StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collection('folderData')
          //         .doc(widget.folderID)
          //         .collection(widget.document)
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //         return Center(child: Text('No data available'));
          //       }

          //       final documents = snapshot.data!.docs;

          //       return ListView.builder(
          //         itemCount: documents.length,
          //         itemBuilder: (context, index) {
          //           final document = documents[index];
          //           final name = document['name'] as String?;
          //           final description = document['description'] as String?;
          //           final fileUrl = document['file'] as String?;
          //           final fileType = document['fileType'] as String?;

          //           return Card(
          //             child: ListTile(
          //               leading: fileType == 'image'
          //                   ? fileUrl != null
          //                       ? Image.network(fileUrl)
          //                       : null
          //                   : Icon(
          //                       Icons.picture_as_pdf,
          //                       color: Colors.blueAccent.shade700,
          //                     ),
          //               title: Text(name ?? ''),
          //               subtitle: Text(description ?? ''),
          //               onTap: () {
          //                 if (fileUrl != null) {
          //                   _openFile(fileUrl, fileType ?? '');
          //                 }
          //               },
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('folderData')
                  .doc(widget.folderID)
                  .collection(widget.document)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data available'));
                }

                final documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    final name = document['name'] as String?;
                    //  final description = document['description'] as String?;
                    final fileUrl = document['file'] as String?;
                    final fileType = document['fileType'] as String?;
                    final date = document['dateAdded'] as String?;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: ListTile(
                          onLongPress: () async {
                            bool? confirmDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text(
                                      'Are you sure you want to delete this document?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            false); // Return false if canceled
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            true); // Return true if confirmed
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmDelete == true) {
                              // Close the confirmation dialog first
                              Navigator.of(context).pop();

                              // Show the loading dialog

                              try {
                                final docRef = FirebaseFirestore.instance
                                    .collection('folderData')
                                    .doc(widget.folderID)
                                    .collection(widget.document)
                                    .doc(document.id);

                                await docRef.delete();

                                // Close the loading dialog after successful deletion
                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Document deleted successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } catch (e) {
                                // Close the loading dialog if an error occurs
                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Failed to delete document: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },

                          // onLongPress: ()async
                          // {
                          //   final docRef = FirebaseFirestore.instance
                          //       .collection('folderData')
                          //       .doc(widget.folderID)
                          //       .collection(widget.document)
                          //       .doc(document.id);
                          // },
                          leading: fileType == 'image'
                              ? fileUrl != null
                                  ? Image.network(fileUrl)
                                  : null
                              : Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.blueAccent.shade700,
                                ),
                          title: Text(name ?? ''),
                          subtitle: Text(date ?? ''),
                          //  Column(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //   //  Text(description ?? ''),

                          //   ],
                          // ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(document.id, name ?? '');
                            },
                          ),
                          onTap: () {
                            if (fileUrl != null) {
                              _openFile(fileUrl, fileType ?? '');
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent.shade700,
        onPressed: () => _openDialogBox(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _openDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LightDarktextField(
                  controller: _nameController,
                  hintText: 'File name',
                  keyboardType: TextInputType.text,
                ),
                // SizedBox(height: 10),
                // LightDarktextField(
                //   controller: _dobController,
                //   hintText: 'Description',
                //   keyboardType: TextInputType.text,
                // ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              _selectedFile = pickedFile;
                              _fileType = 'image'; // Set file type as image
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Image selected successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No image selected.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          print('Error selecting image: $e');
                        }
                      },
                      icon: Icon(Icons.photo_size_select_actual_outlined),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          final pickedFile =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if (pickedFile != null) {
                            setState(() {
                              _selectedFile =
                                  XFile(pickedFile.files.single.path!);
                              _fileType = 'pdf'; // Set file type as PDF
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('PDF selected successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No PDF selected.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          print('Error selecting PDF: $e');
                        }
                      },
                      icon: Icon(Icons.picture_as_pdf),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: _submitData,
                  child: BlueButton(width: 130, text: 'Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String fileUrl;

  PDFViewerScreen({required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      body: PDFView(
        filePath: fileUrl,
      ),
    );
  }
}

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  ImageViewerScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Viewer')),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
