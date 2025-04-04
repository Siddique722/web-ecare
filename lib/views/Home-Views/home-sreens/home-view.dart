// import 'package:demo_app/TODo-Bloc/repository/todo_repo.dart';
import 'package:ecare/views/Admin-View/admin-view.dart';
import 'package:ecare/views/Home-Views/Docuemnts/show-folder.dart';
import 'package:ecare/views/Home-Views/Scan-QR-Code/qr-code.dart';
import 'package:ecare/views/Home-Views/Users-View/show-users.dart';
import 'package:ecare/views/Home-Views/about-us.dart';
import 'package:ecare/views/Home-Views/ambulance-view/ambulance.dart';
import 'package:ecare/views/Home-Views/conslt-doctor.dart';
import 'package:ecare/views/Home-Views/contact.dart';
import 'package:ecare/views/Home-Views/home-sreens/costum-drawer.dart';
import 'package:ecare/views/Home-Views/home-sreens/home-back-screen.dart';
import 'package:ecare/views/Home-Views/home-sreens/widgets/container-button-widget.dart';
import 'package:ecare/views/Home-Views/home-sreens/widgets/notification-widget.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as dev;

import 'package:ecare/constants/linker.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// class _HomeViewState extends State<HomeView> {
//   String _userName = '';
//   String userID = '';
//   String userEmail = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchUserName(); // This will be called whenever dependencies change, i.e., on every rebuild or navigation back to this screen.
//   }

//   @override
//   void didUpdateWidget(covariant HomeView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     _fetchUserName(); // Called when the widget is updated.
//   }

//   Future<void> _fetchPendingRequestsCount(String email) async {
//     print('============================================');
//     print('User Email=$email\n================================');
//     final requestDocs = await FirebaseFirestore.instance
//         .collection('authenticationRequests')
//         .where('email', isEqualTo: email)
//         .where('status', isEqualTo: 'pending')
//         .get();
//     print('Request docs=$requestDocs');
//     print(requestDocs.docs.length);
//     print('Pending request:$_pendingRequestsCount');
//     setState(() {
//       _pendingRequestsCount = requestDocs.docs.length;
//     });
//   }

//   int _pendingRequestsCount = 0;

//   Future<void> _fetchUserName() async {
//     userEmail = (await FirebaseAuth.instance.currentUser?.email)!;
//     userID = await FirebaseAuth.instance.currentUser!.uid;
//     _fetchPendingRequestsCount(userEmail);
//     print("Email=$userEmail");
//     final userDoc = await FirebaseFirestore.instance
//         .collection('UsersData')
//         .where('userEmail', isEqualTo: userEmail)
//         .get();
//     if (userDoc.docs.isNotEmpty) {
//       setState(() {
//         _userName = userDoc.docs.first['userName'];
//       });
//     }
//   }

//   Future<void> _handleUserRequest() async {
//     // Here we assume you have a Firestore collection for handling user requests
//     final requestDoc = await FirebaseFirestore.instance
//         .collection('authenticationRequests')
//         .where('email', isEqualTo: userEmail)
//         .get();

//     if (requestDoc.docs.isNotEmpty) {
//       // Logic to process the request
//       final requestData = requestDoc.docs.first.data();

//       // Assuming the request has a type and status
//       if (requestData['requestType'] == 'authentication' ||
//           requestData['status'] == 'pending') {
//         // Perform authentication logic here
//         // Example: Authenticate user, update Firestore request status
//         await FirebaseFirestore.instance
//             .collection('authenticationRequests')
//             .doc(requestDoc.docs.first.id)
//             .update({'status': 'approved'});
//         Fluttertoast.showToast(
//             msg: "User authenticated successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             backgroundColor: Colors.green,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       }
//     } else {
//       Fluttertoast.showToast(
//           msg: "No pending request found",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(

