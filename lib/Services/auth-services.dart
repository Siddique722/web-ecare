import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/Create-Profile-Views/create-profile/create-profile.dart';
import '../views/Home-Views/Nav-Bar/nav-bar-.dart'; // If using SharedPref

// class AuthServices
// {
//   final _auth=FirebaseAuth.instance;

//   Future<void>sendEmailVerificationLink()async
//   {
//     try
//     {
//       await _auth.currentUser?.sendEmailVerification();
//     }
//     catch (e)
//     {
//       print('error:$e');
//     }
//   }
// }

class AuthServices {
  Future<void> sendEmailVerificationLink() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> verifyBeforeUpdateEmail(String newEmail) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.verifyBeforeUpdateEmail(newEmail);
    }
  }
}

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Google Sign-In method
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      User? userDetails = result.user;

      if (result != null && userDetails != null) {
        await _handleUserData(context, userDetails);
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
    }
  }

  // Apple Sign-In method
  Future<void> signInWithApple(BuildContext context) async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final AuthCredential credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      User? userDetails = result.user;

      if (result != null && userDetails != null) {
        await _handleUserData(context, userDetails);
      }
    } catch (e) {
      print('Apple Sign-In Error: $e');
    }
  }

  String _generateReferralCode() {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();

    // Generate 3 random alphabets
    String alphabets = String.fromCharCodes(Iterable.generate(
        3, (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))));

    // Generate 4 random numbers
    String numbers = String.fromCharCodes(Iterable.generate(
        4, (_) => random.nextInt(10).toString().codeUnitAt(0)));

    return alphabets + numbers; // Combine and return the referral code
  }

  // Common method to handle user data in Firestore
  Future<void> _handleUserData(BuildContext context, User userDetails) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('UsersData')
        .doc(userDetails.uid)
        .get();

    if (userDoc.exists) {
      SharedPref.saveLoginStatus(true);
      //  Navigator.pushReplacementNamed(context, routeDashboard);
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => NavBarExample()));
    } else {
      String referralCode = _generateReferralCode();
      Map<String, dynamic> userInfoMap = {
        "userEmail": userDetails.email,
        "userName": userDetails.displayName,
        "userId": userDetails.uid,
      };

      await FirebaseFirestore.instance
          .collection('UsersData')
          .doc(userDetails.uid)
          .set(userInfoMap);
      await FirebaseFirestore.instance
          .collection('ReferData')
          .doc(userDetails.uid)
          .set({
        'referralCode': referralCode,
        'userId': userDetails.uid,
        'userName': userDetails.displayName,
        'balance': '0',
        'pan': '',
        'upi': '',
        'address': '',
        'userEmail': userDetails.email,
      });
      SharedPref.saveLoginStatus(true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CreateProfileScreen(role: 'register'),
        ),
      );
    }
  }
}

class DatabaseMethods {
  Future<void> addUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .set(userInfoMap)
        .then((value) {
      SnackBar(content: Text('Signup successfully......'));
    }).onError((error, stackTrace) {
      SnackBar(content: Text("Error: $error"));
    });
  }
}

class SharedPref {
  static const String KEY_LOCATION = "location";
  static const String _loginStatusKey = 'login_status';

  static Future<void> saveLocation(String location) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_LOCATION, location);
  }

  static Future<String?> getLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_LOCATION);
  }

  static Future<void> saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginStatusKey, status);
  }

  // Get login status
  static Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginStatusKey) ?? false;
  }

  static Future<void> removeLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginStatusKey);
  }
}
