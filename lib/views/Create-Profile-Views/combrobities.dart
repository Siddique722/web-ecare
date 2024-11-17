

import 'package:ecare/constants/linker.dart';

import 'package:flutter/cupertino.dart';

class ComorbitiesView extends StatefulWidget {
  final String? role;
  final String? userID;
  final Map<String, dynamic>? userProfileData;

  ComorbitiesView({this.userProfileData, this.userID, this.role});

  @override
  State<ComorbitiesView> createState() => _ComorbitiesViewState();
}

// class _ComorbitiesViewState extends State<ComorbitiesView> {
//   String? selectedComorbidity1;
//   String? selectedComorbidity2;
//   String? selectedComorbidity3;
//   String? selectedComorbidity4;
//   String? selectedComorbidity5;
//   String? selectedComorbidity6;
//
//   List<String> _allComorbidities = [
//     'History of stroke/hemorrhage',
//     'Thyroid disease',
//     'Liver disease',
//     'Cancer',
//     'Hypertension',
//     'Pancreatic disease',
//     'Kidney disease',
//     'Cardiac disease',
//     'Diabetes',
//     'Dyslipidemia (cholesterol)',
//     'Unselect'
//   ];
//
//   List<String> _availableComorbidities1 = [];
//   List<String> _availableComorbidities2 = [];
//   List<String> _availableComorbidities3 = [];
//   List<String> _availableComorbidities4 = [];
//   List<String> _availableComorbidities5 = [];
//   List<String> _availableComorbidities6 = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _updateAvailableComorbidities();
//   }
//
//   void _updateAvailableComorbidities() {
//     List<String?> selectedComorbidities = [
//       selectedComorbidity1,
//       selectedComorbidity2,
//       selectedComorbidity3,
//       selectedComorbidity4,
//       selectedComorbidity5,
//       selectedComorbidity6,
//     ];
//     // Generate available options for each dropdown
//     _availableComorbidities1 = _allComorbidities
//         .where((item) =>
//             !selectedComorbidities.contains(item) ||
//             item == selectedComorbidity1)
//         .toList();
//     _availableComorbidities2 = _allComorbidities
//         .where((item) =>
//             !selectedComorbidities.contains(item) ||
//             item == selectedComorbidity2)
//         .toList();
//     _availableComorbidities3 = _allComorbidities
//         .where((item) =>
//             !selectedComorbidities.contains(item) ||
//             item == selectedComorbidity3)
//         .toList();
//     _availableComorbidities4 = _allComorbidities
//         .where((item) =>
//             !selectedComorbidities.contains(item) ||
//             item == selectedComorbidity4)
//         .toList();
//     _availableComorbidities5 = _allComorbidities
//         .where((item) =>
//             !selectedComorbidities.contains(item) ||
//             item == selectedComorbidity5)
//         .toList();
//     _availableComorbidities6 = _allComorbidities
//         .where((item) =>
//             !selectedComorbidities.contains(item) ||
//             item == selectedComorbidity6)
//         .toList();
//   }
//
//   void _storeUserData() {
//     Map<String, dynamic> comorbiditiesMap = {
//       'selectedComorbidity1': selectedComorbidity1 ?? '',
//       'selectedComorbidity2': selectedComorbidity2 ?? '',
//       'selectedComorbidity3': selectedComorbidity3 ?? '',
//       'selectedComorbidity4': selectedComorbidity4 ?? '',
//       'selectedComorbidity5': selectedComorbidity5 ?? '',
//       'selectedComorbidity6': selectedComorbidity6 ?? '',
//       'userId': widget.userID,
//     };
//     print('_storeUserData=$comorbiditiesMap');
//     Navigator.push(
//       context,
//       CupertinoPageRoute(
//         builder: (context) => AlergicMedications(
//           role: widget.role!,
//           userId: widget.userID!,
//           userProfileData: widget.userProfileData!,
//           comorbiditiesData: comorbiditiesMap,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Create Profile'),
//         actions: [
//           TextButton(
//             onPressed: _storeUserData,
//             child: Text(
//               'Skip',
//               style: TextStyle(color: Colors.blueAccent.shade700),
//             ),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Determine whether we're on a mobile device or a larger screen (like a web browser)
//           double width = constraints.maxWidth;
//           bool isWeb = width > 600;
//
//           return SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: 20.0,
//                 horizontal:
//                     isWeb ? width * 0.2 : 16.0, // Dynamic padding for web
//               ),
//               child: Column(
//                 children: [
//                   BoldTextWidgetTheme(text: 'Comorbidities'),
//                   SimpleTextWidgetTheme(
//                     text: '(diseases or medical conditions in a person)',
//                   ),
//                   // Dropdown 1
//                   LighDarkDropDown(
//                     hint: 'Please select',
//                     items: _availableComorbidities1,
//                     value: selectedComorbidity1,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == 'Unselect') {
//                           selectedComorbidity1 = null; // Reset the selection
//                         } else {
//                           selectedComorbidity1 = value;
//                         }
//                         _updateAvailableComorbidities();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 15.0),
//                   // Dropdown 2
//                   LighDarkDropDown(
//                     hint: 'Please select',
//                     items: _availableComorbidities2,
//                     value: selectedComorbidity2,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == 'Unselect') {
//                           selectedComorbidity2 = null; // Reset the selection
//                         } else {
//                           selectedComorbidity2 = value;
//                         }
//                         _updateAvailableComorbidities();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 15.0),
//                   // Dropdown 3
//                   LighDarkDropDown(
//                     hint: 'Please select',
//                     items: _availableComorbidities3,
//                     value: selectedComorbidity3,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == 'Unselect') {
//                           selectedComorbidity3 = null; // Reset the selection
//                         } else {
//                           selectedComorbidity3 = value;
//                         }
//                         _updateAvailableComorbidities();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 15.0),
//                   // Dropdown 4
//                   LighDarkDropDown(
//                     hint: 'Please select',
//                     items: _availableComorbidities4,
//                     value: selectedComorbidity4,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == 'Unselect') {
//                           selectedComorbidity4 = null; // Reset the selection
//                         } else {
//                           selectedComorbidity4 = value;
//                         }
//                         _updateAvailableComorbidities();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 15.0),
//                   // Dropdown 5
//                   LighDarkDropDown(
//                     hint: 'Please select',
//                     items: _availableComorbidities5,
//                     value: selectedComorbidity5,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == 'Unselect') {
//                           selectedComorbidity5 = null; // Reset the selection
//                         } else {
//                           selectedComorbidity5 = value;
//                         }
//                         _updateAvailableComorbidities();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 15.0),
//                   // Dropdown 6
//                   LighDarkDropDown(
//                     hint: 'Please select',
//                     items: _availableComorbidities6,
//                     value: selectedComorbidity6,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == 'Unselect') {
//                           selectedComorbidity6 = null; // Reset the selection
//                         } else {
//                           selectedComorbidity6 = value;
//                         }
//                         _updateAvailableComorbidities();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 30.0),
//                   InkWell(
//                     onTap: _storeUserData,
//                     child: BlueButton(
//                       text: 'Next',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class _ComorbitiesViewState extends State<ComorbitiesView> {
  String? selectedComorbidity1;
  String? selectedComorbidity2;
  String? selectedComorbidity3;
  String? selectedComorbidity4;
  String? selectedComorbidity5;
  String? selectedComorbidity6;

  List<String> _allComorbidities = [
    'History of stroke/hemorrhage',
    'Thyroid disease',
    'Liver disease',
    'Cancer',
    'Hypertension',
    'Pancreatic disease',
    'Kidney disease',
    'Cardiac disease',
    'Diabetes',
    'Dyslipidemia (cholesterol)',
    'Unselect'
  ];

  List<String> _availableComorbidities1 = [];
  List<String> _availableComorbidities2 = [];
  List<String> _availableComorbidities3 = [];
  List<String> _availableComorbidities4 = [];
  List<String> _availableComorbidities5 = [];
  List<String> _availableComorbidities6 = [];

  @override
  void initState() {
    super.initState();
    _updateAvailableComorbidities();
  }

  void _updateAvailableComorbidities() {
    List<String?> selectedComorbidities = [
      selectedComorbidity1,
      selectedComorbidity2,
      selectedComorbidity3,
      selectedComorbidity4,
      selectedComorbidity5,
      selectedComorbidity6,
    ];
    // Generate available options for each dropdown
    _availableComorbidities1 = _allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity1)
        .toList();
    _availableComorbidities2 = _allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity2)
        .toList();
    _availableComorbidities3 = _allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity3)
        .toList();
    _availableComorbidities4 = _allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity4)
        .toList();
    _availableComorbidities5 = _allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity5)
        .toList();
    _availableComorbidities6 = _allComorbidities
        .where((item) =>
            !selectedComorbidities.contains(item) ||
            item == selectedComorbidity6)
        .toList();
  }

  void _storeUserData() {
    Map<String, dynamic> comorbiditiesMap = {
      'selectedComorbidity1': selectedComorbidity1 ?? '',
      'selectedComorbidity2': selectedComorbidity2 ?? '',
      'selectedComorbidity3': selectedComorbidity3 ?? '',
      'selectedComorbidity4': selectedComorbidity4 ?? '',
      'selectedComorbidity5': selectedComorbidity5 ?? '',
      'selectedComorbidity6': selectedComorbidity6 ?? '',
      'userId': widget.userID,
    };
    print('_storeUserData=$comorbiditiesMap');
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AlergicMedications(
          role: widget.role,
          userId: widget.userID,
          userProfileData: widget.userProfileData,
          comorbiditiesData: comorbiditiesMap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: BoldTextWidgetTheme(text: 'Create Profile'),
        actions: [
          TextButton(
            onPressed: _storeUserData,
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.blueAccent.shade700),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            children: [
              BoldTextWidgetTheme(text: 'Comorbidities'),
              SimpleTextWidgetTheme(
                text: '(diseases or medical conditions in a person)',
              ),
              // Dropdown 1
              LighDarkDropDown(
                hint: 'Please select',
                items: _availableComorbidities1,
                value: selectedComorbidity1,
                onChanged: (value) {
                  setState(() {
                    if (value == 'Unselect') {
                      selectedComorbidity1 = null; // Reset the selection
                    } else {
                      selectedComorbidity1 = value;
                    }
                    _updateAvailableComorbidities();
                  });
                  // selectedComorbidity1 = value;
                  // _updateAvailableComorbidities();
                  //  });
                },
              ),
              // Dropdown 2
              LighDarkDropDown(
                hint: 'Please select',
                items: _availableComorbidities2,
                value: selectedComorbidity2,
                onChanged: (value) {
                  setState(() {
                    // selectedComorbidity2 = value;
                    // _updateAvailableComorbidities();
                    if (value == 'Unselect') {
                      selectedComorbidity2 = null; // Reset the selection
                    } else {
                      selectedComorbidity2 = value;
                    }
                    _updateAvailableComorbidities();
                  });
                  //           });
                },
              ),
              // Dropdown 3
              LighDarkDropDown(
                hint: 'Please select',
                items: _availableComorbidities3,
                value: selectedComorbidity3,
                onChanged: (value) {
                  setState(() {
                    if (value == 'Unselect') {
                      selectedComorbidity3 = null; // Reset the selection
                    } else {
                      selectedComorbidity3 = value;
                    }
                    _updateAvailableComorbidities();
                    // });
                    //selectedComorbidity3 = value;
                    //_updateAvailableComorbidities();
                  });
                },
              ),
              // Dropdown 4
              LighDarkDropDown(
                hint: 'Please select',
                items: _availableComorbidities4,
                value: selectedComorbidity4,
                onChanged: (value) {
                  setState(() {
                    if (value == 'Unselect') {
                      selectedComorbidity4 = null; // Reset the selection
                    } else {
                      selectedComorbidity4 = value;
                    }
                    _updateAvailableComorbidities();
                  });
                  //selectedComorbidity4 = value;
                  //_updateAvailableComorbidities();
                  //});
                },
              ),
              // Dropdown 5
              LighDarkDropDown(
                hint: 'Please select',
                items: _availableComorbidities5,
                value: selectedComorbidity5,
                onChanged: (value) {
                  setState(() {
                    if (value == 'Unselect') {
                      selectedComorbidity5 = null; // Reset the selection
                    } else {
                      selectedComorbidity5 = value;
                    }
                    _updateAvailableComorbidities();
                  });
                  //selectedComorbidity5 = value;
                  // _updateAvailableComorbidities();
                  // });
                },
              ),
              // Dropdown 6
              LighDarkDropDown(
                hint: 'Please select',
                items: _availableComorbidities6,
                value: selectedComorbidity6,
                onChanged: (value) {
                  setState(() {
                    if (value == 'Unselect') {
                      selectedComorbidity6 = null; // Reset the selection
                    } else {
                      selectedComorbidity6 = value;
                    }
                    _updateAvailableComorbidities();
                  });
                  //selectedComorbidity6 = value;
                  // _updateAvailableComorbidities();
                  // });
                },
              ),
              InkWell(
                onTap: _storeUserData,
                child: BlueButton(
                  text: 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
