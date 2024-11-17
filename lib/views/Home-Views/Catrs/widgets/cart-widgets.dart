// Checkout Section Widget

import 'package:ecare/constants/linker.dart';

class CheckoutSection extends StatelessWidget {
  final int totalPrice;
  final VoidCallback onCheckout;

  const CheckoutSection({required this.totalPrice, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
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
                  Text('$totalPrice'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: onCheckout,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Cart Item List Widget
class CartItemList extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(int) onDelete;

  const CartItemList({required this.cartItems, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  onPressed: () => onDelete(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Empty Cart Widget
class EmptyCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  child: Text('Order History', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 50),
        Center(
          child: Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
