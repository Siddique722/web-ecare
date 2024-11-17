import 'package:ecare/views/Home-Views/Users-View/Edit-Users/edit-user-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecare/constants/linker.dart';

class ShowUsersView extends StatefulWidget {
  final String role;
  final String userid;
  ShowUsersView({super.key, required this.userid, required this.role});
  @override
  State<ShowUsersView> createState() => _ShowUsersViewState();
}

class _ShowUsersViewState extends State<ShowUsersView> {
  Map<String, dynamic>? userData;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  String userid = '';
  String familyId = '';
  Future<void> _fetchUserData() async {
    print("User ID:$userid");
    final snapshot = await FirebaseFirestore.instance
        .collection('userProfileData')
        .where('userId', isEqualTo: widget.userid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        userData = snapshot.docs.first.data();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => NavBarExample()));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        title: BoldTextWidgetTheme(text: 'Users'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: userData == null
                ? ShimmerLoading()
                :
            // ProfileCard(
            //   profileImage: userData![
            //   'profileImage'] ??
            //       "https://firebasestorage.googleapis.com/v0/b/e-health1-psa71c.appspot.com/o/user1.png?alt=media&token=b59c8843-d19c-4705-868d-579e6541abd1",
            //
            //   name: userData!['name'] ?? 'No Name',
            //  bloodGroup:  userData!['bloodGroup'] ?? 'No Blood Group',
            //   dateOfBirth: '${userData!['dateOfBirth'] ?? 'No DOB'}',
            //   onEdit: () {
            //     // Edit action
            //   },
            //   onLongPress: () async {
            //     bool shouldDelete = await showDialog(
            //       context: context,
            //       barrierDismissible: false,
            //       builder: (BuildContext context) {
            //         return ConfirmationDialog(
            //           title: 'Confirm Deletion',
            //           content: 'Are you sure you want to delete this record?',
            //           onCancel: () {
            //             Navigator.of(context).pop(false);
            //           },
            //           onConfirm: () {
            //             Navigator.of(context).pop(true);
            //           },
            //         );
            //       },
            //     );
            //     if (shouldDelete == true) {
            //       // Proceed with deletion
            //     }
            //   },
            // )



        Card(
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => LoadingDialog(),
                        );

                        final allergicMedicationsData =
                            await _fetchUserDataCollection(
                                'allergicMedicationsData', widget.userid);
                        final comorbiditiesData =
                            await _fetchUserDataCollection(
                                'comorbiditiesData', widget.userid);
                        final currentMedicationsData =
                            await _fetchUserDataCollection(
                                'currentMedicationsData', widget.userid);
                        final medicalHistoryData =
                            await _fetchUserDataCollection(
                                'medicalHistoryData', widget.userid);
                        final surgicalHistoryData =
                            await _fetchUserDataCollection(
                                'surgicalHistoryData', widget.userid);
                        Map<String, dynamic> userMap = {
                          'profileImage': userData?[''] ??
                              'https://firebasestorage.googleapis.com/v0/b/e-health1-psa71c.appspot.com/o/user1.png?alt=media&token=b59c8843-d19c-4705-868d-579e6541abd1',
                          'gender': userData?['gender'] ?? '',
                          'primaryContact': userData?['primaryContact'] ?? '',
                          'emergencyContact1':
                              userData?['emergencyContact1'] ?? '',
                          'emergencyContact2':
                              userData?['emergencyContact2'] ?? '',
                          'name': userData?['name'] ?? '',
                          'bloodGroup': userData?['bloodGroup'] ?? '',
                          'dateOfBirth': userData?['dateOfBirth'] ?? '',
                        };
                        print(
                            '1111111111111111111111111111111111111111111$allergicMedicationsData');
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(
                              role: 'admin',
                              image: userData!['profileImage'],
                              gender: userData!['gender'] ?? 'No Data',
                              primary: userData!['primaryContact'] ??
                                  'No Primary Contact',
                              emergencyContact1:
                                  userData!['emergencyContact1'] ??
                                      'No EmergencyContact1',
                              emergencyContact2:
                                  userData!['emergencyContact2'] ??
                                      'No EmergencyContact2',
                              name: userData!['name'] ?? 'No Name',
                              bloodGroup:
                                  userData!['bloodGroup'] ?? 'No Blood Group',
                              dateOfBirth: userData!['dateOfBirth'] ?? 'No DOB',
                              allergicMedicationsData: allergicMedicationsData,
                              comorbiditiesData: comorbiditiesData,
                              currentMedicationsData: currentMedicationsData,
                              medicalHistoryData: medicalHistoryData,
                              surgicalHistoryData: surgicalHistoryData,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userData![
                                  'profileImage'] ??
                              "https://firebasestorage.googleapis.com/v0/b/e-health1-psa71c.appspot.com/o/user1.png?alt=media&token=b59c8843-d19c-4705-868d-579e6541abd1"),
                          radius: 30,
                        ),
                        title: Text(
                          userData!['name'] ?? 'No Name',
                        ),
                        subtitle: Text(
                          'Blood Group: ${userData!['bloodGroup'] ?? 'No Blood Group'}\nDate of Birth: ${userData!['dateOfBirth'] ?? 'No DOB'}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => LoadingDialog(),
                            );

