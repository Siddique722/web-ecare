
import 'package:ecare/constants/linker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class VerifyView extends StatefulWidget {
  const VerifyView({super.key});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          BoldTextWidgetTheme(text: 'Please verify your email'),
          SizedBox(height: 10.h,),
          SimpleTextWidgetTheme( 
            textsize: 16,
            text: 'Please verify your email before procedding as it will be helpful in recovring data if something goes wrong'),
            SizedBox(height: 10.h,),
            InkWell(
              onTap: (){
                Navigator.push(context,CupertinoPageRoute(builder: (context)=>CreateProfileScreen(role: 'register',)) );
              },
              child: BlueButton(text: 'Proceed without verifying'))
            
            ],
            ),
      ),
    );
  }
}