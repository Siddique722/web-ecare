// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TermsAndCondition extends StatefulWidget {
//   const TermsAndCondition({super.key});

//   @override
//   State<TermsAndCondition> createState() => _TermsAndConditionState();
// }

// class _TermsAndConditionState extends State<TermsAndCondition> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BoldTextWidgetTheme(text: 'Updated Terms and Conditions'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//               text:
//                   'These Terms and Conditions ("Terms") govern your use of E Care, including any associated websites, mobile applications, and services (collectively, the "App"). By accessing or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, do not access or use the App.',
//             ),
//             SizedBox(height: 20.h),

//             // Section 1
//             BoldTextWidgetTheme(text: '1. Use of the App'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(text: '1.1 *License*: E-Care grants you a limited, non-exclusive, non-transferable, and revocable license to use the App for your personal or internal business purposes.'),
//             SimpleTextWidgetTheme(text: '1.2 *Registration*: To access certain features of the App, you must register an account and provide accurate, current, and complete information.'),
//             SimpleTextWidgetTheme(
//                 text:
//                     '1.3 *Healthcare Data*: The App may allow you to input, store, and manage healthcare data. E-Care is not a healthcare provider and does not provide medical advice. **Your medical data is stored securely in Google Cloud and cannot be accessed by others unless authorized by you.**'),
//             SizedBox(height: 20.h),

//             // Section 2
//             BoldTextWidgetTheme(text: '2. Privacy'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(text: '2.1 *Privacy Policy*: Your use of the App is subject to our Privacy Policy.'),
//             SimpleTextWidgetTheme(
//                 text:
//                     '2.2 *Health Information*: Healthcare data inputted into the App is handled in accordance with applicable privacy laws and our Privacy Policy.'),
//             SizedBox(height: 20.h),

//             // Section 3
//             BoldTextWidgetTheme(text: '3. Ecommerce'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(text: '3.1 *Purchases*: Products, including health cards, are offered for purchase within the App.'),
//             SimpleTextWidgetTheme(text: '3.2 *Health Card Purchase*: Health cards are available for INR 50 each.'),
//             SimpleTextWidgetTheme(
//                 text:
//                     '3.3 *Delivery Duration*: Health cards are delivered within 14 to 30 days. Refunds for undelivered cards are processed on request.'),
//             SimpleTextWidgetTheme(
//                 text:
//                     '3.4 *Refund Policy for Cancellations*: Refunds for cancellations are processed within 5 to 7 business days.'),
//             SizedBox(height: 20.h),

//             // Section 4
//             BoldTextWidgetTheme(text: '4. User Conduct'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//                 text:
//                     '4.1 *Compliance*: Users must comply with all applicable laws. Unauthorized use or interference with the App is prohibited.'),
//             SizedBox(height: 20.h),

//             // Section 5
//             BoldTextWidgetTheme(text: '5. Intellectual Property'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//                 text:
//                     '5.1 *Ownership*: The App and its content are owned by E-Care and protected by intellectual property laws.'),
//             SizedBox(height: 20.h),

//             // Section 6
//             BoldTextWidgetTheme(text: '6. Limitation of Liability'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//                 text:
//                     '6.1 *Disclaimer*: The App is provided "as is." E-Care disclaims all warranties to the fullest extent permitted by law.'),
//             SimpleTextWidgetTheme(
//                 text:
//                     '6.2 *Limitation of Liability*: E-Care is not liable for indirect or incidental damages arising from App use.'),
//             SizedBox(height: 20.h),

//             // Section 7
//             BoldTextWidgetTheme(text: '7. Governing Law and Dispute Resolution'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//                 text:
//                     '7.1 *Governing Law*: These Terms are governed by the laws of Ernakulam jurisdiction.'),
//             SimpleTextWidgetTheme(
//                 text:
//                     '7.2 *Dispute Resolution*: Disputes will be resolved exclusively in Ernakulam courts.'),
//             SizedBox(height: 20.h),

//             // Section 8
//             BoldTextWidgetTheme(text: '8. Changes to Terms'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//                 text:
//                     '8.1 *Modification*: E-Care reserves the right to update these Terms. Continued use of the App indicates acceptance of revised Terms.'),
//             SizedBox(height: 20.h),

//             // Section 9
//             BoldTextWidgetTheme(text: '9. Contact Us'),
//             SizedBox(height: 10.h),
//             SimpleTextWidgetTheme(
//                 text:
//                     'If you have any questions, contact us at:\nEmail: emergencyhealthcare2024@gmail.com\nPhone: +91 83308 62301'),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
// }

