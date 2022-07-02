import 'package:flutter/material.dart';

class SurveyListScreen extends StatefulWidget {
  const SurveyListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SurveyListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Survey List"),
    );
  }
}
