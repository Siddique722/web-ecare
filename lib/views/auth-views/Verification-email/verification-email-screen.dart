import 'dart:async';

import 'package:ecare/views/auth-views/login-view.dart';
import 'package:flutter/cupertino.dart';

import 'package:ecare/constants/linker.dart';

class EmailVerificationLink extends StatefulWidget {
  const EmailVerificationLink({super.key});

  @override
  State<EmailVerificationLink> createState() => _EmailVerificationLinkState();
}

class _EmailVerificationLinkState extends State<EmailVerificationLink> {
  final _auth = AuthServices();
  late Timer timer;
  late Timer countdownTimer;
  int countdown = 60;
  bool isResendButtonVisible = false;

  @override
  void initState() {
    super.initState();
    sendVerificationEmail();
    startEmailVerificationCheck();
    startCountdown();
  }

  void sendVerificationEmail() {
    _auth.sendEmailVerificationLink().then((_) {
      Fluttertoast.showToast(
        msg: "Verification email sent successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Failed to send verification email. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

 void startEmailVerificationCheck() {
  timer = Timer.periodic(Duration(seconds: 5), (timer) async {
    await FirebaseAuth.instance.currentUser?.reload();
    User? user = FirebaseAuth.instance.currentUser;

    // if (user != null && user.emailVerified==true) {
    //   timer.cancel();
    //   countdownTimer.cancel();
    //   Navigator.pushReplacement(
    //     context,
    //     CupertinoPageRoute(builder: (context) => WraperScreen()),
    //   );
    // }
  });
}

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
        if (countdown <= 0) {
          isResendButtonVisible = true;
          timer.cancel();
        }
      });
    });
  }

  void resetCountdown() {
    setState(() {
      countdown = 60;
      isResendButtonVisible = false;
    });
    startCountdown();
  }

  void logout() {
    FirebaseAuth.instance.signOut().then((_) {
      Fluttertoast.showToast(
        msg: "Logged out successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => LoginView()),
      );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Failed to log out. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Email Verification'),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: logout,
        ),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoldTextWidgetTheme(text: 'Verification Screen'),
          SimpleTextWidgetTheme(
              text: 'We have sent an email for verification to ${FirebaseAuth.instance.currentUser?.email ?? 'your email'}'),
          SizedBox(height: 20),
          isResendButtonVisible
              ? InkWell(
                  onTap: () {
                    sendVerificationEmail();
                    resetCountdown();
                  },
                  child: BlueButton(text: 'Resend Verification Email'),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SimpleTextWidgetTheme(text: 'Resend Email in '),
                    BoldTextWidgetTheme(text: '$countdown seconds'),
                  ],
                ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              String currentEmail =
                  FirebaseAuth.instance.currentUser?.email ?? '';
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => EmailEditScreen(email: currentEmail,),
                ),
              ).then((value) {
                // Restart the verification check
                startEmailVerificationCheck();
              });
            },
            child: BlueButton(text: 'Edit Email'),
          ),
        ],
      ),
    ),
  );
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Email Verification'),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.logout),
  //           onPressed: logout,
  //         ),
  //       ],
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           BoldTextWidgetTheme(text: 'Verification Screen'),
  //           SimpleTextWidgetTheme(
  //               text: 'We have sent an email for verification.'),
  //           SizedBox(height: 20),
  //           isResendButtonVisible
  //               ? InkWell(
  //                   onTap: () {
  //                     sendVerificationEmail();
  //                     resetCountdown();
  //                   },
  //                   child: BlueButton(text: 'Resend Verification Email'),
  //                 )
  //               : Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     SimpleTextWidgetTheme(text: 'Resend Email in '),
  //                     BoldTextWidgetTheme(text: '$countdown seconds'),
  //                   ],
  //                 ),
  //           SizedBox(height: 20),
  //           InkWell(
  //             onTap: () {
  //               String currentEmail =
  //                   FirebaseAuth.instance.currentUser!.email!;
  //               Navigator.push(
  //                 context,
  //                 CupertinoPageRoute(
  //                   builder: (context) =>
  //                       EmailEditScreen(email: currentEmail),
  //                 ),
  //               ).then((value) {
  //                 startEmailVerificationCheck();
  //               });
  //             },
  //             child: BlueButton(text: 'Edit Email'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    timer.cancel();
    countdownTimer.cancel();
    super.dispose();
  }
}
