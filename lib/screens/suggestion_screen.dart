import 'package:flutter/material.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Suggestion"),
    );
  }
}