                            userid =
                                await FirebaseAuth.instance.currentUser!.uid;
                            final allergicMedicationsData =
                                await _fetchUserDataCollection(
                                    'allergicMedicationsData', widget.userid);
                            final comorbiditiesData =
                                await _fetchUserDataCollection(
                                    'comorbiditiesData', widget.userid);
                            final currentMedicationsData =
                                await _fetchUserDataCollection(
                                    'currentMedicationsData', widget.userid);
                            final medicalHistoryData =
                                await _fetchUserDataCollection(
                                    'medicalHistoryData', widget.userid);
                            final surgicalHistoryData =
                                await _fetchUserDataCollection(
                                    'surgicalHistoryData', widget.userid);
                            Map<String, dynamic> userMap = {
                              'profileImage': userData?['profileImage'] ??
                                  '', // Default image path if not available
                              'gender': userData?['gender'] ?? '',
                              'primaryContact':
                                  userData?['primaryContact'] ?? '',
                              'emergencyContact1':
                                  userData?['emergencyContact1'] ?? '',
                              'emergencyContact2':
                                  userData?['emergencyContact2'] ?? '',
                              'name': userData?['name'] ?? '',
                              'bloodGroup': userData?['bloodGroup'] ?? '',
                              'dateOfBirth': userData?['dateOfBirth'] ?? '',
                              'relation1':
                                  userData?['relation1'] ?? 'not available',
                              'relation2':
                                  userData?['relation2'] ?? 'not availabe',
                            };
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                  role: 'admin',
                                  userid: userid,
                                  userData: userMap,
                                  allergicMedicationsData:
                                      allergicMedicationsData,
                                  comorbiditiesData: comorbiditiesData,
                                  currentMedicationsData:
                                      currentMedicationsData,
                                  medicalHistoryData: medicalHistoryData,
                                  surgicalHistoryData: surgicalHistoryData,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ),
          Expanded(
            flex: 72,
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
                    return ShimmerLoading();
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final users = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index].data() as Map<String, dynamic>;
                      final profileImage =
                          user['profileImage'] as String? ?? '';
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          onLongPress: () async {
                            bool shouldDelete = await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return ConfirmationDialog(
                                  title: 'Confirm Deletion',
                                  content: 'Are you sure you want to delete this record?',
                                  onCancel: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  onConfirm: () {
                                    Navigator.of(context).pop(true);
                                  },
                                );
                              },
                            );

                            if (shouldDelete == true) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppLoading(),
                                        SizedBox(width: 20),
                                        Text('Deleting...'),
                                      ],
                                    ),
                                  );
                                },
                              );
                              familyId = user['userfamilyId'];
                              await FirebaseFirestore.instance
                                  .collection('familyUser')
                                  .doc(widget.userid)
                                  .collection('userProfileData')
                                  .doc(familyId)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('familyUser')
                                  .doc(widget.userid)
                                  .collection('allergicMedicationsData')
                                  .doc(familyId)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('familyUser')
                                  .doc(widget.userid)
                                  .collection('comorbiditiesData')
                                  .doc(familyId)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('familyUser')
                                  .doc(widget.userid)
                                  .collection('currentMedicationsData')
                                  .doc(familyId)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('familyUser')
                                  .doc(widget.userid)
                                  .collection('medicalHistoryData')
                                  .doc(familyId)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('familyUser')
                                  .doc(widget.userid)
                                  .collection('surgicalHistoryData')
                                  .doc(familyId)
                                  .delete();
                              Navigator.pop(context);
                              setState(() {});
                            }
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) => LoadingDialog(),
                              );

                              String family = user['userfamilyId'];
                              final allergicMedicationsData = await _fetchData(
                                  'allergicMedicationsData', family);
                              final comorbiditiesData =
                                  await _fetchData('comorbiditiesData', family);
                              final currentMedicationsData = await _fetchData(
                                  'currentMedicationsData', family);
                              final medicalHistoryData = await _fetchData(
                                  'medicalHistoryData', family);
                              final surgicalHistoryData = await _fetchData(
                                  'surgicalHistoryData', family);
                              String familyId = user['userfamilyId'];
                              Map<String, dynamic> userMap = {
                                'userfamilyId': user?['userfamilyId'] ?? '',
                                'profileImage': user?['profileImage'] ??
                                    '', // Default image path if not available
                                'gender': user?['gender'] ?? '',
                                'primaryContact': user?['primaryContact'] ?? '',
                                'emergencyContact1':
                                    user?['emergencyContact1'] ?? '',
                                'emergencyContact2':
                                    user?['emergencyContact2'] ?? '',
                                'name': user?['name'] ?? '',
                                'bloodGroup': user?['bloodGroup'] ?? '',
                                'dateOfBirth': user?['dateOfBirth'] ?? '',
                                'relation1':
                                    user?['relation1'] ?? 'not available',
                                'relation2':
                                    user?['relation2'] ?? 'not availabe',
                              };
                              print(
                                  'allergicMedicationsData=$allergicMedicationsData');
                              print('comorbiditiesData=$comorbiditiesData');
                              print(
                                  'currentMedicationsData=$currentMedicationsData');
                              print('medicalHistoryData=$medicalHistoryData');
                              print('surgicalHistoryData=$surgicalHistoryData');
                              print(
                                  '=====================================================');
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                    familyId: familyId,
                                    role: 'family',
                                    userData: userMap,
                                    userid: widget.userid,
                                    allergicMedicationsData:
                                        allergicMedicationsData,
                                    comorbiditiesData: comorbiditiesData,
                                    currentMedicationsData:
                                        currentMedicationsData,
                                    medicalHistoryData: medicalHistoryData,
                                    surgicalHistoryData: surgicalHistoryData,
                                  ),
                                ),
                              );
                            },
                          ),
                          onTap: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => LoadingDialog(),
                            );

                            String family = user['userfamilyId'];
                            // ------------
                            final allergicMedicationsData = await _fetchData(
                                'allergicMedicationsData', family);
                            final comorbiditiesData =
                                await _fetchData('comorbiditiesData', family);
                            final currentMedicationsData = await _fetchData(
                                'currentMedicationsData', family);
                            final medicalHistoryData =
                                await _fetchData('medicalHistoryData', family);
                            final surgicalHistoryData =
                                await _fetchData('surgicalHistoryData', family);
                            print(
                                'allergicMedicationsData=$allergicMedicationsData');
                            print('comorbiditiesData=$comorbiditiesData');
                            print(
                                'currentMedicationsData=$currentMedicationsData');
                            print('medicalHistoryData=$medicalHistoryData');
                            print('surgicalHistoryData=$surgicalHistoryData');

                            Navigator.of(context).pop();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetailScreen(
                                  role: 'family',
                                  image: profileImage,
                                  gender: user['gender'] ?? 'No Data',
                                  primary: user['primaryContact'] ??
                                      'No Primary Contact',
                                  emergencyContact1:
                                      user['emergencyContact1'] ??
                                          'No EmergencyContact1',
                                  emergencyContact2:
                                      user['emergencyContact2'] ??
                                          'No EmergencyContact2',
                                  name: user['name'] ?? 'No Name',
                                  bloodGroup:
                                      user['bloodGroup'] ?? 'No Blood Group',
                                  dateOfBirth: user['dateOfBirth'] ?? 'No DOB',
                                  allergicMedicationsData:
                                      allergicMedicationsData,
                                  comorbiditiesData: comorbiditiesData,
                                  currentMedicationsData:
                                      currentMedicationsData,
                                  medicalHistoryData: medicalHistoryData,
                                  surgicalHistoryData: surgicalHistoryData,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profileImage),
                            radius: 30,
                          ),
                          title: Text(user['name'] ?? 'No Name'),
                          subtitle: Text(
                            'Blood Group: ${user['bloodGroup'] ?? 'No Blood Group'}\nDate of Birth: ${user['dateOfBirth'] ?? 'No DOB'} ',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              CreateProfileScreen(role: 'family')));
                },
                child: BlueButton(text: 'Add New User')),
          )
        ],
      ),
    );
  }

  ///TODO: this function is use for user family user
  Future<Map<String, dynamic>> _fetchData(
      String collectionName, String? family) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('familyUser')
        .doc(widget.userid)
        .collection(collectionName)
        .where('userfamilyId', isEqualTo: family)
        .get();

    return {
      for (var doc in snapshot.docs) doc.id: doc.data(),
    };
  }

  Future<Map<String, dynamic>> _fetchUserDataCollection(
      String collectionName, String userID) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userID)
          //  .collection(collectionName)
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print('No document found for the provided userID.');
        return {};
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 20),
          Text('Loading...'),
        ],
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: onCancel,
        ),
        TextButton(
          child: Text('Yes'),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String bloodGroup;
  final String dateOfBirth;
  final VoidCallback onEdit;
  final VoidCallback onLongPress;
  final VoidCallback onTap;

  const ProfileCard({
    required this.profileImage,
    required this.name,
    required this.bloodGroup,
    required this.dateOfBirth,
    required this.onEdit,
    required this.onLongPress,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: onEdit,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage),
          radius: 30,
        ),
        title: Text(name),
        subtitle: Text(
          'Blood Group: $bloodGroup\nDate of Birth: $dateOfBirth',
        ),
      ),
    );
  }
}

