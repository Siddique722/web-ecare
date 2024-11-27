// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PrivacyPolicyScreen extends StatefulWidget {
//   const PrivacyPolicyScreen({super.key});

//   @override
//   State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
// }

// class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,

//         centerTitle: true,
//         elevation: 0,
//         // iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BoldTextWidgetTheme(text: 'Privacy Policy for E Care'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(text: 'Last Updated: 31/10/2024'),
//             SizedBox(height: 20.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'Welcome to E Care! We value your privacy and are committed to protecting your personal and medical information. This Privacy Policy outlines how E Care collects, uses, and safeguards your information, helping make emergency situations convenient and safer for you.',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '1. Information We Collect'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'To provide you with the best emergency assistance, we collect the following types of information:',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• Personal Information: Includes your name, phone number, emergency contacts, address, and any other data you provide during registration or account setup.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• Medical Information: Includes your medical history, allergies, medications, blood type, and any other relevant data you choose to provide to ensure appropriate response in emergencies.',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '2. How We Use Your Information'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text: 'We use your information for the following purposes:',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• Emergency Response: Your personal and medical information is used solely for facilitating appropriate emergency assistance during critical situations.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• App Improvement: To improve our app’s functionality, troubleshoot issues, and develop new features.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• Communication: To notify you of app updates, changes in our terms or policies, and any relevant information about E Care.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   'Note: We do not use your medical data for advertising or marketing purposes.',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '3. Information Sharing and Disclosure'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text: 'We only share your information in limited situations:',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• Emergency Situations: With your explicit consent, or as necessary, we may share your information with emergency responders and healthcare providers to ensure timely and accurate assistance.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• Legal Compliance: We may disclose your information to law enforcement or government authorities if required by law.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   '• Third-Party Service Providers: We may share non-personally identifiable information with trusted third-party providers that assist in app functionality. They are required to follow data protection standards.',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '4. Data Security'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'We prioritize the security of your data by implementing technical, administrative, and physical security measures to protect against unauthorized access, alteration, disclosure, or destruction of your information.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   'However, no method of data transmission over the Internet or mobile networks can be guaranteed 100% secure. We strive to protect your data, but absolute security cannot be guaranteed.',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '5. Data Retention'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'We retain your personal and medical information only as long as it is necessary to provide our services, or as required by law. Upon request, you can delete your account and associated information through the app settings, or by contacting our support team.',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '6. Your Rights'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'You have certain rights over your data, including:\n• Access: Request access to your personal information held by us.\n• Correction: Update or correct any inaccuracies in your data.\n• Deletion: Request deletion of your personal data when it is no longer required.',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   'To exercise these rights, please contact our support team at emergencyhealthcare2024@gmail.com',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '7. Changes to this Privacy Policy'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'We may update this Privacy Policy periodically to reflect changes in our practices or legal requirements. We will notify you of any significant changes through the app or via email. Your continued use of E Care after changes are made will constitute your acceptance of the updated policy.',
//             ),
//             SizedBox(height: 20.h),
//             BoldTextWidgetTheme(text: '8. Contact Us'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'If you have any questions about this Privacy Policy, please contact us at:',
//             ),
//             SimpleTextWidgetTheme(
//               text:
//                   'E Care Support Team\nEmail: emergencyhealthcare2024@gmail.com\nPhone: +91 83308 62301',
//             ),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
// }


///-------------------
///
import 'package:demo_app/widgets/text-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldTextWidgetTheme(text: 'Privacy Policy for H Pulse'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(text: 'Last Updated: 31/10/2024'),
            SizedBox(height: 20.h),
            SimpleTextWidgetTheme(
              text:
                  'Welcome to H Pulse! We value your privacy and are committed to protecting your personal and medical information. This Privacy Policy outlines how H Pulse collects, uses, and safeguards your information, helping make emergency situations convenient and safer for you.',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '1. Information We Collect'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'To provide you with the best emergency assistance, we collect the following types of information:',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- Personal Information: Includes your name, phone number, emergency contacts, address, and any other data you provide during registration or account setup.',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- Medical Information: Includes your medical history, allergies, medications, blood type, and any other relevant data you choose to provide to ensure appropriate response in emergencies.',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '2. How We Use Your Information'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text: 'We use your information for the following purposes:',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- Emergency Response: Your personal and medical information is used solely for facilitating appropriate emergency assistance during critical situations.',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- App Improvement: To improve our app’s functionality, troubleshoot issues, and develop new features.',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- Communication: To notify you of app updates, changes in our terms or policies, and any relevant information about H Pulse.',
            ),
            SimpleTextWidgetTheme(
              text:
                  'Note: We do not use your medical data for advertising or marketing purposes.',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '3. Information Sharing and Disclosure'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text: 'We only share your information in limited situations:',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- Emergency Situations: With your explicit consent, or as necessary, we may share your information with emergency responders and healthcare providers to ensure timely and accurate assistance.',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- Legal Compliance: We may disclose your information to law enforcement or government authorities if required by law.',
            ),
            SimpleTextWidgetTheme(
              text:
                  '- Third-Party Service Providers: We may share non-personally identifiable information with trusted third-party providers that assist in app functionality. They are required to follow data protection standards.',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '4. Data Security'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'We prioritize the security of your data by implementing technical, administrative, and physical security measures to protect against unauthorized access, alteration, disclosure, or destruction of your information.',
            ),
            SimpleTextWidgetTheme(
              text:
                  'However, no method of data transmission over the Internet or mobile networks can be guaranteed 100% secure. We strive to protect your data, but absolute security cannot be guaranteed.',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '5. Data Retention'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'We retain your personal and medical information only as long as it is necessary to provide our services, or as required by law. Upon request, you can delete your account and associated information through the app settings, or by contacting our support team.',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '6. Your Rights'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'You have certain rights over your data, including:\n- Access: Request access to your personal information held by us.\n- Correction: Update or correct any inaccuracies in your data.\n- Deletion: Request deletion of your personal data when it is no longer required.',
            ),
            SimpleTextWidgetTheme(
              text:
                  'To exercise these rights, please contact our support team at emergencyhealthcare2024@gmail.com',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '7. Changes to this Privacy Policy'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'We may update this Privacy Policy periodically to reflect changes in our practices or legal requirements. We will notify you of any significant changes through the app or via email. Your continued use of H Pulse after changes are made will constitute your acceptance of the updated policy.',
            ),
            SizedBox(height: 20.h),
            BoldTextWidgetTheme(text: '8. Contact Us'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'If you have any questions about this Privacy Policy, please contact us at:',
            ),
            SimpleTextWidgetTheme(
              text:
                  'H Pulse Support Team\nEmail: emergencyhealthcare2024@gmail.com\nPhone: +91 83308 62301',
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
