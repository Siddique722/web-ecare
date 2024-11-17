import 'package:flutter/cupertino.dart';

import '../../../constants/linker.dart';

class AddCart extends StatefulWidget {
  final String name;
  final String dob;
  final String blood;
  final String image;
  final String contact1;
  final String contact2;
  final String primaryContact;

  AddCart({
    super.key,
    required this.blood,
    required this.dob,
    required this.name,
    required this.image,
    required this.contact1,
    required this.contact2,
    required this.primaryContact,
  });

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  bool isAddedToCart = false;
  int cartItemCount = 0;
  List<Map<String, String>> cartItems = [];

  Future<void> _saveToFirestore() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Debug print to check how many times this function is called
    print('Adding to Firestore for user: $userId');

    // Disable the button immediately
    setState(() {
      isAddedToCart = true;
      cartItemCount += 1;
    });

    final cartCollection = FirebaseFirestore.instance
        .collection('usersCartData')
        .doc(userId)
        .collection('Cart');

    QuerySnapshot existingItems = await cartCollection
        .where('name', isEqualTo: widget.name)
        .where('dob', isEqualTo: widget.dob)
        .where('blood', isEqualTo: widget.blood)
        .get();

    if (existingItems.docs.isEmpty) {
      // Add the item to the cart if it doesn't exist
      print(
          '=======45=3=543=543=543=5435435=435=345=43=5=435=43=534=5-=435-=43-5=43-5');
      print('phone 1${widget.contact1}');
      print('phone 2:${widget.contact2}');
      await cartCollection.add({
        'name': widget.name,
        'dob': widget.dob,
        'blood': widget.blood,
        'price': '50',
        'contact1': widget.contact1,
        'contact2': widget.contact2,
        'primaryContact': widget.primaryContact,
        'imageUrl':widget.image
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cart added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item already in cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CArtScreen(
                        cartItems: cartItems,
                        totalPrice: cartItemCount * 50,
                        // onDelete: _deleteCartItem,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart_sharp),
              ),
              if (cartItemCount > 0)
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
                      '$cartItemCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              ImageIcon(AssetImage('lib/assets/images/rupee.png')),
              BoldTextWidgetTheme(text: '50'),
            ],
          ),
          InkWell(
            onTap: isAddedToCart ? null : _saveToFirestore, // _addToCart,
            child: BlueButton(
              text: isAddedToCart ? 'Added' : 'Add to Cart',
              width: 170,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldTextWidgetTheme(text: 'Cards'),
            SimpleTextWidgetTheme(
              text:
                  '**Please make sure the following details are correct before adding to cart',
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                ),
                title: SimpleTextWidgetTheme(text: 'Name: ${widget.name}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleTextWidgetTheme(text: 'Date of Birth: ${widget.dob}'),
                    SimpleTextWidgetTheme(text: 'Blood Group: ${widget.blood}'),
                    SimpleTextWidgetTheme(
                        text: 'Emergency Contact1: ${widget.contact1}'),
                    SimpleTextWidgetTheme(
                        text: 'Emergency Contact2: ${widget.contact2}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
