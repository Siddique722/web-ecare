  

import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/Home-Views/ambulance-view/create-new-ambulance/update-ambulance.dart';

///-------------------------------------

class AvailableAmbulancesView extends StatefulWidget {
  const AvailableAmbulancesView({Key? key}) : super(key: key);

  @override
  _AvailableAmbulancesViewState createState() =>
      _AvailableAmbulancesViewState();
}

class _AvailableAmbulancesViewState extends State<AvailableAmbulancesView> {
  List<Map<String, dynamic>> availableAmbulances = [];
  bool isLoading = false; // Loading state for deletion

  @override
  void initState() {
    super.initState();
    fetchAmbulances(); // Fetch ambulances on screen load
  }

  // Fetch ambulance data from Firestore
  Future<void> fetchAmbulances() async {
    try {
      setState(() {
        isLoading = true;
      });
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('ambulances')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userambulance')
          .get();

      List<Map<String, dynamic>> fetchedAmbulances = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();

      setState(() {
        availableAmbulances = fetchedAmbulances;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching ambulances: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to delete ambulance
  Future<void> deleteAmbulance(String ambulanceId) async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('ambulances')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userambulance')
          .doc(ambulanceId)
          .delete();

      setState(() {
        isLoading = false;
      });
      fetchAmbulances(); // Refresh ambulances after delete
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ambulance deleted successfully')),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete ambulance: $e')),
      );
    }
  }

  // Show confirmation dialog
  void showDeleteConfirmationDialog(String ambulanceId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this ambulance?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without action
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                deleteAmbulance(ambulanceId); // Perform delete action
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Ambulances'),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? Center(
              child: AppLoading()) // Show loading indicator during deletion
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: availableAmbulances.isEmpty
                  ? Center(
                      child: Text('No available ambulances.'),
                    )
                  : ListView.builder(
                      itemCount: availableAmbulances.length,
                      itemBuilder: (context, index) {
                        final ambulance = availableAmbulances[index];

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateAmbulanceView(
                                      nameofambulanceservice: ambulance['nameofambulance']??"",
                                      address: ambulance['address'],
                                      ambulanceRegistrationNumber: ambulance[
                                          'ambulanceRegistrationNumber'],
                                      ambulanceType: ambulance['ambulanceType'],
                                      districtName: ambulance['district'],
                                      cityName: ambulance['city'],
                                      pinCode: ambulance['pinCode'],
                                      // ambulanceId: ambulance['ambulanceId'],
                                      contactNumber: ambulance['contactNumber'],
                                      docId: ambulance['id'],
                                    ),
                                  ));
                            },
                            title: Text(
                                'Ambulance Registration: ${ambulance['ambulanceRegistrationNumber']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('District: ${ambulance['district']}'),
                                Text('City: ${ambulance['city']}'),
                                Text(
                                    'Ambulance Type: ${ambulance['ambulanceType']}'),
                                Text('Pin Code: ${ambulance['pinCode']}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Show confirmation dialog before delete
                                showDeleteConfirmationDialog(ambulance['id']);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
