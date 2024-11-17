//import 'package:demo_app/views/Home-Views/Documents-View/show-documents.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';

import 'package:ecare/constants/linker.dart';
import 'package:flutter/cupertino.dart';

class DocumentView extends StatefulWidget {
  String folder;
  String userId;
  String folderid;
  DocumentView(
      {super.key,
      required this.folder,
      required this.userId,
      required this.folderid});

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Documents', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.local_hospital, color: Colors.blue),
              title: Text('Medicine Prescriptions'),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ShowDocuments(
                              folderID: widget.folderid,
                              document: 'medicine',
                              folder: widget.folder,
                              userID: widget.userId,
                            )));
                // Handle tap
              },
            ),
          ),
          Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.analytics, color: Colors.blue),
              title: Text('Lab Reports'),
              onTap: () {
                // Handle tap
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ShowDocuments(
                              folderID: widget.folderid,
                              document: 'lab',
                              folder: widget.folder,
                              userID: widget.userId,
                            )));
              },
            ),
          ),
          Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.scanner, color: Colors.blue),
              title: Text('Scan Reports'),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ShowDocuments(
                              folderID: widget.folderid,
                              document: 'scan',
                              folder: widget.folder,
                              userID: widget.userId,
                            )));

                // Handle tap
              },
            ),
          ),
        ],
      ),
    );
  }
}
