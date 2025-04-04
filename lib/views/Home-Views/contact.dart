import 'package:ecare/widgets/text-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
            BoldTextWidgetTheme(text: 'We’d Love to Hear From You!'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
              'Got questions?, Suggestions? Found a bug? We\'re here to help! Reach out to us through:  ',
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
                  SimpleTextWidgetTheme(text: 'Dr. Thomas_Joseph',baseTextSize: 14,),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            SimpleTextWidgetTheme(
                text:'Adress\nRoom No. 2, 2nd floor, building adj. To CPIM party office, cheruthoni, Idukki, Kerala, India pin. 685602'
            ),
            SizedBox(height: 14.h,),
            SimpleTextWidgetTheme(text: 'Note:\nThese contacts will be updated with our official email, Instagram page, and contact number as soon as they’re available. Stay tuned!',)
          ],
        ),
      ),
    );
  }
}
