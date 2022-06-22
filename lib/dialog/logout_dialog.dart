
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';

import '../screens/login_screen.dart';
import '../screens/navigation_screen.dart';


class LogoutDialog extends StatefulWidget {
  final int index;

  const LogoutDialog ({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LogoutDialog> {
  final StorageService storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      title: const Text("Logout"),
      content: const Text("Are you sure, do you want to logout?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NavigationScreen(index: widget.index,)));
            },
            child: const Text("Cancel")
        ),

        TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              storageService.deleteAllSecureData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text("Ok")
        )
      ],
    );
  }
}

