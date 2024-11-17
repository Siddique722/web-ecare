// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:url_launcher/url_launcher.dart';

import 'package:ecare/constants/linker.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldTextWidgetTheme(text: 'Contact'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'For all questions, recommendations and to report bugs , contact us through email or instagram ',
            ),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text: 'E-mail:\nthomasjosephthiruthanathil@gmail.com'),
            SimpleTextWidgetTheme(text: 'emergencyhealthcare2024@gmail.com'),
            SizedBox(
              height: 14.h,
            ),
            InkWell(
              onTap: () async {
                const url = 'https://www.instagram.com/dr.thomas_joseph/';
                // if (await canLaunch(url)) {
                await launch(url);
                // } else {
                //   throw 'Could not launch $url';
                // }
              },
              child: Row(
                children: [
                  Image(image: AssetImage('lib/assets/images/instagram.png',),height: 22,),
                  //ImageIcon(AssetImage('lib/assets/images/instagram.png')),
                  //  Icon(Icons.insert_chart_outlined),
                  SizedBox(
                      width: 8.w), // Adding spacing between the icon and text
                  SimpleTextWidgetTheme(text: 'Dr. Thomas_Joseph',textsize: 14,),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            SimpleTextWidgetTheme(
              text:
                  '**The above mentioned contacts will change once the company gets an official email ID, Instagram page and contact number',
            ),
          ],
        ),
      ),
    );
  }
}
