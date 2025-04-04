import 'dart:io'; // Import dart:io to detect platform
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

import 'package:ecare/constants/linker.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isLoading = false;
  String _errorMessage = '';

  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    print('button pressing--------');
    await AuthMethods().signInWithGoogle(context);
    print('------2');
    setState(() {
      _isLoading = false;
    });
  }

  void _signInWithApple() async {
    setState(() {
      isLoading = true;
    });
    print('button pressing--------');
    await AuthMethods().signInWithApple(context);
    print('------2');
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
        _errorMessage = '';
      });

      try {
        final credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final user = credential.user;
        if (user != null) {
          print("User logged in: ${user.email}");
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => NavBarExample()),
          );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });

        if (e.code == 'user-not-found') {
          _errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Wrong password provided.';
        } else {
          _errorMessage = 'Error: ${e.message}';
        }

        print('FirebaseAuthException: ${e.code} - ${e.message}');
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        _errorMessage = 'Unexpected error occurred: $e';
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive calculations
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define threshold for desktop (e.g., screens wider than 800px)
    final isDesktop = screenWidth > 800;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image - Responsive scaling
          Image.network(
            'https://images.unsplash.com/photo-1581159186721-b68b78da4ec9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxtZWRpY2luZXxlbnwwfHx8fDE3MTYwMDg3OTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // App Title - Centered and responsive
          Padding(
            padding: EdgeInsets.symmetric(vertical: isDesktop ? screenHeight * 0.07 : 135),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('H',
                    style: TextStyle(
                      fontFamily: "GilroyBold",
                      color: AppColors.blueColor,
                      fontSize: isDesktop ? 40 : 30,
                    )),
                Text(
                  ' Pulse',
                  style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.blueColor,
                      fontSize: isDesktop ? 40 : 30,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          // Login Form Container - Responsive padding and size
          Padding(
            padding: EdgeInsets.only(
              left: isDesktop ? screenWidth * 0.1 : 30,
              right: isDesktop ? screenWidth * 0.1 : 30,
              top: isDesktop ? screenHeight * 0.15 : 180,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? screenWidth * 0.05 : 20),
              height: isDesktop ? screenHeight * 0.7 : 600,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(isDesktop ? 20 : 20)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: isDesktop ? screenHeight * 0.02 : 5),
                      Text('Login',
                          style: TextStyle(
                            fontFamily: "GilroyBold",
                            color: AppColors.blueColor,
                            fontSize: isDesktop ? 28 : 24,
                          )),
                      SizedBox(height: isDesktop ? screenHeight * 0.03 : 20),
                      CustomTextFormField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      SizedBox(height: isDesktop ? screenHeight * 0.03 : 20),
                      CustomTextFormField(
                        hintText: 'Password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      SizedBox(height: isDesktop ? screenHeight * 0.03 : 20),
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
                            child: Text('Forgot Password?',
                                style: TextStyle(
                                  fontFamily: "GilroyBold",
                                  color: AppColors.blueColor,
                                  fontSize: isDesktop ? 16 : 14,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: isDesktop ? screenHeight * 0.03 : 20),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red, fontSize: isDesktop ? 16 : 14),
                          ),
                        ),
                      if (isLoading)
                        AppLoading()
                      else
                        InkWell(
                          onTap: _login,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? screenWidth * 0.1 : 20,
                              vertical: isDesktop ? 15 : 10,
                            ),
                            child: BlueButton(
                              text: 'Login',
                              fontSize: isDesktop ? 18 : 16,

                            ),
                          ),
                        ),
                      SizedBox(height: isDesktop ? screenHeight * 0.02 : 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?',
                              style: TextStyle(
                                fontFamily: "GilroyBold",
                                color: AppColors.blueColor,
                                fontSize: isDesktop ? 16 : 14,
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
                                  fontSize: isDesktop ? 18 : 17,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: isDesktop ? screenHeight * 0.03 : 20),

                      // Google login button
                      if (_isLoading)
                        AppLoading()
                      else
                        OutlinedButton.icon(
                          icon: Image.asset(
                            "assets/ic_google.png",
                            scale: isDesktop ? 3 : 4,
                          ),
                          label: Text(
                            'Continue with Google',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: isDesktop ? 18 : 16),
                          ),
                          onPressed: _signInWithGoogle,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: isDesktop ? 15 : 10,
                                horizontal: isDesktop ? screenWidth * 0.05 : 20),
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      SizedBox(height: isDesktop ? screenHeight * 0.03 : 20),

                      // Apple login button for iOS
                      if (!kIsWeb && Platform.isIOS)
                        isLoading
                            ? AppLoading()
                            : OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: isDesktop ? 15 : 10,
                                horizontal: isDesktop ? screenWidth * 0.05 : 20),
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.transparent,
                          ),
                          icon: Icon(Icons.apple, color: Colors.black),
                          label: Text(
                            'Continue with Apple',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: isDesktop ? 18 : 16),
                          ),
                          onPressed: _signInWithApple,
                        ),
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
//     print('button pressing--------');
//     await AuthMethods().signInWithGoogle(context);
//     print('------2');
//     setState(() {
//       _isLoadingg = false;
//     });
//   }
//
//   void _signInWithApple() async {
//     setState(() {
//       isLoading = true;
//     });
//     print('button pressing--------');
//     await AuthMethods().signInWithApple(context);
//     print('------2');
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   String _errorMessage = '';
//   Future<void> _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         isLoading = true;
//         _errorMessage = '';
//       });
//
//       try {
//         // Firebase Authentication
//         final credential =
//             await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );
//
//         final user = credential.user;
//         if (user != null) {
//           print("User logged in: ${user.email}");
//           Navigator.pushReplacement(
//             context,
//             CupertinoPageRoute(builder: (context) => NavBarExample()),
//           );
//         }
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           isLoading = false;
//         });
//
//         if (e.code == 'user-not-found') {
//           _errorMessage = 'No user found for that email.';
//         } else if (e.code == 'wrong-password') {
//           _errorMessage = 'Wrong password provided.';
//         } else {
//           _errorMessage = 'Error: ${e.message}';
//         }
//
//         print('FirebaseAuthException: ${e.code} - ${e.message}');
//       } catch (e) {
//         setState(() {
//           isLoading = false;
//         });
//         _errorMessage = 'Unexpected error occurred: $e';
//         print('Error: $e');
//       }
//     }
//   }
//
// // Future<void> _login() async {
//   //   if (_formKey.currentState?.validate() ?? false) {
//   //     setState(() {
//   //       _isLoading = true;
//   //       _errorMessage = '';
//   //     });
//   //       final credential =
//   //       await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //         email: _emailController.text.trim(),
//   //         password: _passwordController.text.trim(),
//   //       );
//   //       print("Credentials $credential");
//   //   }
//   // }
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
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 135.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('H',
//                     style: TextStyle(
//                       fontFamily: "GilroyBold",
//                       color: AppColors.blueColor,
//                       fontSize: 30.sp,
//                     )),
//                 Text(
//                   ' Pulse',
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
//               height: 600.h,
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
//                       SizedBox(height: 5.h),
//                       Text('Login',
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
//                       CustomTextFormField(
//                         hintText: 'Password',
//                         keyboardType: TextInputType.text,
//                         isPassword: true,
//                         controller: _passwordController,
//                       ),
//                       SizedBox(height: 20.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                       builder: (context) => ReSetEmail()));
//                             },
//                             child: Text('Forgot Password?',
//                                 style: TextStyle(
//                                   fontFamily: "GilroyBold",
//                                   color: AppColors.blueColor,
//                                   fontSize: 14.sp,
//                                 )),
//                           ),
//                         ],
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
//                       if (isLoading)
//                         AppLoading()
//                       else
//                         InkWell(
//                           onTap: _login,
//                           child: BlueButton(text: 'Login'),
//                         ),
//                       SizedBox(height: 10.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Don\'t have an account?',
//                               style: TextStyle(
//                                 fontFamily: "GilroyBold",
//                                 color: AppColors.blueColor,
//                                 fontSize: 14.sp,
//                               )),
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                       builder: (context) => SignupView()));
//                             },
//                             child: Text('Signup',
//                                 style: TextStyle(
//                                   fontFamily: "GilroyBold",
//                                   color: AppColors.blueColor,
//                                   fontSize: 17.sp,
//                                 )),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20.h),
//
//                       // Google login button for Android
//                       //    if (!kIsWeb)
//                       //if (Platform.isAndroid)
//                       _isLoadingg
//                           ? AppLoading()
//                           :
//                           // OutlinedButton.icon(
//                           //     style: OutlinedButton.styleFrom(
//                           //       padding: EdgeInsets.symmetric(
//                           //           vertical: 10.h, horizontal: 20),
//                           //       side: BorderSide(color: Colors.black),
//                           //       shape: RoundedRectangleBorder(
//                           //           borderRadius: BorderRadius.circular(30)),
//                           //       backgroundColor: Colors.transparent,
//                           //     ),
//                           //     icon:
//                           //         Icon(Icons.g_translate, color: Colors.black),
//                           //     label: Text(
//                           //       'Continue with Google',
//                           //       style: TextStyle(
//                           //           color: Colors.black, fontSize: 16.sp),
//                           //     ),
//                           //     onPressed: () {
//                           //       _signInWithGoogle();
//                           //     } // _signInWithGoogle,
//                           //     ),
//                       //   if (!kIsWeb && Platform.isAndroid)
//                       _isLoadingg
//                           ? AppLoading()
//                           : OutlinedButton.icon(
//                         icon: Image.asset(
//                           "assets/ic_google.png",
//                           scale: 4,
//                         ),
//                         // icon: Icon(Icons.g_translate,
//                         //     color: Colors.black),
//                         label: Text(
//                           'Continue with Google',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         onPressed: _signInWithGoogle,
//                       ),
//                       SizedBox(height: 20.h),
//                       // Apple login button for iOS
//                       if (!kIsWeb && Platform.isIOS)
//                         //   if (Platform.isIOS)
//                         isLoading
//                             ? AppLoading()
//                             : OutlinedButton.icon(
//                                 style: OutlinedButton.styleFrom(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 10.h, horizontal: 20),
//                                   side: BorderSide(color: Colors.black),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30)),
//                                   backgroundColor: Colors.transparent,
//                                 ),
//                                 icon: Icon(Icons.apple, color: Colors.black),
//                                 label: Text(
//                                   'Continue with Apple',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 16.sp),
//                                 ),
//                                 onPressed: () {
//                                   _signInWithApple();
//                                 } // _signInWithApple,
//                                 ),
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
// import 'dart:io'; // Import dart:io to detect platform
// import 'package:hpulse/services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hpulse/constants/linker.dart';
// import 'package:flutter/foundation.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoadingg = false;
//   bool isLoading = false;

