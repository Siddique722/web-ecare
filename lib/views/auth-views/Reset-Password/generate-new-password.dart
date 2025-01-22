// import 'package:hpulse/views/Home-Views/Nav-Bar/nav-bar-.dart';
// import 'package:hpulse/widgets/blue-button.dart';
// import 'package:hpulse/widgets/custom-textfieldwidget.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hpulse/constants/colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:hpulse/constants/linker.dart';
//
// import 'package:flutter/material.dart';
// import 'package:hpulse/constants/colors.dart';
// import 'package:hpulse/widgets/blue-button.dart';
// import 'package:hpulse/widgets/custom-textfieldwidget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:ecare/constants/linker.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String _errorMessage = '';

  _forgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.toString());
      print('email send successfully');
    } catch (e) {
      print('Error:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if the screen width is larger than 600px for web/tablet
          bool isMobile = constraints.maxWidth < 600;

          return Stack(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1581159186721-b68b78da4ec9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxtZWRpY2luZXxlbnwwfHx8fDE3MTYwMDg3OTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 140.h : 100.h, // Adjusted for mobile/web
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('H',
                        style: TextStyle(
                          fontFamily: "GilroyBold",
                          color: AppColors.blueColor,
                          fontSize: isMobile ? 30.sp : 40.sp,
                        )),
                    Text(
                      ' Pulse',
                      style: TextStyle(
                          fontFamily: "Gilroy",
                          color: AppColors.blueColor,
                          fontSize: isMobile ? 30.sp : 40.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 200.h),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height:
                      isMobile ? 600.h : 500.h, // Adjust height for mobile/web
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Generate New Password',
                              style: TextStyle(
                                fontFamily: "GilroyBold",
                                color: AppColors.blueColor,
                                fontSize: isMobile
                                    ? 24.sp
                                    : 28.sp, // Adjust font size
                              )),
                          SizedBox(height: 20.h),
                          CustomTextFormField(
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          SizedBox(height: 20.h),
                          if (_errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                _errorMessage,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          if (_isLoading)
                            SpinKitCircle(
                              color: AppColors.blueColor,
                              size: 50.0,
                            )
                          else
                            InkWell(
                              onTap: () {
                                _forgotPassword();
                              },
                              child: BlueButton(
                                text: 'Generate',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



// class NewPassword extends StatefulWidget {
//   const NewPassword({super.key});

//   @override
//   State<NewPassword> createState() => _NewPasswordState();
// }

// class _NewPasswordState extends State<NewPassword> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool _isLoading = false;
//   String _errorMessage = '';
//   _forgotPassword() async {
//     try {
//       await FirebaseAuth.instance
//           .sendPasswordResetEmail(email: _emailController.text.toString());
//       print('email send successfully');
//     } catch (e) {
//       print('Error:$e');
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
//               height: 600.h, //double.infinity,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(20)),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('Generate New Password',
//                           style: TextStyle(
//                             fontFamily: "GilroyBold",
//                             color: AppColors.blueColor,
//                             fontSize: 24.sp,
//                           )),
//                       SizedBox(height: 20.h),
//                       CustomTextFormField(
//                         hintText: 'Password',
//                         keyboardType: TextInputType.emailAddress,
//                         controller: _emailController,
//                       ),
//                       SizedBox(height: 20.h),
//                       if (_errorMessage.isNotEmpty)
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10.0),
//                           child: Text(
//                             _errorMessage,
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       if (_isLoading)
//                         SpinKitCircle(
//                           color: AppColors.blueColor,
//                           size: 50.0,
//                         )
//                       else
//                         InkWell(
//                           onTap: () {
//                             //_login();
//                           },
//                           child: BlueButton(
//                             text: 'Generate',

//                             //  onPressed: ,
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
