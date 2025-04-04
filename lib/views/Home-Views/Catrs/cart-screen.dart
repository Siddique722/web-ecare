import 'dart:convert';
import 'dart:io' show Platform;
import 'package:ecare/razorpay_web.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_web/razorpay_web.dart';
import '../../../constants/linker.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:js' as js;

class CArtScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  int totalPrice;
  CArtScreen({required this.cartItems, required this.totalPrice});
  @override
  _CArtScreenState createState() => _CArtScreenState();
}

class _CArtScreenState extends State<CArtScreen> {
  Razorpay _razorpay = Razorpay();
  List<Map<String, dynamic>> firestoreCartItems = [];
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // Fetch data from Firestore
    _fetchCartItemsFromFirestore();
  }

  List<Map<String, dynamic>> fetchedCartItems = [];
  Future<void> _fetchCartItemsFromFirestore() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final cartCollection = FirebaseFirestore.instance
        .collection('usersCartData')
        .doc(userId)
        .collection('Cart');
    final querySnapshot = await cartCollection.get();
    for (var doc in querySnapshot.docs) {
      fetchedCartItems.add({
        'name': doc['name'],
        'dob': doc['dob'],
        'blood': doc['blood'],
        'price': doc['price'],
        'contact1': doc['contact1'],
        'contact2': doc['contact2'],
        'imageUrl': doc['imageUrl']
      });
    }
    setState(() {
      firestoreCartItems = fetchedCartItems;
      widget.totalPrice = firestoreCartItems.fold(
        0,
        (sum, item) => sum + int.parse(item['price'] ?? '0'),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Cart'),
      ),
      floatingActionButton:
          firestoreCartItems.isEmpty ? null : _buildFloatingActionButton(),
      body: firestoreCartItems.isEmpty
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Cart',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderHistoryScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Order History',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : _buildCartList(firestoreCartItems),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      margin: const EdgeInsets.only(left: 30),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.shade500,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total'),
              Row(
                children: [
                  Icon(Icons.currency_rupee, size: 17),
                  Text('${widget.totalPrice}'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _showCheckoutBottomSheet(context);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(List<Map<String, dynamic>> cartItems) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Cart',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistoryScreen(),
                ),
              );
            },
            child: Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Order History',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Card(
                child: ListTile(
                  title: Text('Name: ${item['name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date of Birth: ${item['dob']}'),
                      Text('Blood Group: ${item['blood']}'),
                      Text('Price: ${item['price']}'),
                      Text('Contact1: ${item['contact1']}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteCartItem(index);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }

  void _deleteCartItem(int index) async {
    setState(() {
      firestoreCartItems.removeAt(index);
    });
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final cartCollection = FirebaseFirestore.instance
        .collection('usersCartData')
        .doc(userId)
        .collection('Cart');
    final querySnapshot = await cartCollection.get();
    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs[index].id;
      await cartCollection.doc(docId).delete();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartData = prefs.getStringList('cartData') ?? [];
    if (index < cartData.length) {
      cartData.removeAt(index);
      await prefs.setStringList('cartData', cartData);
    }
    int updatedTotalPrice = firestoreCartItems.fold(
      0,
      (sum, item) => sum + int.parse(item['price'] ?? '0'),
    );
    setState(() {
      widget.totalPrice = updatedTotalPrice;
    });
  }

  void _showCheckoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // This allows the bottom sheet to resize with the keyboard
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjusts padding based on keyboard visibility
            left: 20.0, right: 20.0, top: 20.0,
          ),
          child: SingleChildScrollView(
            reverse:
                true, // This ensures the bottom sheet moves up when the keyboard appears
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                LightDarktextField(
                  controller: addressController,
                  hintText: 'Address',
                  keyboardType: TextInputType.text,
                ),
                LightDarktextField(
                  controller: pinCodeController,
                  hintText: 'Pin Code',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                ...firestoreCartItems.map(
                  (item) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name: ${item['name']}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.currency_rupee, size: 17),
                          Text('${item['price']}'),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee, size: 17),
                        Text(
                          '${widget.totalPrice}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                    // createOrderWithDio();
                    _startPayment();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Proceed to Payment',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> createOrder(
      int amount, String currency, String receipt) async {
    print(
        "Creating Razorpay order with amount: $amount, currency: $currency, receipt: $receipt");

    try {
      // Use your actual deployed backend URL here
      final response = await http.post(
        Uri.parse('https://your-backend-server.com/create-order'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'receipt': receipt,
        }),
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("Order created successfully. Order ID: ${jsonResponse['id']}");
        return jsonResponse['id'];
      } else {
        print('Error creating order: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception during order creation: $e');
      return null;
    }
  }

  Future<void> createOrderWithDio() async {
    const String url = "https://hpulse-api.onrender.com/create-order";

    // Order creation request body
    Map<String, dynamic> body = {
      "amount": widget.totalPrice, // Amount in paise (100 INR = 10000 paise)
      "currency": "INR",
      "receipt": "order_ihjureceipt_123",
      "payment_capture": "1",
    };

    try {
      Dio dio = Dio();

      // Sending POST request to the server
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.data['success']) {
        String orderId = response.data['order_id'];
        // _startPayment(orderId, int.parse(widget.totalPrice.toString()));
      } else {
        throw Exception(
            "Failed to create order: ${response.data['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      print("Error creating order: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order creation failed: $e")),
      );
    }
  }

  void _startPayment() async {
    print("Starting payment process...");

    if (kIsWeb) {
      // Web-specific Razorpay integration
      var options = {
        'key': 'rzp_live_amIyo5XZmakZUK',
        'amount': widget.totalPrice * 100,
        'currency': 'INR',
        'name': 'H Pulse',
        'description': 'Order Payment',
        'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
        'handler': (response) {
          _handlePaymentSuccessWeb(response);
        }
      };

      // Load Razorpay script if not already loaded
      if (!js.context.hasProperty('Razorpay')) {
        final script =
            js.context['document'].callMethod('createElement', ['script']);
        script['src'] = 'https://checkout.razorpay.com/v1/checkout.js';
        script['async'] = true;
        js.context['document']['head'].callMethod('appendChild', [script]);
      }

      // Initialize Razorpay
      final razorpay =
          js.JsObject(js.context['Razorpay'], [js.JsObject.jsify(options)]);
      razorpay.callMethod('open');
    } else {
      // Mobile integration
      final orderId = await createOrder(widget.totalPrice, 'INR', 'receipt123');
      if (orderId == null) {
        print('Failed to create order. Order ID is null.');
        return;
      }

      var options = {
        'key': 'rzp_live_amIyo5XZmakZUK',
        'amount': widget.totalPrice * 100,
        'currency': 'INR',
        'order_id': orderId,
        'name': 'H Pulse',
        'description': 'Order Payment',
        'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        print("Error starting payment: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment initiation failed: $e")),
        );
      }
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Success Handler Called");
    print("Payment ID: ${response.paymentId}");
    print("Order ID: ${response.orderId}");
    print("Signature: ${response.signature}");

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final cartCollection = FirebaseFirestore.instance.collection('CartData');
      final userCartCollection = FirebaseFirestore.instance
          .collection('usersCartData')
          .doc(userId)
          .collection('Cart');
      final String currentDate =
          DateFormat('yyyy-MM-dd').format(DateTime.now());

      print('Starting to save payment data to Firestore...');
      for (var item in firestoreCartItems) {
        print('Saving item: ${item['name']} with price: ${item['price']}');
        await cartCollection.add({
          'imageUrl': item['imageUrl'],
          'name': item['name'] ?? '',
          'dob': item['dob'] ?? '',
          'blood': item['blood'] ?? '',
          'price': item['price'] ?? '',
          'contact1': item['contact1'] ?? '',
          'contact2': item['contact2'] ?? '',
          'orderNumber': generateRandomOrderNumber(),
          'userId': userId,
          'orderId': response.orderId,
          'paymentId': response.paymentId,
          'address': addressController.text.toString(),
          'pinCode': pinCodeController.text.toString(),
          'date': currentDate,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      final userCartDocs = await userCartCollection.get();
      for (var doc in userCartDocs.docs) {
        print('Deleting cart item from user cart: ${doc.id}');
        await doc.reference.delete();
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      setState(() {
        firestoreCartItems.clear();
        widget.totalPrice = 0;
      });

      print("Payment processed and cart cleared successfully.");
      _showSuccessDialog();
    } catch (e) {
      print('Error in payment success handling: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error Handler Called");
    print("Error Code: ${response.code}");
    print("Error Description: ${response.message}");
    print("Error Error: ${response.error}");
    print("Error Data: ${response.code}");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Failed"),
          content: Text(
              "Something went wrong. Please try again. Error: ${response.message}"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Handler Called");
    print("Wallet Name: ${response.walletName}");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("External Wallet Selected"),
          content: Text(
              "Payment redirected to external wallet: ${response.walletName}"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handlePaymentSuccessWeb(dynamic response) async {
    print("Payment Success (Web): ${response['razorpay_payment_id']}");
    try {
      final paymentId = response['razorpay_payment_id'];
      final orderId = response['razorpay_order_id'];
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final cartCollection = FirebaseFirestore.instance.collection('CartData');
      final userCartCollection = FirebaseFirestore.instance
          .collection('usersCartData')
          .doc(userId)
          .collection('Cart');
      final String currentDate =
          DateFormat('yyyy-MM-dd').format(DateTime.now());

      for (var item in firestoreCartItems) {
        await cartCollection.add({
          'imageUrl': item['imageUrl'],
          'name': item['name'] ?? '',
          'dob': item['dob'] ?? '',
          'blood': item['blood'] ?? '',
          'price': item['price'] ?? '',
          'contact1': item['contact1'] ?? '',
          'contact2': item['contact2'] ?? '',
          'orderNumber': generateRandomOrderNumber(),
          'userId': userId,
          'orderId': orderId,
          'paymentId': paymentId,
          'address': addressController.text.toString(),
          'pinCode': pinCodeController.text.toString(),
          'date': currentDate,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      final userCartDocs = await userCartCollection.get();
      for (var doc in userCartDocs.docs) {
        await doc.reference.delete();
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      setState(() {
        firestoreCartItems.clear();
        widget.totalPrice = 0;
      });

      _showSuccessDialog();
    } catch (e) {
      print('Error processing payment and updating Firestore: $e');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Success"),
          content:
              Text("Thank you for your purchase! Your order is confirmed."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String generateRandomOrderNumber() {
    var rng = Random();
    return (rng.nextInt(900000) + 100000).toString();
  }
}
