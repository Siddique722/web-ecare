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
    // Get the screen width and height for responsive calculations
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculation: Define a threshold to determine if the device is desktop/web
    // Screens wider than 800px are treated as desktop for layout adjustments
    final isDesktop = screenWidth > 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          // Responsive calculation: On desktop, use 15% of screen width for horizontal padding
          // On mobile, use a fixed 20px padding for tighter spacing
          horizontal: isDesktop ? screenWidth * 0.15 : 20.0,
          vertical: isDesktop ? screenHeight * 0.1 : 20.0, // Adjust vertical padding for desktop
        ),
        child: SingleChildScrollView( // Add ScrollView for taller content on smaller screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title (Bold Text)
              BoldTextWidgetTheme(
                text: 'We’d Love to Hear From You!',
                baseTextSize: isDesktop ? 32 : 24, // Larger on desktop, smaller on mobile/tablet
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing (2% of screen height)

              // Introductory Text
              SimpleTextWidgetTheme(
                text: 'Got questions?, Suggestions? Found a bug? We\'re here to help! Reach out to us through: ',
                baseTextSize: isDesktop ? 18 : 16, // Larger on desktop, smaller on mobile/tablet
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing

              // Email Addresses
              SimpleTextWidgetTheme(
                text: 'E-mail:\nthomasjosephthiruthanathil@gmail.com',
                baseTextSize: isDesktop ? 18 : 16,
              ),
              SimpleTextWidgetTheme(
                text: 'emergencyhealthcare2024@gmail.com',
                baseTextSize: isDesktop ? 18 : 16,
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing

              // Instagram Link
              InkWell(
                onTap: () async {
                  const url = 'https://www.instagram.com/dr.thomas_joseph/';
                  await launch(url);
                },
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('lib/assets/images/instagram.png'),
                      height: isDesktop ? 30 : 22, // Larger icon on desktop
                    ),
                    SizedBox(width: screenWidth * 0.02), // Responsive spacing between icon and text
                    SimpleTextWidgetTheme(
                      text: 'Dr. Thomas_Joseph',
                      baseTextSize: isDesktop ? 18 : 14, // Larger on desktop, smaller on mobile/tablet
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing

              // Address
              SimpleTextWidgetTheme(
                text: 'Address\nRoom No. 2, 2nd floor, building adj. To CPIM party office, cheruthoni, Idukki, Kerala, India pin. 685602',
                baseTextSize: isDesktop ? 18 : 16,
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing

              // Note
              SimpleTextWidgetTheme(
                text: 'Note:\nThese contacts will be updated with our official email, Instagram page, and contact number as soon as they’re available. Stay tuned!',
                baseTextSize: isDesktop ? 18 : 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// class _ContactState extends State<Contact> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BoldTextWidgetTheme(text: 'We’d Love to Hear From You!'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//               'Got questions?, Suggestions? Found a bug? We\'re here to help! Reach out to us through:  ',
//             ),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//                 text: 'E-mail:\nthomasjosephthiruthanathil@gmail.com'),
//             SimpleTextWidgetTheme(text: 'emergencyhealthcare2024@gmail.com'),
//             SizedBox(
//               height: 14.h,
//             ),
//             InkWell(
//               onTap: () async {
//                 const url = 'https://www.instagram.com/dr.thomas_joseph/';
//                 // if (await canLaunch(url)) {
//                 await launch(url);
//                 // } else {
//                 //   throw 'Could not launch $url';
//                 // }
//               },
//               child: Row(
//                 children: [
//                   Image(image: AssetImage('lib/assets/images/instagram.png',),height: 22,),
//                   //ImageIcon(AssetImage('lib/assets/images/instagram.png')),
//                   //  Icon(Icons.insert_chart_outlined),
//                   SizedBox(
//                       width: 8.w), // Adding spacing between the icon and text
//                   SimpleTextWidgetTheme(text: 'Dr. Thomas_Joseph',baseTextSize: 14,),
//                 ],
//               ),
//             ),
//             SizedBox(height: 14.h),
//             SimpleTextWidgetTheme(
//                 text:'Adress\nRoom No. 2, 2nd floor, building adj. To CPIM party office, cheruthoni, Idukki, Kerala, India pin. 685602'
//             ),
//             SizedBox(height: 14.h,),
//             SimpleTextWidgetTheme(text: 'Note:\nThese contacts will be updated with our official email, Instagram page, and contact number as soon as they’re available. Stay tuned!',)
//           ],
//         ),
//       ),
//     );
//   }
// }
