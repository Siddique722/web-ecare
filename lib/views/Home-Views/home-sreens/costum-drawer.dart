// // import 'package:demo_app/constants/linker.dart';
// // import 'package:demo_app/views/Home-Views/home-sreens/Affiliating/affiliate-home.dart';
//  import 'package:ecare/views/Home-Views/home-sreens/Affiliating/affiliate-home.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'package:ecare/constants/linker.dart';
//
// class CustomDrawer extends StatelessWidget {
//   final String userName;
//   final String userEmail;
//
//   const CustomDrawer({
//     Key? key,
//     required this.userName,
//     required this.userEmail,
//   }) : super(key: key);
//   void _showLogoutBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).brightness == Brightness.dark
//           ? Colors.grey[900]
//           : Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.all(20.h),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'What would you like to do?',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: () async {
//                       await FirebaseAuth.instance.signOut();
//                       Navigator.pushReplacement(
//                           context,
//                           CupertinoPageRoute(
//                               builder: (context) => const LoginView()));
//                     },
//                     child: Text(
//                       'Logout',
//                       style: TextStyle(fontSize: 16.sp),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(fontSize: 16.sp),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: AppColors.blueColor, //Theme.of(context).primaryColor,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.white,
//                   backgroundImage: AssetImage('asstes/applogo.png'),
//                   // child: Icon(Icons.person, size: 50, color: Theme.of(context).primaryColor),
//                 ),
//                 SizedBox(height: 10),
//                 Text(userName,
//                     style: TextStyle(color: Colors.white, fontSize: 18)),
//                 Text(userEmail,
//                     style: TextStyle(color: Colors.white, fontSize: 14)),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text('Home'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Profile Screen
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.pie_chart),
//             title: Text('Affiliate'),
//             onTap: () {
//               // Navigate to Settings Screen
//               Navigator.pop(context);
//               Navigator.push(
//                   context,
//                   CupertinoDialogRoute(
//                       builder: (context) => AffliateHome(), context: context));
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//               _showLogoutBottomSheet(context);
//               // Call logout functionality here
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


///---------------------------------------------
///

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/Home-Views/home-sreens/Affiliating/affiliate-home.dart';
import 'package:ecare/views/Home-Views/home-sreens/Privacy%20Policy/privacyPolicy.dart';
import 'package:ecare/views/Home-Views/home-sreens/Refund%20Policy/refund-policy.dart';
import 'package:ecare/views/Home-Views/home-sreens/TermsAndConditions/termsandconditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userId;
  final VoidCallback onDeleteAccount;
  final VoidCallback onLogoutAccount;
  const CustomDrawer({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.userId,
    required this.onDeleteAccount,
    required this.onLogoutAccount,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isLoading = false;

  /// Show Logout Bottom Sheet
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.blueColor, // Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/applogo.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.userName,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      widget.userEmail,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.pie_chart),
              //   title: const Text('Affiliate'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       CupertinoDialogRoute(
              //         builder: (context) => AffliateHome(),
              //         context: context,
              //       ),
              //     );
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.rule),
                title: const Text('Privacy Policy'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoDialogRoute(
                      builder: (context) => PrivacyPolicyScreen(),
                      context: context,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Terms & Conditions'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoDialogRoute(
                      builder: (context) => TermsAndCondition(),
                      context: context,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.rule_folder_rounded),
                title: const Text('Cancellation and refund policy'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoDialogRoute(
                      builder: (context) => RefundPolicy(),
                      context: context,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Account'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onDeleteAccount();
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  widget
                      .onLogoutAccount(); // Corrected from widget.onDeleteAccount
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
