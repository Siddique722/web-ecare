// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_app/views/Create-Profile-Views/create-profile.dart';
// import 'package:demo_app/views/Home-Views/Catrs/add-cart.dart';
// import 'package:demo_app/views/Home-Views/Catrs/cart-screen.dart';
// import 'package:demo_app/views/Home-Views/Nav-Bar/nav-bar-.dart';
// import 'package:demo_app/widgets/blue-button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecare/constants/linker.dart';

import 'package:flutter/cupertino.dart';

class AvailableCards extends StatefulWidget {
  final String userid;

  AvailableCards({super.key, required this.userid});

  @override
  State<AvailableCards> createState() => _AvailableCardsState();
}

class _AvailableCardsState extends State<AvailableCards> {
  late Stream<QuerySnapshot> cartStream;
  late List<String> cartItemNames; // List to hold names of items in the cart
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    cartItemNames = []; // Initialize the list
    cartStream = FirebaseFirestore.instance
        .collection('usersCartData')
        .doc(widget.userid)
        .collection('Cart')
        .snapshots();

    _updateCartCountAndItems();
  }

  // Function to update cart count and items
  void _updateCartCountAndItems() {
    cartStream.listen((snapshot) {
      setState(() {
        cartItemCount = snapshot.docs.length;
        cartItemNames =
            snapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => NavBarExample()));
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          title: BoldTextWidgetTheme(text: 'Available Cards'),
          actions: [
            StreamBuilder<QuerySnapshot>(
              stream: cartStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return IconButton(
                    icon: Icon(Icons.shopping_cart_sharp),
                    onPressed: null,
                  );
                }

                return Stack(
                  children: [
                    IconButton(
                      onPressed: () async {
                        // Navigate to CartScreen
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CArtScreen(
                              cartItems: snapshot.data?.docs.map((doc) {
                                    return {
                                      'name': doc['name'],
                                      'price': doc['price'],
                                      // 'contact1': doc[''],
                                      // 'contact2': doc[''],
                                      // 'image': doc['profileImage'],
                                    };
                                  }).toList() ??
                                  [],
                              totalPrice: snapshot.data!.docs.length * 50 ?? 0,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart_sharp),
                    ),
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${snapshot.data!.docs.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('userProfileData')
                    .doc(widget.userid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  final user = snapshot.data!.data() as Map<String, dynamic>;
                  final userName = user['name'] ?? 'No Name';
                  return cartItemNames.contains(userName)
                      ? Container() // Hide if name is already in cart
                      : Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () async {
                              final addedItem = await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => AddCart(
                                    primaryContact: user['primaryContact'],
                                    contact1: user['emergencyContact1'],
                                    contact2: user['emergencyContact2'],
                                    image: user['profileImage'],
                                    name: user['name'],
                                    dob: user['dateOfBirth'],
                                    blood: user['bloodGroup'],
                                  ),
                                ),
                              );
                              // if (addedItem != null) {
                              //   FirebaseFirestore.instance
                              //       .collection('usersCartData')
                              //       .doc(widget.userid)
                              //       .collection('Cart')
                              //       .add({
                              //     'name': addedItem,
                              //     'price': '50',
                              //   });
                              // }
                            },
                            title: Text(userName),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user['profileImage']),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date of Birth: ${user['dateOfBirth']}'),
                                Text('Blood Group: ${user['bloodGroup']}'),
                              ],
                            ),
                          ),
                        );
                },
              ),
            ),
            Expanded(
              flex: 88,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('familyUser')
                      .doc(widget.userid)
                      .collection('userProfileData')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final users = snapshot.data?.docs ?? [];
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user =
                            users[index].data() as Map<String, dynamic>;
                        final userName = user['name'] ?? 'No Name';
                        return cartItemNames.contains(userName)
                            ? Container() // Hide if name is already in cart
                            : Card(
                                margin: EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () async {
                                    final addedItem = await Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => AddCart(
                                          primaryContact: user['primaryContact'],
                                          contact1: user['emergencyContact1'],
                                          contact2: user['emergencyContact2'],
                                          image: user['profileImage'],
                                          name: user['name'],
                                          dob: user['dateOfBirth'],
                                          blood: user['bloodGroup'],
                                        ),
                                      ),
                                    );
                                    // if (addedItem != null) {
                                    //   FirebaseFirestore.instance
                                    //       .collection('usersCartData')
                                    //       .doc(widget.userid)
                                    //       .collection('Cart')
                                    //       .add({
                                    //     'name': addedItem,
                                    //     'price': '50',
                                    //   });
                                    // }
                                  },
                                  title: Text(userName),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user['profileImage']),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Date of Birth: ${user['dateOfBirth']}'),
                                      Text(
                                          'Blood Group: ${user['bloodGroup']}'),
                                    ],
                                  ),
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



///TODO:-
// class _AvailableCardsState extends State<AvailableCards> {
//   late Stream<QuerySnapshot> cartStream;
//   late List<String> cartItemNames; // List to hold names of items in the cart
//   late List<String> existingCartItemNames; // List to hold names already in CartData
//   int cartItemCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     cartItemNames = []; // Initialize the list
//     existingCartItemNames = []; // Initialize the list for existing cart items
//     cartStream = FirebaseFirestore.instance
//         .collection('usersCartData')
//         .doc(widget.userid)
//         .collection('Cart')
//         .snapshots();

//     _updateCartCountAndItems();
//     _fetchExistingCartItems();
//   }