//   void _signInWithGoogle() async {
//     setState(() {
//       _isLoadingg = true;
//     });
//     await AuthMethods().signInWithGoogle(context);
//     setState(() {
//       _isLoadingg = false;
//     });
//   }

//   void _signInWithApple() async {
//     setState(() {
//       isLoading = true;
//     });
//     await AuthMethods().signInWithApple(context);
//     setState(() {
//       isLoading = false;
//     });
//   }

//   bool _isLoading = false;
//   String _errorMessage = '';
//   Future<void> _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = '';
//       });

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

//   // Future<void> _login() async {
//   //   print("-----------------------------1");
//   //   if (_formKey.currentState?.validate() ?? false) {
//   //     print("-----------------------------2");

//   //     setState(() {
//   //       print("-----------------------------3");

//   //       _isLoading = true;
//   //       _errorMessage = '';
//   //     });
//   //     print("-----------------------------4");

//   //     try {
//   //       print("-----------------------------5");

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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Check if the screen width is above 600 pixels for larger (web/tablet) devices
//           bool isMobile = constraints.maxWidth < 600;

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

// class AppLoading extends StatelessWidget {
//   const AppLoading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SpinKitCircle(
//       color: AppColors.blueColor,
//       size: 50.0,
//     );
//   }
// }