class UserDetailScreen extends StatefulWidget {
  final String? name;
  String role;
  final String? image;
  final String? emergencyContact1;
  final String? emergencyContact2;
  final String? gender;
  final String? primary;
  final String? bloodGroup;
  final String? dateOfBirth;
  var allergicMedicationsData;
  var comorbiditiesData;
  var currentMedicationsData;
  var medicalHistoryData;
  var surgicalHistoryData;
  UserDetailScreen({
    required this.image,
    required this.role,
    required this.name,
    required this.bloodGroup,
    required this.dateOfBirth,
    this.gender,
    this.primary,
    this.emergencyContact1,
    this.emergencyContact2,
    required this.allergicMedicationsData,
    required this.comorbiditiesData,
    required this.currentMedicationsData,
    required this.medicalHistoryData,
    required this.surgicalHistoryData,
  });
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<String> filterAndOrganizeFamilyData(Map<String, dynamic>? dataMap) {
    if (dataMap == null) return [];
    List<String> availableItems = [];
    dataMap.forEach((key, value) {
      print(
          'Processing Key: $key, Value: $value'); // Debugging: Print each key-value pair
      if (value is Map) {
        value.forEach((innerKey, innerValue) {
          if (innerKey.startsWith('medicineController') ||
              innerKey.startsWith('selectedComorbidity') ||
              innerKey.startsWith('medicine') ||
              innerKey.startsWith('history') ||
              innerKey.startsWith('surgery')) {
            if (innerValue is String &&
                innerValue.isNotEmpty &&
                innerValue != 'No Data') {
              availableItems.add(innerValue);
            }
          } else if (innerKey == 'userId' ||
              innerKey == 'userfamilyId' ||
              innerKey == 'userID') {
          } else {}
        });
      } else {}
    });
    // Debugging: Log the filtered data
    print('Filtered and Organized Data: $availableItems');

    // Shuffle and sort the available data
    availableItems.shuffle(Random());
    availableItems.sort((a, b) => a.compareTo(b));

    return availableItems;
  }

