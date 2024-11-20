import 'dart:io'; // Import dart:io to detect platform
import 'package:ecare/constants/colors.dart';
import 'package:ecare/main.dart';
import 'package:ecare/views/auth-views/signup-view.dart';
import 'package:ecare/widgets/blue-button.dart';
import 'package:ecare/widgets/custom-textfieldwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:ecare/constants/linker.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import dart:io to detect platform
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoadingg = false;
  bool isLoading = false;





  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    //  if (_formKey.currentState?.validate() ?? false) {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => NavBarExample()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    // }
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
            padding: EdgeInsets.symmetric(vertical: 135.h),
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
                  '-Care',
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
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 180.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 600.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Text('Login',
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
                      CustomTextFormField(
                        hintText: 'Password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => ReSetEmail()));
                            },
                            child: Text('Forget Password?',
                                style: TextStyle(
                                  fontFamily: "GilroyBold",
                                  color: AppColors.blueColor,
                                  fontSize: 14.sp,
                                )),
                          ),
                        ],
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
                        AppLoading()
                      else
                        InkWell(
                          onTap: _login,
                          child: BlueButton(text: 'Login'),
                        ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?',
                              style: TextStyle(
                                fontFamily: "GilroyBold",
                                color: AppColors.blueColor,
                                fontSize: 14.sp,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => SignupView()));
                            },
                            child: Text('Signup',
                                style: TextStyle(
                                  fontFamily: "GilroyBold",
                                  color: AppColors.blueColor,
                                  fontSize: 17.sp,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Google login button for Android


                      // Apple login button for iOS

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: AppColors.blueColor,
      size: 50.0,
    );
  }
}

///=------------------------------------------------====
///

