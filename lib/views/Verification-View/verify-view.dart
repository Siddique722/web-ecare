
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use BoldTextWidgetTheme with a base text size
            BoldTextWidgetTheme(
              text: 'Please verify your email',
              baseTextSize: 24, // Base size for mobile (will scale up for larger screens)
            ),
            SizedBox(height: 10.h),
            // Use SimpleTextWidgetTheme with a base text size
            SimpleTextWidgetTheme(
              text: 'Please verify your email before proceeding as it will be helpful in recovering data if something goes wrong',
              baseTextSize: 16, // Base size for mobile (will scale up for larger screens)
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => CreateProfileScreen(role: 'register')),
                );
              },
              child: BlueButton(text: 'Proceed without verifying'),
            ),
          ],
        ),
      ),
    );
  }
}
// class _VerifyViewState extends State<VerifyView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 80.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           BoldTextWidgetTheme(text: 'Please verify your email'),
//           SizedBox(height: 10.h,),
//           SimpleTextWidgetTheme(
//             textsize: 16,
//             text: 'Please verify your email before procedding as it will be helpful in recovring data if something goes wrong'),
//             SizedBox(height: 10.h,),
//             InkWell(
//               onTap: (){
//                 Navigator.push(context,CupertinoPageRoute(builder: (context)=>CreateProfileScreen(role: 'register',)) );
//               },
//               child: BlueButton(text: 'Proceed without verifying'))
//
//             ],
//             ),
//       ),
//     );
//   }
// }