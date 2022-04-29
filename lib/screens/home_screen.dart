import 'package:flutter/material.dart';

class HomeScreen  extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home"),
    );
  }
}