//         body: Stack(
//           children: [
//             const BackScreen(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 70.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         BoldTextWidget(
//                           text: 'Welcome: $_userName',
//                           textColor: Colors.white,
//                           textsize: 18,
//                         ),
//                         Row(
//                           children: [
//                             Stack(
//                               children: [
//                                 IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(Icons.notifications)),
//                                 if (_pendingRequestsCount >= 0) ...[
//                                   Positioned(
//                                     right: 0,
//                                     top: 0,
//                                     child: CircleAvatar(
//                                       backgroundColor: Colors.red,
//                                       radius: 10,
//                                       child: Text(
//                                         '$_pendingRequestsCount',
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 12),
//                                       ),
//                                     ),
//                                   ),
//                                 ]
//                               ],
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 _showLogoutBottomSheet(context);
//                               },
//                               icon:
//                                   const Icon(Icons.logout, color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30.h),
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                               builder: (context) => const ScanQRCodeHomw()),
//                         );
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         height: 50.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.7),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.person_search_outlined),
//                             Text('Find User'),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 90.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (context) => ShowUsersView(
//                                           role: 'edit',
//                                           userid: userID,
//                                         )));
//                           },
//                           child: _container('Users', 'user'),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const FoldersView()),
//                             );
//                           },
//                           child: _container('Documents', 'docs'),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (context) =>
//                                         const ConsultDoctor()));
//                           },
//                           child: _container('Consult\nDoctor', 'doctor'),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (context) =>
//                                         const AmbulanceView()));
//                           },
//                           child: _container('Ambulance', 'ambulance'),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (context) => const Contact()));
//                           },
//                           child: _container('Contact Us', 'contact'),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (context) => const AboutUs()));
//                           },
//                           child: _container('About Us', 'about'),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     userEmail == 'thomasjosephthiruthanathil@gmail.com'
//                         ? InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                       builder: (context) => AdminView()));
//                             },
//                             child: BlueButton(text: 'Admin'),
//                           )
//                         : SizedBox(),
//                     // New Button for User Requests

