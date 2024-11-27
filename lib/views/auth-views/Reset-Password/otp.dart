// import 'package:demo_app/views/Home-Views/Nav-Bar/nav-bar-.dart';
// import 'package:demo_app/views/auth-views/Reset-Password/generate-new-password.dart';
// import 'package:demo_app/views/auth-views/signup-view.dart';
// import 'package:demo_app/widgets/blue-button.dart';
// import 'package:demo_app/widgets/custom-textfieldwidget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:demo_app/constants/colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:demo_app/constants/linker.dart';
 import 'package:ecare/views/auth-views/login-view.dart';
import 'package:flutter/cupertino.dart';

import 'package:ecare/constants/linker.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String _errorMessage = '';

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
          SizedBox(height: 100.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 140.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('H',
                    style: TextStyle(
                      fontFamily: "GilroyBold",
                      color: AppColors.blueColor,
                      fontSize: 30.sp,
                    )),
                Text(
                  ' Pulse',
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
              height: 300.h, //double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.h),
                      Text('Verification sent successfully\nCheck your email',
                          style: TextStyle(
                            fontFamily: "GilroyBold",
                            color: AppColors.blueColor,
                            fontSize: 18.sp,
                          )),
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
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SignupView()));
                            //_login();
                          },
                          child: BlueButton(
                            text: 'Login',

                            //  onPressed: ,
                          ),
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
