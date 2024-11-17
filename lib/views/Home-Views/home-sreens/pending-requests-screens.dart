
import 'package:ecare/constants/linker.dart';

class PendingRequestsScreen extends StatefulWidget {
  final String userID;

  const PendingRequestsScreen({Key? key, required this.userID})
      : super(key: key);

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  List<QueryDocumentSnapshot> _requests = [];

  @override
  void initState() {
    super.initState();
    _fetchPendingRequests();
  }

  Future<void> _fetchPendingRequests() async {
    final requestDocs = await FirebaseFirestore.instance
        .collection('authenticationRequests')
        .where('email', isEqualTo: widget.userID)
        .where('status', isEqualTo: 'pending')
        .get();

    setState(() {
      _requests = requestDocs.docs;
    });
  }

  Future<void> _updateRequestStatus(String requestId, String status) async {
    await FirebaseFirestore.instance
        .collection('authenticationRequests')
        .doc(requestId)
        .update({'status': status});

    Fluttertoast.showToast(
      msg: "Request $status successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: status == 'approved' ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Remove the request from the list
    setState(() {
      _requests.removeWhere((req) => req.id == requestId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Requests'),
      ),
      body: _requests.isEmpty
          ? const Center(child: Text('No pending requests'))
          : ListView.builder(
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(request['email']),
                    //  subtitle: Text('Request Type: ${request['requestType']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            _updateRequestStatus(request.id, 'approved');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            _updateRequestStatus(request.id, 'declined');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
