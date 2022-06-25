import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/weekdays_info.dart';
import 'package:netcompany_office_tool/dialog/menu_dialog.dart';
import 'package:netcompany_office_tool/screens/landscape_mode.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class WeeklyLunchScreen extends StatefulWidget {
  const WeeklyLunchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeeklyLunchScreenState();
}

class _WeeklyLunchScreenState extends State<WeeklyLunchScreen> {
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
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text("Daily Lunch Menu", style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                      fontSize: 35,
                      color: Color(0xff0f2147),
                      fontWeight: FontWeight.w900,
                    )),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              ListView.builder(
                                  itemCount: weekdays.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        color: const Color(0xff0f2147),
                                        elevation: 8,
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.all(12),
                                          onTap: () {
                                            showDialog(context: context, builder: (BuildContext context) {
                                              return MenuDialog(title: weekdays[index].abbrev);
                                            });
                                          },
                                          title: Text(weekdays[index].name,
                                            style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                            )),
                                            textAlign: TextAlign.left,
                                          ),
                                          subtitle: Text("Lunch Menu",
                                            style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                          )),
                                            textAlign: TextAlign.left,
                                          ),
                                          trailing: Image.asset(weekdays[index].iconImage,
                                              height: 60, width: 60, fit: BoxFit.cover,
                                          ),
                                        )
                                    );
                                  }
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      );
    },);
  }
}