//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoadingg = false;
//   bool isLoading = false;
//
//   void _signInWithGoogle() async {
//     setState(() {
//       _isLoadingg = true;
//     });
//     await AuthMethods().signInWithGoogle(context);
//     setState(() {
//       _isLoadingg = false;
//     });
//   }
//
//   void _signInWithApple() async {
//     setState(() {
//       isLoading = true;
//     });
//     await AuthMethods().signInWithApple(context);
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//   Future<void> _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = '';
//       });
//
//       try {
//         // Web-specific logic
//         if (kIsWeb) {
//           print("Running on Web");
//           // Web Firebase Auth logic
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//             email: _emailController.text.trim(),
//             password: _passwordController.text.trim(),
//           );
//         }
//         // Mobile-specific logic
//         else {
//           print("Running on Mobile");
//           // Mobile Firebase Auth logic
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//             email: _emailController.text.trim(),
//             password: _passwordController.text.trim(),
//           );
//         }
//
//         // If login is successful, navigate to another page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => NavBarExample()),
//         );
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           _errorMessage = e.message ?? 'An error occurred';
//         });
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   // Future<void> _login() async {
//   //   print("-----------------------------1");
//   //   if (_formKey.currentState?.validate() ?? false) {
//   //     print("-----------------------------2");
//
//   //     setState(() {
//   //       print("-----------------------------3");
//
//   //       _isLoading = true;
//   //       _errorMessage = '';
//   //     });
//   //     print("-----------------------------4");
//
//   //     try {
//   //       print("-----------------------------5");
//
//   //       await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //         email: _emailController.text.trim(),
//   //         password: _passwordController.text.trim(),
//   //       );
//   //       Navigator.pushReplacement(
//   //           context, CupertinoPageRoute(builder: (context) => NavBarExample()));
//   //     } on FirebaseAuthException catch (e) {
//   //       setState(() {
//   //         _errorMessage = e.message ?? 'An error occurred';
//   //       });
//   //     } finally {
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //     }
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Check if the screen width is above 600 pixels for larger (web/tablet) devices
//           bool isMobile = constraints.maxWidth < 600;
//
//           return Stack(
//             children: [
//               Image.network(
//                 'https://images.unsplash.com/photo-1581159186721-b68b78da4ec9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxtZWRpY2luZXxlbnwwfHx8fDE3MTYwMDg3OTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               Center(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     vertical: isMobile
//                         ? 50
//                         : 100, // Different padding for mobile and web
//                     horizontal: isMobile ? 20 : 450, // Adjusted padding for web
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.8),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Form(
//                       key: _formKey,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(height: 10),
//                             Text('Login',
//                                 style: TextStyle(
//                                   fontFamily: "GilroyBold",
//                                   color: AppColors.blueColor,
//                                   fontSize: isMobile
//                                       ? 24
//                                       : 30, // Responsive font size
//                                 )),
//                             SizedBox(height: 20),
//                             CustomTextFormField(
//                               hintText: 'Email',
//                               keyboardType: TextInputType.emailAddress,
//                               controller: _emailController,
//                             ),
//                             SizedBox(height: 20),
//                             CustomTextFormField(
//                               hintText: 'Password',
//                               keyboardType: TextInputType.text,
//                               isPassword: true,
//                               controller: _passwordController,
//                             ),
//                             SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       CupertinoPageRoute(
//                                         builder: (context) => ReSetEmail(),
//                                       ),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Forget Password?',
//                                     style: TextStyle(
//                                       fontFamily: "GilroyBold",
//                                       color: AppColors.blueColor,
//                                       fontSize: isMobile
//                                           ? 14
//                                           : 16, // Responsive text size
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 20),
//                             if (_errorMessage.isNotEmpty)
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 10.0),
//                                 child: Text(
//                                   _errorMessage,
//                                   style: TextStyle(color: Colors.red),
//                                 ),
//                               ),
//                             if (_isLoading)
//                               AppLoading()
//                             else
//                               GestureDetector(
//                                 onTap: () async {
//                                   await FirebaseAuth.instance
//                                       .signInWithEmailAndPassword(
//                                     email: _emailController.text.trim(),
//                                     password: _passwordController.text.trim(),
//                                   );
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => NavBarExample()),
//                                   );
//                                   //  _login();
//                                 },
//                                 child: BlueButton(text: 'Login'),
//                               ),
//                             SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Don\'t have an account?',
//                                   style: TextStyle(
//                                     fontFamily: "GilroyBold",
//                                     color: AppColors.blueColor,
//                                     fontSize: isMobile ? 14 : 16,
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       CupertinoPageRoute(
//                                           builder: (context) => SignupView()),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Signup',
//                                     style: TextStyle(
//                                       fontFamily: "GilroyBold",
//                                       color: AppColors.blueColor,
//                                       fontSize: isMobile ? 17 : 20,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 20),
//                             if (!kIsWeb && Platform.isAndroid)
//                               _isLoadingg
//                                   ? AppLoading()
//                                   : OutlinedButton.icon(
//                                       style: OutlinedButton.styleFrom(
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: isMobile ? 10 : 15,
//                                           horizontal: isMobile ? 20 : 30,
//                                         ),
//                                         side: BorderSide(color: Colors.black),
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(30)),
//                                         backgroundColor: Colors.transparent,
//                                       ),
//                                       icon: Icon(Icons.g_translate,
//                                           color: Colors.black),
//                                       label: Text(
//                                         'Continue with Google',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: isMobile ? 16 : 20),
//                                       ),
//                                       onPressed: _signInWithGoogle,
//                                     ),
//                             if (!kIsWeb && Platform.isIOS)
//                               isLoading
//                                   ? AppLoading()
//                                   : OutlinedButton.icon(
//                                       style: OutlinedButton.styleFrom(
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: isMobile ? 10 : 15,
//                                           horizontal: isMobile ? 20 : 30,
//                                         ),
//                                         side: BorderSide(color: Colors.black),
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(30)),
//                                         backgroundColor: Colors.transparent,
//                                       ),
//                                       icon: Icon(Icons.apple,
//                                           color: Colors.black),
//                                       label: Text(
//                                         'Continue with Apple',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: isMobile ? 16 : 20),
//                                       ),
//                                       onPressed: _signInWithApple,
//                                     ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class AppLoading extends StatelessWidget {
//   const AppLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SpinKitCircle(
//       color: AppColors.blueColor,
//       size: 50.0,
//     );
//   }
// }
