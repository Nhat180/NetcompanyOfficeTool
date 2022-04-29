import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Report"),
    );
  }
}