//   // Function to update cart count and items
//   void _updateCartCountAndItems() {
//     cartStream.listen((snapshot) {
//       setState(() {
//         cartItemCount = snapshot.docs.length;
//         cartItemNames = snapshot.docs.map((doc) => doc['name'] as String).toList();
//       });
//     });
//   }

//   // Function to fetch existing items in CartData
//   void _fetchExistingCartItems() async {
//     final cartDataSnapshot = await FirebaseFirestore.instance
//         .collection('CartData')
//         .where('userId', isEqualTo: widget.userid)
//         .get();

//     setState(() {
//       existingCartItemNames = cartDataSnapshot.docs.map((doc) => doc['name'] as String).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   CupertinoPageRoute(builder: (context) => NavBarExample()));
//             },
//             icon: Icon(Icons.arrow_back)),
//         backgroundColor: Colors.transparent,
//         title: BoldTextWidgetTheme(text: 'Available Cards'),
//         actions: [
//           StreamBuilder<QuerySnapshot>(
//             stream: cartStream,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return IconButton(
//                   icon: Icon(Icons.shopping_cart_sharp),
//                   onPressed: null,
//                 );
//               }

//               return Stack(
//                 children: [
//                   IconButton(
//                     onPressed: () async {
//                       // Navigate to CartScreen
//                       await Navigator.push(
//                         context,
//                         CupertinoPageRoute(
//                           builder: (context) => CArtScreen(
//                             cartItems: snapshot.data?.docs.map((doc) {
//                               return {
//                                 'name': doc['name'],
//                                 'price': doc['price'],
//                               };
//                             }).toList() ?? [],
//                             totalPrice: snapshot.data!.docs.length * 50 ?? 0,
//                           ),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.shopping_cart_sharp),
//                   ),
//                   if (snapshot.hasData && snapshot.data!.docs.isNotEmpty)
//                     Positioned(
//                       right: 8,
//                       top: 8,
//                       child: Container(
//                         padding: EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         constraints: BoxConstraints(
//                           minWidth: 16,
//                           minHeight: 16,
//                         ),
//                         child: Text(
//                           '${snapshot.data!.docs.length}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('userProfileData')
//                   .doc(widget.userid)
//                   .get(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 if (!snapshot.hasData || !snapshot.data!.exists) {
//                   return Center(
//                     child: Text(
//                       'No Data Found',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   );
//                 }

//                 final user = snapshot.data!.data() as Map<String, dynamic>;
//                 final userName = user['name'] ?? 'No Name';
//                 return cartItemNames.contains(userName) || existingCartItemNames.contains(userName)
//                     ? Container() // Hide if name is already in cart or CartData
//                     : Card(
//                         margin: EdgeInsets.all(8.0),
//                         child: ListTile(
//                           onTap: () async {
//                             final addedItem = await Navigator.push(
//                               context,
//                               CupertinoPageRoute(
//                                 builder: (context) => AddCart(
//                                   name: user['name'],
//                                   dob: user['dateOfBirth'],
//                                   blood: user['bloodGroup'],
//                                 ),
//                               ),
//                             );
//                             // if (addedItem != null) {
//                             //   FirebaseFirestore.instance
//                             //       .collection('usersCartData')
//                             //       .doc(widget.userid)
//                             //       .collection('Cart')
//                             //       .add({
//                             //     'name': addedItem,
//                             //     'price': '50',
//                             //   });
//                             // }
//                           },
//                           title: Text(userName),
//                           leading: CircleAvatar(
//                             backgroundImage:
//                                 NetworkImage(user['profileImage']),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Date of Birth: ${user['dateOfBirth']}'),
//                               Text('Blood Group: ${user['bloodGroup']}'),
//                             ],
//                           ),
//                         ),
//                       );
//               },
//             ),
//           ),
//           Expanded(
//             flex: 88,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('familyUser')
//                     .doc(widget.userid)
//                     .collection('userProfileData')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }

//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }

//                   final users = snapshot.data?.docs ?? [];
//                   return ListView.builder(
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       final user = users[index].data() as Map<String, dynamic>;
//                       final userName = user['name'] ?? 'No Name';
//                       return cartItemNames.contains(userName) || existingCartItemNames.contains(userName)
//                           ? Container() // Hide if name is already in cart or CartData
//                           : Card(
//                               margin: EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 onTap: () async {
//                                   final addedItem = await Navigator.push(
//                                     context,
//                                     CupertinoPageRoute(
//                                       builder: (context) => AddCart(
//                                         name: user['name'],
//                                         dob: user['dateOfBirth'],
//                                         blood: user['bloodGroup'],
//                                       ),
//                                     ),
//                                   );
//                                   // if (addedItem != null) {
//                                   //   FirebaseFirestore.instance
//                                   //       .collection('usersCartData')
//                                   //       .doc(widget.userid)
//                                   //       .collection('Cart')
//                                   //       .add({
//                                   //     'name': addedItem,
//                                   //     'price': '50',
//                                   //   });
//                                   // }
//                                 },
//                                 title: Text(userName),
//                                 leading: CircleAvatar(
//                                   backgroundImage: NetworkImage(
//                                       user['profileImage']),
//                                 ),
//                                 subtitle: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                         'Date of Birth: ${user['dateOfBirth']}'),
//                                     Text(
//                                         'Blood Group: ${user['bloodGroup']}'),
//                                   ],
//                                 ),
//                               ),
//                             );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
