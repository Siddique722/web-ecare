
// import 'package:ecare/firebase_options.dart';
//
// import '../../constants/linker.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   // Create a Future to handle Firebase initialization and auth check
//   late Future<User?> _checkLogin;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLogin = _initializeFirebaseAndCheckAuth();
//   }
//
//   // Function to initialize Firebase and check user login status
//   Future<User?> _initializeFirebaseAndCheckAuth() async {
//     try {
//       // Initialize Firebase
//       await Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform);
//
//       // Check if user is logged in
//       User? user = FirebaseAuth.instance.currentUser;
//       return user;
//     } catch (e) {
//       // Handle error (e.g., Firebase initialization failed)
//       print("Error initializing Firebase: $e");
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<User?>(
//         future: _checkLogin,
//         builder: (context, snapshot) {
//           // While waiting for the future to resolve, show a splash screen
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/applogo.png',
//                     height: 90,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                       'Loading...'), // Optional: show loading text or indicator
//                 ],
//               ),
//             );
//           }
//
//           // When future is resolved, check if the user is logged in or not
//           if (snapshot.hasData) {
//             // User is logged in, navigate to WraperScreen
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.pushReplacement(
//                 context,
//                 CupertinoPageRoute(builder: (context) => WraperScreen()),
//               );
//             });
//           } else {
//             // User is not logged in, navigate to OnboardingScreen
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.pushReplacement(
//                 context,
//                 CupertinoPageRoute(builder: (context) => OnboardingScreen()),
//               );
//             });
//           }
//
//           // The splash screen will remain visible while navigation happens
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/applogo.png',
//                   height: 90,
//                 ),
//                 SizedBox(height: 20),
//                 Text('Redirecting...'), // Optional: show redirecting message
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/onboarding-views/onboarding-view.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 40000), () {
      isUserLOgin();
      //  Navigator.pushReplacement(context, CupertinoPageRoute(
      //  builder: (context)=>OnboardingScreen()));
    });
  }

  // check user login or not
  isUserLOgin()
  // async
  {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => OnboardingScreen()));
    } else {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => WraperScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // height: double.infinity,
              //width: double.infinity,
              child: Image.asset(
                  height: 140,
                  'assets/applogo.png' //AppImages.splash,fit: BoxFit.fill,
                  ),
            ),

            // SizedBox(
            //   height: 20,
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 18.0),
            //   child: Column(
            //     children: [
            //       Text(
            //         'powered by',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontFamily: "Gilroy",
            //         ),
            //       ),
            //       Text(
            //         'Company Name LTD',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 15.sp,
            //           fontWeight: FontWeight.bold,
            //           fontFamily: "GilroyBold",
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class LogoRowText extends StatelessWidget {
  const LogoRowText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('H',
            style: TextStyle(
              fontFamily: "GilroyBold",
              color: Color(0xffc2b7f0),
              fontSize: 35.sp,
            )),
        Text(
          ' Pulse',
          style: TextStyle(
              fontFamily: "Gilroy",
              color: Color(0xffa18feb),
              fontSize: 35.sp,
              fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
