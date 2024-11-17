// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecare/constants/linker.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BoldTextWidgetTheme(text: 'About'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'The E-health app is trying to fill the gaps in the emergency health care system of India. It aims to help both patients and doctors, eventually reducing mortality and making emergency care settings more efficient.'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'We offer an E-health card which contains all the information, including emergency contacts, that a healthcare professional might require even in the absence of bystanders.'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'Using this app, you can also create a complete medical history for yourself and your family members, which will facilitate diagnostics and medication.'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(text: 'Other services offered:'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text: '1. E-Health ID card for you and your loved ones, which can help them with emergency situations.'),
            SimpleTextWidgetTheme(text: '2. Search and call nearby ambulance.'),
            SimpleTextWidgetTheme(
                text: '3. Store your medical documents in a single place.'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'We are trying to include many more health services that will make life easier for both doctors and patients. Thank you for joining us on this journey.'),
          ],
        ),
      ),
    );
  }
}