//                     // InkWell(
//                     //   onTap: () {
//                     //     print('button pressing--------------');
//                     //     Navigator.push(
//                     //         context,
//                     //         CupertinoPageRoute(
//                     //             builder: (context) => PendingRequestsScreen(
//                     //                 userID:
//                     //                     userEmail))); // Handle request logic here
//                     //   },
//                     //   child: Stack(
//                     //     children: [
//                     //       BlueButton(text: 'Handle User Request'),
//                     //       if (_pendingRequestsCount >= 0) ...[
//                     //         Positioned(
//                     //           right: 0,
//                     //           top: 0,
//                     //           child: CircleAvatar(
//                     //             backgroundColor: Colors.red,
//                     //             radius: 10,
//                     //             child: Text(
//                     //               '$_pendingRequestsCount',
//                     //               style: const TextStyle(
//                     //                   color: Colors.white, fontSize: 12),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       ]
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _container(String text, String image) {
//     return Container(
//       height: 100.h,
//       width: 100.w,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, offset: Offset(1, 1)),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image(
//             image: AssetImage('lib/assets/images/$image.png'),
//             height: 45,
//           ),
//           Text(
//             text,
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

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
// }

///---------------------------------------------------
///
class _HomeViewState extends State<HomeView> {
  String _userName = '';
  String userEmail = '';
  String userId = '';
  int _pendingRequestsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    //TodoRepo todoRepo = TodoRepo();
    //var famUser = todoRepo.getFamilyUser();
    //dev.log("$famUser");
    //log('Number of documents in familyUser collection: ${familyUserDocs.docs.length}');
    userEmail = (await FirebaseAuth.instance.currentUser?.email)!;
    userId = (await FirebaseAuth.instance.currentUser?.uid)!;
    final userDoc = await FirebaseFirestore.instance
        .collection('UsersData')
        .where('userEmail', isEqualTo: userEmail)
        .get();
    if (userDoc.docs.isNotEmpty) {
      setState(() {
        _userName = userDoc.docs.first['userName'];
      });
    }
    _fetchPendingRequestsCount(userEmail);
  }

  Future<void> _fetchPendingRequestsCount(String email) async {
    final requestDocs = await FirebaseFirestore.instance
        .collection('authenticationRequests')
        .where('email', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .get();
    setState(() {
      _pendingRequestsCount = requestDocs.docs.length;
    });
  }

  bool _isLoading = false;
  void _handleDeleteAccount() async {
    final bool? confirmDeletion = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User cancels
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirms
                Navigator.pushReplacement(
                    context,
                    CupertinoDialogRoute(
                        builder: (context) => LoginView(), context: context));
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDeletion == true) {
      // User confirmed deletion
      setState(() {
        _isLoading = true;
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.delete();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account deleted successfully!")),
          );
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => const LoginView()),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'requires-recent-login') {
          errorMessage = "You need to re-login before deleting your account.";
        } else {
          errorMessage = "An error occurred. Please try again.";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An unexpected error occurred.")),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'What would you like to do?',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        onLogoutAccount: () {
          _showLogoutBottomSheet(context);
        },
        onDeleteAccount: _handleDeleteAccount,
        userId: userId,
        userName: _userName,
        userEmail: userEmail,
      ),
      body: Stack(
        children: [
          const BackScreen(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _isLoading
                ? const Center(
                    child: AppLoading(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Wrap the IconButton in a Builder widget to get the correct Scaffold context
                            Builder(
                              builder: (context) => IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  Scaffold.of(context)
                                      .openDrawer(); // This now works correctly
                                },
                              ),
                            ),

                            // Flexible will ensure that the text wraps to the next line if needed
                            Flexible(
                              child: BoldTextWidget(
                                text: 'Welcome: $_userName',
                                textColor: Colors.white,
                                baseTextSize: 18,
                                overflow: TextOverflow
                                    .visible, // Ensure the text can wrap
                              ),
                            ),

                            Row(
                              children: [
                                NotificationIcon(
                                  userID: userEmail,
                                  pendingRequestsCount: _pendingRequestsCount,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        _buildFindUserButton(),
                        SizedBox(height: 90.h),
                        _buildMainButtons(),
                        SizedBox(height: 20.h),
                        _buildSecondaryButtons(),
                        SizedBox(height: 20.h),
                        userEmail == 'thomasjosephthiruthanathil@gmail.com'
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => AdminView()));
                                },
                                child: BlueButton(text: 'Admin'),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // appBar: AppBar(
  //     //   title: const Text('Home'),

  //     // ),
  //     drawer: CustomDrawer(
  //       userName: _userName,
  //       userEmail: userEmail,
  //     ),
  //     body: Stack(
  //       children: [
  //         const BackScreen(),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 SizedBox(height: 40.h),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     IconButton(
  //                       icon: const Icon(Icons.menu),
  //                       onPressed: () {
  //                         Scaffold.of(context).openDrawer();
  //                       },
  //                     ),
  //                     BoldTextWidget(
  //                       text: 'Welcome: $_userName',
  //                       textColor: Colors.white,
  //                       textsize: 18,
  //                     ),
  //                     Row(
  //                       children: [
  //                         NotificationIcon(
  //                             pendingRequestsCount: _pendingRequestsCount),
  //                         // IconButton(
  //                         //   onPressed: () {
  //                         //     _showLogoutBottomSheet(context);
  //                         //   },
  //                         //   icon: const Icon(Icons.logout, color: Colors.white),
  //                         // ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 30.h),
  //                 _buildFindUserButton(),
  //                 SizedBox(height: 90.h),
  //                 _buildMainButtons(),
  //                 SizedBox(height: 20.h),
  //                 _buildSecondaryButtons(),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFindUserButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const ScanQRCodeHomw()));
      },
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search_outlined),
            Text('Find User'),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ContainerButton(
          text: 'Users',
          image: 'user',
          onTap: () {
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (context) =>
                        ShowUsersView(role: 'edit', userid: userId),
                    context: context));
          },
        ),
        ContainerButton(
          text: 'Documents',
          image: 'docs',
          onTap: () {
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (context) => const FoldersView(),
                    context: context));
          },
        ),
        ContainerButton(
          text: 'Consult Doctor',
          image: 'doctor',
          onTap: () {
            Navigator.push(
              context,
              CupertinoDialogRoute(
                  builder: (context) => const ConsultDoctor(),
                  context: context),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSecondaryButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ContainerButton(
          text: 'Ambulance',
          image: 'ambulance',
          onTap: () {
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (context) =>  AmbulanceView(),
                    context: context));
          },
        ),
        ContainerButton(
          text: 'Contact Us',
          image: 'contact',
          onTap: () {
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (context) => const Contact(), context: context));
          },
        ),
        ContainerButton(
          text: 'About Us',
          image: 'about',
          onTap: () {
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (context) => const AboutUs(), context: context));
          },
        ),
      ],
    );
  }
}
