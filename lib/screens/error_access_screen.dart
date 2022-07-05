import 'package:flutter/material.dart';

class ErrorAccessScreen extends StatelessWidget {
  const ErrorAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/Something Went Wrong.png",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}