// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

import 'package:ecare/constants/linker.dart';

class FoldersView extends StatefulWidget {
  const FoldersView({super.key});

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> {
  final TextEditingController _folderNameController = TextEditingController();

  Future<void> _createFolder() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final folderName = _folderNameController.text.trim();
      if (folderName.isNotEmpty) {
        String folderid = DateTime.now().millisecondsSinceEpoch.toString();
        await FirebaseFirestore.instance
            .collection('folderData')
            .doc(folderid)
            .set({
          'userId': currentUser.uid,
          'folderName': folderName,
          'folderID': folderid
        });
        _folderNameController.clear();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Folders'),
      ),
      body: currentUser == null
          ? Center(child: Text('No user logged in'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('folderData')
                  .where('userId', isEqualTo: currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No folders available'));
                }
                final folders = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    final folder =
                        folders[index].data() as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => DocumentView(
                                        folderid: folder['folderID'],
                                        folder: folder['folderName'],
                                        userId: folder['userId'],
                                      )));
                        },
                        title: Text('Folder Name:${folder['folderName']}'),
                        leading: Icon(
                          Icons.folder_copy,
                          color: Colors.blueAccent,
                        ),
                        // subtitle: Text(folder['userId']),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent.shade700,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // This makes the bottom sheet full screen
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom, // Adjusts for the keyboard
                ),
                child: SingleChildScrollView(
                  // Wrap content in SingleChildScrollView
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      LightDarktextField(
                          controller: _folderNameController,
                          hintText: 'Create Folder Name',
                          keyboardType: TextInputType.text)
                      // TextField(
                      //   controller: _folderNameController,
                      //   decoration:
                      //       InputDecoration(labelText: 'Create Folder Name'),
                      // ),
                      ,
                      SizedBox(height: 16),
                      // ElevatedButton(
                      //   onPressed: _createFolder,
                      //   child: Text('Save'),
                      // ),
                      InkWell(
                          onTap: _createFolder, child: BlueButton(text: 'Save'))
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
