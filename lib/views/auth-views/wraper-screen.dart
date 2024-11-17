import 'package:ecare/constants/linker.dart';


class WraperScreen extends StatefulWidget {
  const WraperScreen({super.key});

  @override
  State<WraperScreen> createState() => _WraperScreenState();
}

class _WraperScreenState extends State<WraperScreen> {
  Future<Widget> _checkUserProfile() async {
    String userCheck = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Reference to Firestore collection
      CollectionReference userProfileCollection =
          FirebaseFirestore.instance.collection('userProfileData');

      // Query to check if the userId matches userCheck
      QuerySnapshot querySnapshot = await userProfileCollection
          .where('userId', isEqualTo: userCheck)
          .limit(1)
          .get();

      // Check if any document matches
      if (querySnapshot.docs.isNotEmpty) {
        // If match is found, navigate to NavBarExample screen
        return NavBarExample();
      } else {
        // If no match is found, navigate to CreateProfileScreen
        return CreateProfileScreen(role: 'register');
      }
    } catch (e) {
      print('Error checking user profile: $e');
      // Return an error screen or appropriate fallback
      return Center(child: BoldTextWidgetTheme(text: 'Error loading profile'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Handling the connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: AppLoading(),
            );
          }
          // Handling error state
          else if (snapshot.hasError) {
            return Center(
              child: BoldTextWidgetTheme(text: 'Something went wrong'),
            );
          }
          // Handling data state
          else {
            print('snap shot data checking-1');
            if (snapshot.data == null) {
              print('Navigate to login screen-1');
              return LoginView();
            } else {
              print('Checking current user-3');
              if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
                // Check user profile in Firestore
                return FutureBuilder<Widget>(
                  future: _checkUserProfile(),
                  builder: (context, profileSnapshot) {
                    if (profileSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: AppLoading());
                    } else if (profileSnapshot.hasError) {
                      return Center(
                          child: BoldTextWidgetTheme(
                              text: 'Error loading profile'));
                    } else {
                      return profileSnapshot.data!;
                    }
                  },
                );
              } else {
                print('Navigating to email verification screen-4');
                return EmailVerificationLink();
              }
            }
          }
        },
      ),
    );
  }
}
