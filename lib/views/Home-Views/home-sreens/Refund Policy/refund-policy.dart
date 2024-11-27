import 'package:ecare/widgets/text-widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefundPolicy extends StatefulWidget {
  const RefundPolicy({super.key});

  @override
  State<RefundPolicy> createState() => _RefundPolicyState();
}

class _RefundPolicyState extends State<RefundPolicy> {
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
            BoldTextWidgetTheme(text: 'Cancellation and Refund Policy for H Pulse Health Cards'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'Thank you for choosing H Pulse for your healthcare needs. Please carefully review our cancellation and refund policy for health card purchases:',
            ),
            SizedBox(height: 20.h),

            // Section 1
            BoldTextWidgetTheme(text: '1. Non-Refundable Once Created'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'Once a health card is successfully created, the purchase amount of ₹50 is non-refundable. Cancellations or refund requests for cards that have already been generated will not be entertained.'),
            SizedBox(height: 20.h),

            // Section 2
            BoldTextWidgetTheme(text: '2. Replacement Policy'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'If you do not receive your health card or receive a physically damaged card with unreadable or unrecognizable credentials, you are eligible for a free replacement. Please contact our support team within 7 days of delivery to report such issues.'),
            SizedBox(height: 20.h),

            // Section 3
            BoldTextWidgetTheme(text: '3. Refund Policy for Failed Deliveries'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'If the replacement card cannot be delivered due to unforeseen circumstances, a refund may be processed. Refunds, if applicable, will be processed within *5 to 7 business days*, subject to your bank\'s policies and timelines.'),
            SizedBox(height: 20.h),

            // Section 4
            BoldTextWidgetTheme(text: '4. How to Raise an Issue'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
                text:
                    'To request a replacement or refund, contact our customer support team via the app or email us at emergencyhealthcare2024@gmail.com. Provide your purchase details and any supporting documents (e.g., receipt or photos of the damaged card).'),
            SizedBox(height: 20.h),

            SimpleTextWidgetTheme(
                text:
                    'This policy ensures transparency and fairness while addressing any inconvenience caused. Thank you for your understanding and cooperation.'),
            SizedBox(height: 20.h),

            SimpleTextWidgetTheme(text: 'Last Updated: 20/11/2024'),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
