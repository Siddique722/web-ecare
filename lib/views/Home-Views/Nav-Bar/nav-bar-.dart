// import 'package:demo_app/views/Home-Views/Users-View/show-users.dart';
// import 'package:demo_app/views/Home-Views/ambulance.dart';
// import 'package:demo_app/views/Home-Views/availabe-cards.dart';
// import 'package:demo_app/views/Home-Views/cart-screen.dart';
// import 'package:demo_app/views/Home-Views/home-view.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class NavBarExample extends StatefulWidget {
//   @override
//   _NavBarExampleState createState() => _NavBarExampleState();
// }

// class _NavBarExampleState extends State<NavBarExample> {
//   int _selectedIndex = 2;
//   String userID = '';
//   fetchUserdata() async {
//     User? user = await FirebaseAuth.instance.currentUser;
//     userID = user!.uid;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchUserdata();
//   }

//   // Define a list of widgets that represent the different screens
//   final List<Widget> _screens = [
//     AmbulanceView(),
//     ShowUsersView(),
//     HomeView(),
//     CArtScreen(),
//     AvailableCards(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[
//           _selectedIndex], // Display the screen corresponding to the selected index
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.call),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.family_restroom),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: CircleAvatar(
//               backgroundColor: Colors.blue,
//               child: Icon(
//                 Icons.home,
//                 color: Colors.white,
//               ),
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.credit_card),
//             label: '',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }

// // Example screens for navigation
// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Search Screen'),
//     );
//   }
// }

// class NotificationsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Notifications Screen'),
//     );
//   }
// }

// class FavoritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Favorites Screen'),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Profile Screen'),
//     );
//   }
// }

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/Home-Views/Cards/availabe-cards.dart';
import 'package:ecare/views/Home-Views/Users-View/show-users.dart';
import 'package:ecare/views/Home-Views/ambulance-view/ambulance.dart';
import 'package:ecare/views/Home-Views/home-sreens/home-view.dart';

///----------------
///

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NavBarExample extends StatefulWidget {
  @override
  _NavBarExampleState createState() => _NavBarExampleState();
}

class _NavBarExampleState extends State<NavBarExample> {
  int _selectedIndex = 2;
  String userID = '';
  List<Widget> _screens = [];

  fetchUserdata() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userID = user.uid;
        // Initialize the screens list
        _screens = [
          AmbulanceView(),
          //ConsultDoctor(),
          ShowUsersView(userid: userID, role: 'view'), // Use the userID here
          HomeView(),
          CArtScreen(
            cartItems: [{}],
            totalPrice: 0,
          ),
          AvailableCards(userid: userID),
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserdata();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define blue color for the selected item
    final selectedColor = Colors.blue;
    final unselectedColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      body: _screens.isEmpty
          ? Center(child: AppLoading())
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call,
                color: _selectedIndex == 0 ? selectedColor : unselectedColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons
                    .family_restroom, //ImageIcon(AssetImage('lib/assets/images/doctor.png'),
                color: _selectedIndex == 1 ? selectedColor : unselectedColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: selectedColor,
              child: Icon(Icons.home, color: Colors.white),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: _selectedIndex == 3 ? selectedColor : unselectedColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card,
                color: _selectedIndex == 4 ? selectedColor : unselectedColor),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          leading: Container(
            width: 50, //double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
          ),
          title: Container(
            width: 50, //double.infinity,
            height: 15,
            color: Colors.white,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 30),
            child: Container(
              width: 30, //double.infinity,
              height: 15,
              color: Colors.white,
            ),
          ),
        ));
  }
}
