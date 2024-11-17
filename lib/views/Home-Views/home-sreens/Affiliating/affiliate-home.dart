import 'package:ecare/constants/linker.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

///------------------------------------
///
// import 'package:demo_app/constants/linker.dart';
// import 'package:demo_app/views/Home-Views/home-sreens/Affiliating/affiliate-registration.dart';
// import 'package:demo_app/views/Home-Views/home-sreens/Affiliating/performnce_chart.dart';
// import 'package:demo_app/views/Home-Views/home-sreens/Affiliating/wallet-controller.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart'; // Import the controller

// class AffliateHome extends StatefulWidget {
//   const AffliateHome({super.key});

//   @override
//   State<AffliateHome> createState() => _AffliateHomeState();
// }

// class _AffliateHomeState extends State<AffliateHome> {
//   // Instantiate the WalletController using GetX
//   final WalletController walletController = Get.put(WalletController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             BoldTextWidgetTheme(text: 'Become an Affiliate'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(text: 'Create an extra stream of income'),
//             SizedBox(height: 10.h),

//             // Affiliate Registration Button
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   CupertinoDialogRoute(
//                       builder: (context) => AffliateRegistration(),
//                       context: context),
//                 );
//               },
//               child: BlueButton(text: 'Register'),
//             ),
//             SizedBox(height: 10),

//             // Performance Chart Button
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   CupertinoDialogRoute(
//                       builder: (context) => PerformanceChart(),
//                       context: context),
//                 );
//               },
//               child: BlueButton(text: 'Performance Chart'),
//             ),
//             SizedBox(height: 10),

//             // Copy Referral Link Button
//             BlueButton(text: 'Copy Referral Link'),
//             SizedBox(height: 20),

//             // Wallet System: Total Earnings Display
//             Obx(() {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Show/hide earnings based on the isHidden value
//                   BoldTextWidgetTheme(
//                     text: walletController.isHidden.value
//                         ? 'Total Earnings: *****'
//                         : 'Total Earnings: \$${walletController.totalEarnings.value}',
//                   ),
//                   SizedBox(height: 10),

//                   // Toggle visibility button using eye icon
//                   IconButton(
//                     icon: Icon(
//                       walletController.isHidden.value
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                       color: Colors.blue,
//                     ),
//                     onPressed: walletController.toggleVisibility,
//                   ),

//                   // Withdraw Button
//                   SizedBox(height: 10),
//                   InkWell(
//                     onTap: () {
//                       // Handle withdrawal
//                       walletController.withdrawEarnings();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Withdrawal Successful'),
//                         ),
//                       );
//                     },
//                     child: BlueButton(text: 'Withdraw Earnings'),
//                   ),
//                 ],
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

//-------------------------------

// import 'package:demo_app/views/Home-Views/home-sreens/Affiliating/affiliate-registration.dart';
// import 'package:demo_app/views/Home-Views/home-sreens/Affiliating/performnce_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:demo_app/views/Home-Views/home-sreens/Affiliating/wallet-controller.dart';

class AffliateHome extends StatefulWidget {
  const AffliateHome({super.key});

  @override
  State<AffliateHome> createState() => _AffliateHomeState();
}

class _AffliateHomeState extends State<AffliateHome> {
  final WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Affiliate Wallet',
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        elevation: 0,
        // iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Colors.blue.shade50, Colors.blue.shade100],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
            ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Summary Section
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.r,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Affiliate Earnings',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Show total earnings
                          Text(
                            walletController.isHidden.value
                                ? '*****'
                                : '\$${walletController.totalEarnings.value}',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          // Toggle visibility button
                          IconButton(
                            icon: Icon(
                              walletController.isHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blueAccent,
                            ),
                            onPressed: walletController.toggleVisibility,
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 10.h),
                    // Withdraw Button
                    InkWell(
                      onTap: () {
                        walletController.withdrawEarnings();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Withdrawal Successful'),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'Withdraw Earnings',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Affiliate Information Section
              Text(
                'Affiliate Options',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 10.h),

              // Register Button
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoDialogRoute(
                      builder: (context) =>
                          AffliateRegistration(), // Placeholder for registration screen
                      context: context,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Text(
                      'Register as Affiliate',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              // Performance Chart Button
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoDialogRoute(
                      builder: (context) =>
                          const PerformanceChart(), // Placeholder for performance chart screen
                      context: context,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Text(
                      'Performance Chart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              // Copy Referral Link Button
              InkWell(
                onTap: () {
                  // Code to copy the referral link
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Referral Link Copied!'),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Text(
                      'Copy Referral Link',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
