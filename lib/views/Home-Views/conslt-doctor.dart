// import 'package:demo_app/widgets/blue-button.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:url_launcher/url_launcher.dart';

import 'package:ecare/constants/linker.dart';

class ConsultDoctor extends StatefulWidget {
  const ConsultDoctor({super.key});

  @override
  State<ConsultDoctor> createState() => _ConsultDoctorState();
}

class _ConsultDoctorState extends State<ConsultDoctor> {
  bool isAccepted = false;

  void _launchWhatsApp() async {
    const url = 'https://wa.me/message/WH7SIKQF2M45I1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Please accept the terms and conditions'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            BoldTextWidgetTheme(text: 'Consult a Doctor'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(
              text:
                  'Our online doctor consultation service offers accessible healthcare support for non-emergency medical conditions and secondary opinions, from licensed professionals. Please note, this platform is not suitable for emergency situations such as chest pain, upper back pain, severe abdominal or epigastric pain, sudden weakness in hands or legs, sudden facial deviation, slurred speech or symptoms of acute stroke, loss of consciousness, or sudden testicular pain. For these symptoms, seek immediate in-person medical care.',
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Checkbox(
                  value: isAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      isAccepted = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: SimpleTextWidgetTheme(
                    text: 'I accept the terms and conditions',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: isAccepted
                  ? _launchWhatsApp
                  : () {
                      _showSnackBar(context);
                    },
              child: BlueButton(
                text: 'Consult via WhatsApp',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  