//--------
import 'package:ecare/widgets/text-widgets.dart';
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
                  'These Terms and Conditions ("Terms") govern your use of H Pulse, including any associated websites, mobile applications, and services (collectively, the "App"). By accessing or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, do not access or use the App.',
            ),
            SizedBox(height: 20.h),

            // Section 1
            BoldTextWidgetTheme(text: '1. Use of the App'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '1.1 *License*: Subject to these Terms, H Pulse grants you a limited, non-exclusive, non-transferable, and revocable license to use the App for your personal or internal business purposes.'),
            SimpleTextWidgetTheme(
                text:
                    '1.2 *Registration*: To access certain features of the App, you may be required to register an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.'),
            SimpleTextWidgetTheme(
                text:
                    '1.3 *Healthcare Data*: The App may allow you to input, store, and manage healthcare data, including but not limited to medical records, treatment plans, and health metrics. You acknowledge and agree that H Pulse is not a healthcare provider and does not provide medical advice. You are solely responsible for the accuracy and legality of any healthcare data you input into the App. **THE MEDICAL DATA OF EACH INDIVIDUAL WILL BE STORED IN GOOGLE CLOUD UNDER USERNAME AND CANNOT BE ACCESSED BY ANYONE. YOU ALWAYS HAVE THE OPTION TO SKIP THOSE FIELDS.**'),
            SizedBox(height: 20.h),

            // Section 2
            BoldTextWidgetTheme(text: '2. Privacy'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '2.1 *Privacy Policy*: Your use of the App is subject to our Privacy Policy, which explains how we collect, use, and disclose your information. By using the App, you consent to the collection, use, and disclosure of your information as described in the Privacy Policy.'),
            SimpleTextWidgetTheme(
                text:
                    '2.2 *Health Information*: You acknowledge and agree that certain healthcare data you input into the App may constitute sensitive personal information. We will handle such information in accordance with applicable privacy laws and our Privacy Policy.'),
            SizedBox(height: 20.h),

            // Section 3
            BoldTextWidgetTheme(text: '3. Ecommerce'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '3.1 *Purchases*: The App may offer products or services for sale ("Products"). By placing an order through the App, you represent and warrant that you have the legal right to purchase the Products.'),
            SimpleTextWidgetTheme(
                text:
                    '3.2 *Health Card Purchase*: You may purchase a health card through the App for a fee of INR 50 per card. By making the payment, you agree to the specified terms of sale.'),
            SimpleTextWidgetTheme(
                text:
                    '3.3 *Payment*: Payment for Products, including health cards, purchased through the App will be processed through third-party payment processors. You agree to provide accurate and complete payment information and authorize us to charge your payment method for any purchases made through the App.'),
            SimpleTextWidgetTheme(
                text:
                    '3.4 *Delivery Duration*: Health cards will be delivered within a minimum period of 14 days and a maximum period of 30 days from the date of purchase.'),
            SimpleTextWidgetTheme(
                text:
                    '3.5 *Refund Policy for Non-Delivery*: If the health card is not delivered within the maximum delivery period of 30 days, you are entitled to a full refund of the amount paid. Refund requests must be made by contacting us through the details provided below.'),
            SimpleTextWidgetTheme(
                text:
                    '3.6 *Refund Policy for Cancellations*: If you cancel a product or service, the refund will be processed within 5 to 7 business days and may take additional time to reflect in your bank account depending on your bank\'s processing policies.'),
            SimpleTextWidgetTheme(
                text:
                    '3.7 *Shipping and Returns*: Shipping and return policies for Products purchased through the App will be as specified at the time of purchase.'),
            SizedBox(height: 20.h),

            // Section 4
            BoldTextWidgetTheme(text: '4. User Conduct'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '4.1 *Compliance*: You agree to comply with all applicable laws, rules, and regulations when using the App.'),
            SimpleTextWidgetTheme(
                text:
                    '4.2 *Prohibited Conduct*: You agree not to:\n- Use the App in any manner that could interfere with, disrupt, negatively affect, or inhibit other users from fully enjoying the App, or that could damage, disable, overburden, or impair the functioning of the App;\n- Use the App for any illegal, harmful, or unauthorized purpose;\n- Attempt to gain unauthorized access to the App or its related systems or networks.'),
            SizedBox(height: 20.h),

            // Section 5
            BoldTextWidgetTheme(text: '5. Intellectual Property'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '5.1 *Ownership*: The App and all content, features, and functionality thereof are owned by H Pulse or its licensors and are protected by copyright, trademark, and other intellectual property laws.'),
            SimpleTextWidgetTheme(
                text:
                    '5.2 *License Restrictions*: Except as expressly permitted by these Terms, you may not reproduce, distribute, modify, create derivative works of, publicly display, publicly perform, republish, download, store, or transmit any of the material on the App.'),
            SizedBox(height: 20.h),

            // Section 6
            BoldTextWidgetTheme(text: '6. Limitation of Liability'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '6.1 *Disclaimer*: TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, THE APP IS PROVIDED "AS IS" AND H PULSE DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.'),
            SimpleTextWidgetTheme(
                text:
                    '6.2 *Limitation of Liability*: H PULSE, ITS AFFILIATES, LICENSORS, SERVICE PROVIDERS, EMPLOYEES, AGENTS, OFFICERS, AND DIRECTORS WILL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES ARISING OUT OF OR IN CONNECTION WITH YOUR USE OF THE APP.'),
            SizedBox(height: 20.h),

            // Section 7
            BoldTextWidgetTheme(text: '7. Governing Law and Dispute Resolution'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '7.1 *Governing Law*: These Terms shall be governed by and construed in accordance with the laws, without regard to its conflict of law principles.'),
            SimpleTextWidgetTheme(
                text:
                    '7.2 *Dispute Resolution*: Any dispute arising out of or relating to these Terms or the App shall be exclusively resolved in the state or federal courts located in Ernakulam, and you consent to the personal jurisdiction and venue of such courts.'),
            SizedBox(height: 20.h),

            // Section 8
            BoldTextWidgetTheme(text: '8. Changes to Terms'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    '8.1 *Modification*: H Pulse reserves the right to modify or revise these Terms at any time. We will provide notice of any material changes by posting the revised Terms on the App or by other reasonable means. Your continued use of the App following the posting of the revised Terms constitutes your acceptance of such changes.'),
            SizedBox(height: 20.h),

            // Section 9
            BoldTextWidgetTheme(text: '9. Contact Us'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'If you have any questions, contact us at:\n*Email*: emergencyhealthcare2024@gmail.com\n*Phone*: +91 83308 62301'),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
