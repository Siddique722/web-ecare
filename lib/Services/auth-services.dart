import 'package:firebase_auth/firebase_auth.dart';

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
