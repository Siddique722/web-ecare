// import 'package:demo_app/widgets/blue-button.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

import 'package:ecare/constants/linker.dart';

class AmbulanceView extends StatefulWidget {
  const AmbulanceView({super.key});

  @override
  State<AmbulanceView> createState() => _AmbulanceViewState();
}

class _AmbulanceViewState extends State<AmbulanceView> {
  Future<void> _launchDialer() async {
    const phoneNumber = 'tel:108'; // Phone number to dial
    // if (await canLaunch(phoneNumber)) {
    await launchUrl(Uri.parse(phoneNumber));
    //} else {
    //throw 'Could not launch $phoneNumber';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            BoldTextWidgetTheme(text: 'Government Ambulance'),
            SizedBox(height: 10.h),
            InkWell(
              onTap: _launchDialer,
              child: BlueButton(
                text: 'Dial 108',
                // Call _launchDialer when pressed
              ),
            ),
            SizedBox(height: 10.h),
            BoldTextWidgetTheme(text: 'Private Ambulance'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'Sorry, no registered Ambulance Service is available in your area.'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'We are working on this with the ambulance services in your area for the best service'),
          ],
        ),
      ),
    );
  }
}
