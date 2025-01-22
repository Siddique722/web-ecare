import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AmbulanceController extends GetxController {
  var searchTerm = ''.obs;
  var filteredAmbulances = <Map<String, dynamic>>[].obs;
  var searchFocus = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFilteredAmbulances('.'); // Initial fetch
  }

  Future<void> fetchFilteredAmbulances(String searchTerm) async {
    // Fetch all 'id' values from the 'ambulances' collection
    QuerySnapshot ambulanceDocsSnapshot = await FirebaseFirestore.instance
        .collection('ambulances')
        .get();

    List<String> ids = ambulanceDocsSnapshot.docs
        .map((doc) => doc['id']?.toString() ?? '')
        .toList();

    List<Map<String, dynamic>> allAmbulances = [];

    for (var id in ids) {
      QuerySnapshot userAmbulanceSnapshot = await FirebaseFirestore.instance
          .collection('ambulances')
          .doc(id)
          .collection('userambulance')
          .get();

      allAmbulances.addAll(userAmbulanceSnapshot.docs.map((subDoc) {
        return subDoc.data() as Map<String, dynamic>;
      }).toList());
    }

    // Filter ambulances based on the search term
    filteredAmbulances.value = allAmbulances.where((ambulance) {
      final district = ambulance['district']?.toString().toLowerCase() ?? '';
      final city = ambulance['city']?.toString().toLowerCase() ?? '';
      final ambulanceRegistrationNumber =
          ambulance['ambulanceRegistrationNumber']
                  ?.toString()
                  .toLowerCase() ??
              '';
      final ambulanceType =
          ambulance['ambulanceType']?.toString().toLowerCase() ?? '';
      final pinCode = ambulance['pinCode']?.toString().toLowerCase() ?? '';
      final ambulanceName =
          ambulance['nameofambulanceservice']?.toString().toLowerCase() ?? '';
      return district.contains(searchTerm.toLowerCase()) ||
          city.contains(searchTerm.toLowerCase()) ||
          ambulanceRegistrationNumber.contains(searchTerm.toLowerCase()) ||
          ambulanceType.contains(searchTerm.toLowerCase()) ||
          pinCode.contains(searchTerm.toLowerCase()) ||
          ambulanceName.contains(searchTerm.toLowerCase());
    }).toList();
  }

  void onSearchChanged(String term) {
    searchTerm.value = term;
    fetchFilteredAmbulances(term);
  }

  Future<void> launchDialer(String contactNumber) async {
    final phoneNumber = 'tel:$contactNumber';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      Get.snackbar('Error', 'Could not launch $phoneNumber');
    }
  }
}
