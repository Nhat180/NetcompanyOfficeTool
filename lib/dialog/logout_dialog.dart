
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';

import '../screens/authentication_screens/login_screen.dart';
import '../screens/navigation_screen.dart';


class LogoutDialog extends StatefulWidget {

  const LogoutDialog ({Key? key}) : super(key: key);

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
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")
        ),

        TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              storageService.deleteAllSecureData();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  const LoginScreen()), (Route<dynamic> route) => false);
            },
            child: const Text("Ok")
        )
      ],
    );
  }
}

