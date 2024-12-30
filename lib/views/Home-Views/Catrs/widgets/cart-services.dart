// import 'package:ecare/constants/linker.dart';
// import 'package:razorpay_web/razorpay_web.dart';

// class ApiService {
//   Future<List<Map<String, dynamic>>> fetchCartItems() async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     final cartCollection = FirebaseFirestore.instance
//         .collection('usersCartData')
//         .doc(userId)
//         .collection('Cart');
//     final querySnapshot = await cartCollection.get();
//     List<Map<String, dynamic>> cartItems = [];
//     for (var doc in querySnapshot.docs) {
//       cartItems.add({
//         'name': doc['name'],
//         'dob': doc['dob'],
//         'blood': doc['blood'],
//         'price': doc['price'],
//         'contact1': doc['contact1'],
//         'contact2': doc['contact2'],
//         'imageUrl': doc['imageUrl']
//       });
//     }
//     return cartItems;
//   }

//   int calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
//     return cartItems.fold(
//       0,
//       (sum, item) => sum + int.parse(item['price'] ?? '0'),
//     );
//   }

//   Future<void> deleteCartItem(int index) async {
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     final cartCollection = FirebaseFirestore.instance
//         .collection('usersCartData')
//         .doc(userId)
//         .collection('Cart');
//     final querySnapshot = await cartCollection.get();
//     if (querySnapshot.docs.isNotEmpty) {
//       final docId = querySnapshot.docs[index].id;
//       await cartCollection.doc(docId).delete();
//     }
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? cartData = prefs.getStringList('cartData') ?? [];
//     if (index < cartData.length) {
//       cartData.removeAt(index);
//       await prefs.setStringList('cartData', cartData);
//     }
//   }

//   void startPayment(int totalPrice, BuildContext context, Razorpay razorpay) {
//     var options = {
//       'key': 'rzp_test_4xCkdGHvFwGxuJ',
//       'amount': totalPrice * 100,
//       'name': 'E-Cart App',
//       'description': 'Order Payment',
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
//     };
//     try {
//       razorpay.open(options);
//     } catch (e) {
//       print("Error starting payment: $e");
//     }
//   }

//   Future<void> handlePaymentSuccess(
//       PaymentSuccessResponse response,
//       TextEditingController addressController,
//       TextEditingController pinCodeController,
//       List<Map<String, dynamic>> cartItems) async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     FirebaseFirestore.instance
//         .collection('orders')
//         .doc(userId)
//         .collection('payments')
//         .add({
//       'orderID': response.orderId,
//       'paymentID': response.paymentId,
//       'signature': response.signature,
//       'address': addressController.text,
//       'pincode': pinCodeController.text,
//       'cartItems': cartItems,
//     });
//     print('Payment success with Order ID: ${response.orderId}');
//     await FirebaseFirestore.instance
//         .collection('usersCartData')
//         .doc(userId)
//         .collection('Cart')
//         .get()
//         .then((value) {
//       for (DocumentSnapshot ds in value.docs) {
//         ds.reference.delete();
//       }
//     });
//   }

//   void handlePaymentError(
//       PaymentFailureResponse response, BuildContext context) {
//     print('Payment failed with Error code: ${response.code}');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Payment Failed: ${response.message}')),
//     );
//   }

//   void handleExternalWallet(ExternalWalletResponse response) {
//     print('External wallet selected: ${response.walletName}');
//   }
// }
