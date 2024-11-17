
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecare/constants/linker.dart';

class AffliateRegistration extends StatefulWidget {
  const AffliateRegistration({super.key});

  @override
  State<AffliateRegistration> createState() => _AffliateRegistrationState();
}

class _AffliateRegistrationState extends State<AffliateRegistration> {
  TextEditingController nameController = TextEditingController();
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
            BoldTextWidgetTheme(text: 'Registration for Affiliation'),
            SizedBox(height: 10.h),
            SimpleTextWidgetTheme(text: 'Create an extra stream of income'),
            SizedBox(height: 10.h),
            SizedBox(
              height: 10,
            ),
            LightDarktextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              hintText: 'Full Name',
            ),
            LightDarktextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              hintText: 'Email',
            ),
            LightDarktextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              hintText: 'PAnCardc Number',
            ),
            LightDarktextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              hintText: 'UPI ID',
            ),
            LightDarktextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              hintText: 'Full Address',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: BlueButton(text: 'Register')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
