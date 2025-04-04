import 'dart:io';

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/auth-views/controllers/sign-up-controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'dart:math';

///TODO:- without getX state management---
//
// class SignupView extends StatefulWidget {
//   const SignupView({super.key});
//
//   @override
//   State<SignupView> createState() => _SignupViewState();
// }
//
// class _SignupViewState extends State<SignupView> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//
//
//   Future<void> _signUp() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       // Sign up the user with email and password
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//           email: _emailController.text, password: _passwordController.text);
//
//       User? user = userCredential.user;
//
//       if (user != null) {
//         // Generate the referral code
//         String referralCode = _generateReferralCode();
//
//         // Save user data to Firestore
//         await FirebaseFirestore.instance
//             .collection('UsersData')
//             .doc(user.email)
//             .set({
//           'userEmail': user.email,
//           'userId': user.uid,
//           'userName': _usernameController.text,
//         });
//
//         // Save referral data to Firestore
//         await FirebaseFirestore.instance
//             .collection('ReferData')
//             .doc(user.uid)
//             .set({
//           'referralCode': referralCode,
//           'userId': user.uid,
//           'userName': _usernameController.text,
//           'balance': '0',
//         });
//       }
//
//       // Navigate to the wrapper screen
//       Navigator.pushReplacement(
//           context, CupertinoPageRoute(builder: (context) => const WraperScreen()));
//     } catch (e) {
//       print('Error:$e');
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
// // Helper function to generate a referral code
//   String _generateReferralCode() {
//     const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//     final random = Random();
//
//     // Generate 3 random alphabets
//     String alphabets = String.fromCharCodes(Iterable.generate(
//         3, (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))));
//
//     // Generate 4 random numbers
//     String numbers = String.fromCharCodes(Iterable.generate(
//         4, (_) => random.nextInt(10).toString().codeUnitAt(0)));
//
//     return alphabets + numbers; // Combine and return the referral code
//   }
//
//   // Future<void> _signUp() async {
//   //   if (!_formKey.currentState!.validate()) return;
//   //
//   //   setState(() {
//   //     _isLoading = true;
//   //   });
//   //
//   //   try {
//   //     UserCredential userCredential = await FirebaseAuth.instance
//   //         .createUserWithEmailAndPassword(
//   //             email: _emailController.text, password: _passwordController.text);
//   //
//   //     User? user = userCredential.user;
//   //
//   //     if (user != null) {
//   //       await FirebaseFirestore.instance
//   //           .collection('UsersData')
//   //           .doc(user.email)
//   //           .set({
//   //         'userEmail': user.email,
//   //         'userId': user.uid,
//   //         'userName': _usernameController.text,
//   //       });
//   //       await FirebaseFirestore.instance
//   //           .collection('ReferData')
//   //           .doc(user.uid)
//   //           .set({
//   //        'reffercode':
//   //         'userId': user.uid,
//   //         'userName': _usernameController.text,
//   //         'balance':'0'
//   //       });
//   //     }
//   //
//   //     Navigator.pushReplacement(context,
//   //         CupertinoPageRoute(builder: (context) => const WraperScreen()));
//   //   } catch (e) {
//   //     print('Error:$e');
//   //     ScaffoldMessenger.of(context)
//   //         .showSnackBar(SnackBar(content: Text(e.toString())));
//   //   } finally {
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //   }
//   // }
//
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
//           SizedBox(
//             height: 100.h,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 50.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('H',
//                     style: TextStyle(
//                       fontFamily: "GilroyBold",
//                       color: AppColors.blueColor,
//                       fontSize: 24.sp,
//                     )),
//                 Text(
//                   ' Pulse',
//                   style: TextStyle(
//                       fontFamily: "Gilroy",
//                       color: AppColors.blueColor,
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.w900),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: 30.w,
//               right: 30.w,
//               top: 90.h,
//             ),
//             child: Container(
//               height: 700.h, //double.infinity,
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(20)),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text('Register',
//                             style: TextStyle(
//                               fontFamily: "GilroyBold",
//                               color: AppColors.blueColor,
//                               fontSize: 24.sp,
//                             )),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Text('Let\'s get started by filling out the form below',
//                             style: TextStyle(
//                               fontFamily: "GilroyBold",
//                               color: AppColors.blueColor,
//                               fontSize: 14.sp,
//                             )),
//                         SizedBox(height: 20.h),
//                         CustomTextFormField(
//                           hintText: 'Username',
//                           keyboardType: TextInputType.text,
//                           controller: _usernameController,
//                         ),
//                         SizedBox(height: 20.h),
//                         CustomTextFormField(
//                           hintText: 'Email',
//                           keyboardType: TextInputType.emailAddress,
//                           controller: _emailController,
//                         ),
//                         SizedBox(height: 20.h),
//                         CustomTextFormField(
//                           hintText: 'Password',
//                           keyboardType: TextInputType.text,
//                           isPassword: true,
//                           controller: _passwordController,
//                         ),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                         _isLoading
//                             ? const AppLoading()
//                             : InkWell(
//                                 onTap: _signUp,
//                                 child: BlueButton(text: 'Signup'),
//                               ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Already have an account?',
//                                 style: TextStyle(
//                                   fontFamily: "GilroyBold",
//                                   color: AppColors.blueColor,
//                                   fontSize: 14.sp,
//                                 )),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     CupertinoPageRoute(
//                                         builder: (context) =>
//                                             const LoginView()));
//                               },
//                               child: Text('Login',
//                                   style: TextStyle(
//                                     fontFamily: "GilroyBold",
//                                     color: AppColors.blueColor,
//                                     fontSize: 17.sp,
//                                   )),
//                             )
//                           ],
//                         ),
//                       ]),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///TODO:- with Getx StateManagement
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

// class SignupView extends StatefulWidget {
//   SignupView({Key? key}) : super(key: key);

//   @override
//   State<SignupView> createState() => _SignupViewState();
// }

// class _SignupViewState extends State<SignupView> {
//   bool _isLoadingg = false;

//   bool isLoading = false;

//   final SignupController controller = Get.put(SignupController());

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
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 50.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('H',
//                     style: TextStyle(
//                       fontFamily: "GilroyBold",
//                       color: AppColors.blueColor,
//                       fontSize: 24.sp,
//                     )),
//                 Text(
//                   ' Pulse',
//                   style: TextStyle(
//                       fontFamily: "Gilroy",
//                       color: AppColors.blueColor,
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.w900),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: 30.w,
//               right: 30.w,
//               top: 90.h,
//             ),
//             child: Container(
//               height: 700.h,
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(20)),
//               child: Form(
//                 key: controller.formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Text('Register',
//                           style: TextStyle(
//                             fontFamily: "GilroyBold",
//                             color: Colors.blue,
//                             fontSize: 24.sp,
//                           )),
//                       SizedBox(height: 10.h),
//                       CustomTextFormField(
//                         hintText: 'Username',
//                         keyboardType: TextInputType.text,
//                         controller: controller.usernameController,
//                       ),
//                       SizedBox(height: 20.h),
//                       CustomTextFormField(
//                         hintText: 'Email',
//                         keyboardType: TextInputType.emailAddress,
//                         controller: controller.emailController,
//                       ),
//                       SizedBox(height: 20.h),
//                       CustomPasswordFormField(
//                         hintText: 'Password',
//                         keyboardType: TextInputType.text,
//                         isPassword: true,
//                         controller: controller.passwordController,
//                       ),
//                       SizedBox(height: 20.h),
//                       CustomPasswordFormField(
//                         hintText: 'Confirm Password',
//                         keyboardType: TextInputType.text,
//                         isPassword: true,
//                         controller: controller.confirmPassword,
//                       ),
//                       //  CustomTextFormField(
//                       //    hintText: 'Reffer Code',
//                       //    keyboardType: TextInputType.text,
//                       // //   isPassword: true,
//                       //    controller: controller.refferController,
//                       //  ),
//                       SizedBox(height: 20.h),
//                       Obx(() => controller.isLoading.value
//                           ? AppLoading()
//                           : InkWell(
//                               onTap: () {
//                                 controller.signUp(context);
//                               },
//                               child: BlueButton(text: 'Signup'),
//                             )),
//                       SizedBox(height: 10.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Already have an account?',
//                               style: TextStyle(
//                                 fontFamily: "GilroyBold",
//                                 color: Colors.blue,
//                                 fontSize: 14.sp,
//                               )),
//                           InkWell(
//                             onTap: () {
//                               Get.to(() => const LoginView());
//                             },
//                             child: Text('Login',
//                                 style: TextStyle(
//                                   fontFamily: "GilroyBold",
//                                   color: Colors.blue,
//                                   fontSize: 17.sp,
//                                 )),
//                           ),
//                         ],
//                       ),
//                       if (!kIsWeb && Platform.isAndroid)
//                         //if (Platform.isAndroid)
//                         _isLoadingg
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
//                                 icon: Icon(Icons.g_translate,
//                                     color: Colors.black),
//                                 label: Text(
//                                   'Continue with Google',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 16.sp),
//                                 ),
//                                 onPressed: () {
//                                   _signInWithGoogle();
//                                 } // _signInWithGoogle,
//                                 ),

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
class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool _isLoadingg = false;
  bool isLoading = false;
  bool isTermsAccepted = false; // Checkbox state

  final SignupController controller = Get.put(SignupController());

  void _signInWithGoogle() async {
    setState(() {
      _isLoadingg = true;
    });
    await AuthMethods().signInWithGoogle(context);
    setState(() {
      _isLoadingg = false;
    });
  }

  void _signInWithApple() async {
    setState(() {
      isLoading = true;
    });
    await AuthMethods().signInWithApple(context);
    setState(() {
      isLoading = false;
    });
  }

  void _launchTermsUrl() async {
    const url = 'https://sites.google.com/view/hpulse-privacy-policy/home';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
          Image.network(
            'https://images.unsplash.com/photo-1581159186721-b68b78da4ec9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxtZWRpY2luZXxlbnwwfHx8fDE3MTYwMDg3OTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: isDesktop ? screenHeight * 0.07 : 135),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('H',
                    style: TextStyle(
                      fontFamily: "GilroyBold",
                      color: AppColors.blueColor,
                      fontSize: 24.sp,
                    )),
                Text(
                  ' Pulse',
                  style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.blueColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              top: 90.h,
            ),
            child: Container(
              height: 700.h,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Register',
                          style: TextStyle(
                            fontFamily: "GilroyBold",
                            color: Colors.blue,
                            fontSize: 24.sp,
                          )),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        hintText: 'Username',
                        keyboardType: TextInputType.text,
                        controller: controller.usernameController,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFormField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                      ),
                      SizedBox(height: 20.h),
                      CustomPasswordFormField(
                        hintText: 'Password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        controller: controller.passwordController,
                      ),
                      SizedBox(height: 20.h),
                      CustomPasswordFormField(
                        hintText: 'Confirm Password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        controller: controller.confirmPassword,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Checkbox(
                            value: isTermsAccepted,
                            onChanged: (value) {
                              setState(() {
                                isTermsAccepted = value!;
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: _launchTermsUrl,
                            child: Text(
                              'Accept Terms and Conditions',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Obx(() => controller.isLoading.value
                          ? AppLoading()
                          : InkWell(
                              onTap: isTermsAccepted
                                  ? () {
                                      controller.signUp(context);
                                    }
                                  : () {
                                      Get.snackbar(
                                        'Error',
                                        'Please accept terms and conditions to proceed.',
                                      );
                                    },
                              child: BlueButton(text: 'Signup'),
                            )),
                      SizedBox(height: 20.h),
                      //   if (!kIsWeb && Platform.isAndroid)
                      _isLoadingg
                          ? AppLoading()
                          : OutlinedButton.icon(
                              icon: Image.asset(
                                "assets/ic_google.png",
                                scale: 4,
                              ),
                              // icon: Icon(Icons.g_translate,
                              //     color: Colors.black),
                              label: Text(
                                'Continue with Google',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: isTermsAccepted
                                  ? _signInWithGoogle
                                  : () {
                                      Get.snackbar(
                                        'Error',
                                        'Please accept terms and conditions to proceed.',
                                      );
                                    },
                            ),
                      SizedBox(height: 20.h),
                      if (!kIsWeb && Platform.isIOS)
                        isLoading
                            ? AppLoading()
                            : OutlinedButton.icon(
                                icon: Icon(Icons.apple, color: Colors.black),
                                label: Text(
                                  'Continue with Apple',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: isTermsAccepted
                                    ? _signInWithApple
                                    : () {
                                        Get.snackbar(
                                          'Error',
                                          'Please accept terms and conditions to proceed.',
                                        );
                                      },
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
class CustomPasswordFormField extends StatefulWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const CustomPasswordFormField({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.isPassword,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomPasswordFormField> createState() => _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.isPassword == true ? _isObscured : false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword == true
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : null,
        hintText: widget.hintText ?? " ",
        hintStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${widget.hintText}';
        }
        if (widget.hintText == 'Username' &&
            !RegExp(r'^[a-zA-Z]').hasMatch(value)) {
          return 'Username must start with a letter';
        }
        if (widget.hintText == 'Email' &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        if (widget.hintText == 'Password' && value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        if (widget.hintText == 'Password' &&
            !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&()])[A-Za-z\d@$!%*?&]{8,}$')
                .hasMatch(value)) {
          return 'Password must contain letters, numbers, and special characters';
        }
        return null;
      },
    );
  }
}
