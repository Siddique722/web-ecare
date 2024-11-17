// import 'package:demo_app/constants/linker.dart';
 import 'package:ecare/views/Home-Views/home-sreens/pending-requests-screens.dart';
import 'package:flutter/cupertino.dart';

import 'package:ecare/constants/linker.dart';

class NotificationIcon extends StatelessWidget {
  String userID;
  final int pendingRequestsCount;

   NotificationIcon({
    Key? key,
    required this.pendingRequestsCount,required this.userID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: () {
              print('--------$pendingRequestsCount: ');
              Navigator.push(
                  context,
                  CupertinoDialogRoute(
                      builder: (context) =>
                          PendingRequestsScreen(userID: userID),
                      context: context));
            },
            icon: Icon(Icons.notifications)),
        if (pendingRequestsCount >= 0)
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 10,
              child: Text(
                '$pendingRequestsCount',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}
