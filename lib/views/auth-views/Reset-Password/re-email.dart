// import 'package:demo_app/constants/linker.dart';
//
//import 'package:demo_app/views/auth-views/Reset-Password/otp.dart';
// import 'package:flutter/cupertino.dart';

// class ReSetEmail extends StatefulWidget {
//   const ReSetEmail({super.key});

//   @override
//   State<ReSetEmail> createState() => _ReSetEmailState();
// }

// class _ReSetEmailState extends State<ReSetEmail> {
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = '';

//   _forgotPassword() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     try {
//       await FirebaseAuth.instance
//           .sendPasswordResetEmail(email: _emailController.text.trim());
//       Fluttertoast.showToast(
//         msg: "Email sent successfully",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//       Navigator.pushReplacement(
//           context, CupertinoPageRoute(builder: (context) => OTPScreen()));
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//       Fluttertoast.showToast(
//         msg: _errorMessage,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.network(
//             'https://images.unsplash.com/photo-1581159186721-b68b78da4ec9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxtZWRpY2luZXxlbnwwfHx8fDE3MTYwMDg3OTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           SizedBox(height: 100.h),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 140.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('E',
//                     style: TextStyle(
//                       fontFamily: "GilroyBold",
//                       color: AppColors.blueColor,
//                       fontSize: 30.sp,
//                     )),
//                 Text(
//                   ' Care',
//                   style: TextStyle(
//                       fontFamily: "Gilroy",
//                       color: AppColors.blueColor,
//                       fontSize: 30.sp,
//                       fontWeight: FontWeight.w900),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 180.h),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               height: 300.h,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.6),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('Re-Set Password',
//                           style: TextStyle(
//                             fontFamily: "GilroyBold",
//                             color: AppColors.blueColor,
//                             fontSize: 24.sp,
//                           )),
//                       SizedBox(height: 20.h),
//                       CustomTextFormField(
//                         hintText: 'Email',
//                         keyboardType: TextInputType.emailAddress,
//                         controller: _emailController,
//                       ),
//                       SizedBox(height: 20.h),
//                       if (_isLoading)
//                         SpinKitCircle(
//                           color: AppColors.blueColor,
//                           size: 50.0,
//                         )
//                       else
//                         InkWell(
//                           onTap: _forgotPassword,
//                           child: BlueButton(
//                             text: 'Next',
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:ecare/constants/linker.dart';
import 'package:flutter/cupertino.dart';

///-----------------
///
// import 'package:demo_app/constants/linker.dart';
// import 'package:demo_app/views/auth-views/Reset-Password/otp.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReSetEmail extends StatefulWidget {
  const ReSetEmail({super.key});

  @override
  State<ReSetEmail> createState() => _ReSetEmailState();
}

class _ReSetEmailState extends State<ReSetEmail> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';

  _forgotPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Fluttertoast.showToast(
        msg: "Email sent successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => OTPScreen()));
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1581159186721-b68b78da4ec9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxtZWRpY2luZXxlbnwwfHx8fDE3MTYwMDg3OTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('E',
                    style: TextStyle(
                      fontFamily: "GilroyBold",
                      color: AppColors.blueColor,
                      fontSize: 30.sp,
                    )),
                Text(
                  ' Care',
                  style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.blueColor,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 160.h),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Adjust the container height and width based on the screen size
                double containerHeight = constraints.maxHeight *
                    0.5; // Adjust container height dynamically
                double containerWidth = constraints.maxWidth *
                    1.0; // Adjust container width dynamically

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: containerHeight,
                  width: containerWidth,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Re-Set Password',
                              style: TextStyle(
                                fontFamily: "GilroyBold",
                                color: AppColors.blueColor,
                                fontSize: 24.sp,
                              )),
                          SizedBox(height: 20.h),
                          CustomTextFormField(
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          SizedBox(height: 20.h),
                          if (_isLoading)
                            SpinKitCircle(
                              color: AppColors.blueColor,
                              size: 50.0,
                            )
                          else
                            InkWell(
                              onTap: _forgotPassword,
                              child: BlueButton(
                                text: 'Next',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
