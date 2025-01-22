 import 'dart:math';
 import 'package:ecare/constants/linker.dart';
import 'package:get/get.dart';




import 'package:get/get.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  Future<void> signUp(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    if(passwordController.text!=confirmPassword.text)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );

    }
    else
      {
        isLoading(true); // Start loading

        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

          User? user = userCredential.user;

          if (user != null) {
            String referralCode = _generateReferralCode();

            await FirebaseFirestore.instance
                .collection('UsersData')
                .doc(user.email)
                .set({
              'userEmail': user.email,
              'userId': user.uid,
              'userName': usernameController.text,
            });

            await FirebaseFirestore.instance
                .collection('ReferData')
                .doc(user.uid)
                .set({
              'referralCode': referralCode,
              'userId': user.uid,
              'userName': usernameController.text,
              'userEmail':emailController.text,
              'balance': '0',
              'pan':'',
              'upi':'',
              'address':''
            });

            Get.offAll(() =>  WraperScreen());
          }
        } catch (e) {
          Get.snackbar('Error', e.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.7),
              colorText: Colors.white);
        } finally {
          isLoading(false); // Stop loading
        }
      }
  }

  String _generateReferralCode() {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();

    String alphabets = String.fromCharCodes(
        Iterable.generate(3, (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))));
    String numbers = String.fromCharCodes(
        Iterable.generate(4, (_) => random.nextInt(10).toString().codeUnitAt(0)));

    return alphabets + numbers;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}


///-------------
///
// class SignupController extends GetxController {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final usernameController = TextEditingController();
//   final refferController = TextEditingController();
//
//   final formKey = GlobalKey<FormState>();
//   var isLoading = false.obs;
//
//   Future<void> signUp() async {
//     if (!formKey.currentState!.validate()) return;
//
//     isLoading(true); // Start loading
//
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//           email: emailController.text, password: passwordController.text);
//
//       User? user = userCredential.user;
//
//       if (user != null) {
//         // Generate a referral code for the new user
//         String referralCode = _generateReferralCode();
//
//         // If the referral field is not empty, validate it
//         if (refferController.text.isNotEmpty) {
//           // Fetch the document with the matching referral code
//           QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//               .collection('ReferData')
//               .where('referralCode', isEqualTo: refferController.text)
//               .get();
//
//           if (querySnapshot.docs.isEmpty) {
//             // Referral code does not match any record
//             Get.snackbar('Error', 'Incorrect referral code',
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.red.withOpacity(0.7),
//                 colorText: Colors.white);
//             return; // Stop further execution
//           } else {
//             // Referral code is valid, get the matching document
//             DocumentSnapshot referrerDoc = querySnapshot.docs.first;
//
//             // Update the referrer's myReffer subcollection
//             await FirebaseFirestore.instance
//                 .collection('ReferData')
//                 .doc(referrerDoc.id)
//                 .collection('myReffer')
//                 .doc(user.uid)
//                 .set({'referredUserId': user.uid});
//           }
//         }
//
//         // Add user data to the UsersData collection
//         await FirebaseFirestore.instance
//             .collection('UsersData')
//             .doc(user.email)
//             .set({
//           'userEmail': user.email,
//           'userId': user.uid,
//           'userName': usernameController.text,
//         });
//
//         // Add user data to the ReferData collection
//         await FirebaseFirestore.instance
//             .collection('ReferData')
//             .doc(user.uid)
//             .set({
//           'referralCode': referralCode,
//           'userId': user.uid,
//           'userName': usernameController.text,
//           'userEmail': emailController.text,
//           'balance': '0',
//           'pan': '',
//           'upi': '',
//           'address': ''
//         });
//
//         // Navigate to the next screen
//         Get.offAll(() => WraperScreen());
//       }
//     } catch (e) {
//       // Show error message if an exception occurs
//       Get.snackbar('Error', e.toString(),
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.withOpacity(0.7),
//           colorText: Colors.white);
//     } finally {
//       isLoading(false); // Stop loading
//     }
//   }
//
//   String _generateReferralCode() {
//     const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//     final random = Random();
//
//     String alphabets = String.fromCharCodes(
//         Iterable.generate(3, (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))));
//     String numbers = String.fromCharCodes(
//         Iterable.generate(4, (_) => random.nextInt(10).toString().codeUnitAt(0)));
//
//     return alphabets + numbers;
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     usernameController.dispose();
//     refferController.dispose();
//     super.onClose();
//   }
// }
