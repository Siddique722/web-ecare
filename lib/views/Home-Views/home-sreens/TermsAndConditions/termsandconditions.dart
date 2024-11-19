
import 'package:ecare/constants/linker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
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
            BoldTextWidgetTheme(text: 'Updated Terms and Conditions'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'These Terms and Conditions ("Terms") govern your use of E Care, including any associated websites, mobile applications, and services (collectively, the "App"). By accessing or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, do not access or use the App.',
            ),
            SizedBox(height: 20.h),

            // Section 1
            BoldTextWidgetTheme(text: '1. Use of the App'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(text: '1.1 *License*: E-Care grants you a limited, non-exclusive, non-transferable, and revocable license to use the App for your personal or internal business purposes.'),
            SimpleTextWidgetTheme(text: '1.2 *Registration*: To access certain features of the App, you must register an account and provide accurate, current, and complete information.'),
            SimpleTextWidgetTheme(
                text:
                    '1.3 *Healthcare Data*: The App may allow you to input, store, and manage healthcare data. E-Care is not a healthcare provider and does not provide medical advice. **Your medical data is stored securely in Google Cloud and cannot be accessed by others unless authorized by you.**'),
            SizedBox(height: 20.h),

            // Section 2
            BoldTextWidgetTheme(text: '2. Privacy'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(text: '2.1 *Privacy Policy*: Your use of the App is subject to our Privacy Policy.'),
            SimpleTextWidgetTheme(
                text:
                    '2.2 *Health Information*: Healthcare data inputted into the App is handled in accordance with applicable privacy laws and our Privacy Policy.'),
            SizedBox(height: 20.h),

            // Section 3
            BoldTextWidgetTheme(text: '3. Ecommerce'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(text: '3.1 *Purchases*: Products, including health cards, are offered for purchase within the App.'),
            SimpleTextWidgetTheme(text: '3.2 *Health Card Purchase*: Health cards are available for INR 50 each.'),
            SimpleTextWidgetTheme(
                text:
                    '3.3 *Delivery Duration*: Health cards are delivered within 14 to 30 days. Refunds for undelivered cards are processed on request.'),
            SimpleTextWidgetTheme(
                text:
                    '3.4 *Refund Policy for Cancellations*: Refunds for cancellations are processed within 5 to 7 business days.'),
            SizedBox(height: 20.h),

            // Section 4
            BoldTextWidgetTheme(text: '4. User Conduct'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '4.1 *Compliance*: Users must comply with all applicable laws. Unauthorized use or interference with the App is prohibited.'),
            SizedBox(height: 20.h),

            // Section 5
            BoldTextWidgetTheme(text: '5. Intellectual Property'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '5.1 *Ownership*: The App and its content are owned by E-Care and protected by intellectual property laws.'),
            SizedBox(height: 20.h),

            // Section 6
            BoldTextWidgetTheme(text: '6. Limitation of Liability'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '6.1 *Disclaimer*: The App is provided "as is." E-Care disclaims all warranties to the fullest extent permitted by law.'),
            SimpleTextWidgetTheme(
                text:
                    '6.2 *Limitation of Liability*: E-Care is not liable for indirect or incidental damages arising from App use.'),
            SizedBox(height: 20.h),

            // Section 7
            BoldTextWidgetTheme(text: '7. Governing Law and Dispute Resolution'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '7.1 *Governing Law*: These Terms are governed by the laws of Ernakulam jurisdiction.'),
            SimpleTextWidgetTheme(
                text:
                    '7.2 *Dispute Resolution*: Disputes will be resolved exclusively in Ernakulam courts.'),
            SizedBox(height: 20.h),

            // Section 8
            BoldTextWidgetTheme(text: '8. Changes to Terms'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '8.1 *Modification*: E-Care reserves the right to update these Terms. Continued use of the App indicates acceptance of revised Terms.'),
            SizedBox(height: 20.h),

            // Section 9
            BoldTextWidgetTheme(text: '9. Contact Us'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'If you have any questions, contact us at:\nEmail: emergencyhealthcare2024@gmail.com\nPhone: +91 83308 62301'),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