  ///TODO:------------

  List<String> filterAndOrganizeData(Map<String, dynamic>? dataMap) {
    if (dataMap == null) return [];

    List<String> availableItems = [];

    // Filter out 'No Data', null values, 'userId', and 'userfamilyId'
    dataMap.forEach((key, value) {
      String lowerCaseKey = key.toLowerCase();
      if (!['userid', 'userfamilyid,userID'].contains(lowerCaseKey) &&
          value != null &&
          value != 'No Data') {
        if (value is Map) {
          value.forEach((innerKey, innerValue) {
            if (innerValue != null &&
                innerValue is String &&
                innerValue.isNotEmpty) {
              print('Key: $innerKey, Value: $innerValue');
              availableItems.add(innerValue);
            }
          });
        } else if (value is String && value.isNotEmpty) {
          print('Key: $key, Value: $value');
          availableItems.add(value);
        }
      } else {
        // Debugging: Confirm excluded keys
        print('Excluded Key: $key, Value: $value');
      }
    });

    // Debugging: Print the filtered and organized data
    print('Filtered and Organized Data: $availableItems');

    // Shuffle and sort available data
    availableItems.shuffle(Random());
    availableItems.sort((a, b) => a.compareTo(b));

    return availableItems;
  }

  @override
  Widget build(BuildContext context) {
    List<String> allergicMedicationsItems = widget.role == 'admin'
        ? filterAndOrganizeData(widget.allergicMedicationsData)
        : filterAndOrganizeFamilyData(widget.allergicMedicationsData);
    List<String> comorbiditiesItems = widget.role == 'admin'
        ? filterAndOrganizeData(widget.comorbiditiesData)
        : filterAndOrganizeFamilyData(widget.comorbiditiesData);
    List<String> currentMedicationsItems = widget.role == 'admin'
        ? filterAndOrganizeData(widget.currentMedicationsData)
        : filterAndOrganizeFamilyData(widget.currentMedicationsData);
    List<String> medicalHistoryItems = widget.role == 'admin'
        ? filterAndOrganizeData(widget.medicalHistoryData)
        : filterAndOrganizeFamilyData(widget.medicalHistoryData);
    List<String> surgicalHistoryItems = widget.role == 'admin'
        ? filterAndOrganizeData(widget.surgicalHistoryData)
        : filterAndOrganizeFamilyData(widget.surgicalHistoryData);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              color: Colors.blue,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.image ?? ""),
                  radius: 30,
                ),
                title: Text(widget.name ?? ""),
                subtitle: Text(
                  'Blood Group: ${widget.bloodGroup}\n'
                  'Date of Birth: ${widget.dateOfBirth}\n'
                  'Gender: ${widget.gender}\n'
                  'Primary Contact: ${widget.primary}\n'
                  'Emergency Contact1: ${widget.emergencyContact1}\n'
                  'Emergency Contact2: ${widget.emergencyContact2}',
                ),
              ),
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text('Allergic Medications'),
              children: allergicMedicationsItems.isNotEmpty
                  ? allergicMedicationsItems
                      .map((item) => ListTile(title: Text(item)))
                      .toList()
                  : [ListTile(title: Text('No Allergic Medications'))],
            ),
            SizedBox(height: 10),
            ExpansionTile(
              title: Text('Comorbidities'),
              children: comorbiditiesItems.isNotEmpty
                  ? comorbiditiesItems
                      .map((item) => ListTile(title: Text(item)))
                      .toList()
                  : [ListTile(title: Text('No Comorbidities'))],
            ),
            SizedBox(height: 10),
            ExpansionTile(
              title: Text('Current Medications'),
              children: currentMedicationsItems.isNotEmpty
                  ? currentMedicationsItems
                      .map((item) => ListTile(title: Text(item)))
                      .toList()
                  : [ListTile(title: Text('No Current Medications'))],
            ),
            SizedBox(height: 10),
            ExpansionTile(
              title: Text('Medical History'),
              children: medicalHistoryItems.isNotEmpty
                  ? medicalHistoryItems
                      .map((item) => ListTile(title: Text(item)))
                      .toList()
                  : [ListTile(title: Text('No Medical History'))],
            ),
            SizedBox(height: 10),
            ExpansionTile(
              title: Text('Surgical History'),
              children: surgicalHistoryItems.isNotEmpty
                  ? surgicalHistoryItems
                      .map((item) => ListTile(title: Text(item)))
                      .toList()
                  : [ListTile(title: Text('No Surgical History'))],
            ),
          ],
        ),
      ),
    );
  }
}
