import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _fetchOrderHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data() as Map<String, dynamic>;

             // Format the timestamp to show only the date
              final timestamp = order['date'] ;
              // final formattedDate = timestamp != null
              //     ? DateFormat('yyyy-MM-dd').format(timestamp.toDate())
              //     : 'No Date';

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Name: ${order['name'] ?? 'No Name'}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Blood Group: ${order['blood'] ?? 'No Blood Group'}'),
                      Text('Price: ${order['price'] ?? 'No Price'}'),
                      Text(
                          'Order Number: ${order['orderNumber'] ?? 'No Order Number'}'),
                      Text('Date: $timestamp'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<QuerySnapshot> _fetchOrderHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    print('UserID=$userId');
    return FirebaseFirestore.instance
        .collection('CartData')
        .where('userId', isEqualTo: userId)
      //  .orderBy('timestamp', descending: true)
        .get();
  }
}
