import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/weekdays_info.dart';
import 'package:netcompany_office_tool/dialog/menu_dialog.dart';
import 'package:netcompany_office_tool/screens/landscape_mode.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netcompany_office_tool/screens/menu_screens/weekly_menu_screen.dart';
import 'package:sizer/sizer.dart';

enum WidgetMarker { one_week, two_week, three_week }
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
                    MaterialPageRoute(builder: (context) => const WeeklyLunchScreen()));
              },
            ),
          ),
          body: BodyWidget(),
      );
    },);
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BodyWidgetState();
}

class BodyWidgetState extends State<BodyWidget> with SingleTickerProviderStateMixin<BodyWidget> {
  WidgetMarker selectedWidgetMarker = WidgetMarker.one_week;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text('Lunch Menu History ', // default text style'
              style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                fontSize: 35,
                color: Color(0xff0f2147),
                fontWeight: FontWeight.w900,
              )),
              textAlign: TextAlign.center,),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomButton("1 week ago", WidgetMarker.one_week),
                CustomButton("2 weeks ago", WidgetMarker.two_week),
                CustomButton("3 weeks ago", WidgetMarker.three_week)

              ],
            ),
          ),
          FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return getCustomContainer();
            },
          )
        ],
      ),
    );
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.one_week:
        return getMenuOne();
      case WidgetMarker.two_week:
        return getMenuTwo();
      case WidgetMarker.three_week:
        return getMenuThree();
    }
    return getMenuOne();
  }

  Widget getMenuOne() {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: weekdays.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  timeline(Colors.grey[600]!),
                  Expanded(child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      color: Colors.grey[600],
                      elevation: 8,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        onTap: () {
                          showDialog(context: context, builder: (BuildContext context) {
                          return MenuDialog(weekdayAbbrev: weekdays[index].abbrev, history: "History1",);
                          });
                        },
                        title: Text(weekdays[index].name,
                          style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          )),
                          textAlign: TextAlign.left,
                        ),
                      )
                  ),)
                ],
              );
            }),
    );
  }

  Widget getMenuTwo() {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: weekdays.length,
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  children: [
                    timeline(Colors.grey[700]!),
                    Expanded(child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        color: Colors.grey[700],
                        elevation: 8,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          onTap: () {
                            showDialog(context: context, builder: (BuildContext context) {
                            return MenuDialog(weekdayAbbrev: weekdays[index].abbrev, history: "History2",);
                            });
                          },
                          title: Text(weekdays[index].name,
                            style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            )),
                            textAlign: TextAlign.left,
                          ),
                        )
                    ),)
                  ],
                ),
              );
            }),

    );
  }

  Widget getMenuThree() {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: weekdays.length,
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  children: [
                    timeline(Colors.grey[800]!),
                    Expanded(child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        color: Colors.grey[800],
                        elevation: 8,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          onTap: () {
                            showDialog(context: context, builder: (BuildContext context) {
                            return MenuDialog(weekdayAbbrev: weekdays[index].abbrev, history: "History3",);
                            });
                          },
                          title: Text(weekdays[index].name,
                            style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            )),
                            textAlign: TextAlign.left,
                          ),
                        )
                    ),)
                  ],
                ),
              );
            }),
    );
  }

  Widget timeline(Color color) {
    return Column(
      children: [
        Container(
          width: 2,
          height: 35,
          color: Colors.black,
        ),
        Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Icon(Icons.history_outlined, color: Colors.white,),
        ),
        Container(
          width: 2,
          height: 35,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget CustomButton(String textButton, WidgetMarker value) {
    return SizedBox(
      height: 40,
      width: 110,
      child: ElevatedButton(
        child: Text(textButton,
            style: (selectedWidgetMarker == value) ?
            const TextStyle(
                fontSize:  16,
                fontWeight: FontWeight.bold,
                color: Colors.white)
                :
            const TextStyle(
                fontSize:  14,
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ),
        onPressed: () {
          setState(() {
            selectedWidgetMarker = value;
          });
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
            backgroundColor: (selectedWidgetMarker == value) ? MaterialStateProperty.all<Color>(Color(0xff0f2147)) : MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.black)
                )
            )
        ),
      ),

    );
  }
}
