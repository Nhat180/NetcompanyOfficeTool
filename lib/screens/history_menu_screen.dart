import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/weekdays_info.dart';
import 'package:netcompany_office_tool/dialog/menu_dialog.dart';
import 'package:netcompany_office_tool/screens/landscape_mode.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HistoryMenuScreen extends StatefulWidget {
  const HistoryMenuScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryMenuScreenState();
}

class _HistoryMenuScreenState extends State<HistoryMenuScreen> {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return initWidget();
    } else {
      return const LandScape();
    }
  }

  Widget initWidget() {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
            title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
            backgroundColor: const Color(0xff0f2147),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const NavigationScreen(index: 0,)));
              },
            ),
          ),
          body: Container(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [

                ],
              ),
            ),
          )
      );
    },);
  }
}
