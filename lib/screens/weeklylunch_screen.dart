import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/weekdays_info.dart';
import 'package:netcompany_office_tool/dialog/menu_dialog.dart';
import 'package:netcompany_office_tool/screens/landscape_mode.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
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
                    height: 68.h,
                    padding:const EdgeInsets.only(left: 32),
                    child: Swiper(
                        itemCount: weekdays.length,
                        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                        layout: SwiperLayout.STACK,
                        // pagination: const SwiperPagination(
                        //   builder: DotSwiperPaginationBuilder(activeSize: 20, space: 5, color: Colors.black),
                        // ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //     content: Text(weekdays[index].position.toString())));
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return MenuDialog(title: weekdays[index].abbrev);
                                  });
                            },
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    const SizedBox(height: 50),
                                    Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32)
                                      ),
                                      color: const Color(0xff0f2147),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10.h),
                                            Text(
                                              weekdays[index].name,
                                              style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                                                fontSize: 35,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                              )),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 1.h),
                                            Text("Lunch Menu",
                                              style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              )),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Show more",
                                                  style: GoogleFonts.ubuntu(textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Hero(tag: weekdays[index].position, child: Image.asset(weekdays[index].iconImage,
                                    height: 180,
                                    width: MediaQuery.of(context).size.width
                                )),
                                Positioned(
                                  right: 24,
                                  top: 220,
                                  child: Text(weekdays[index].position.toString(),
                                    style: GoogleFonts.ubuntu(textStyle: TextStyle(
                                      fontSize: 200,
                                      color: Colors.white.withOpacity(0.08),
                                      fontWeight: FontWeight.w900,
                                    )),
                                    textAlign: TextAlign.left,),
                                )
                              ],
                            ),
                          );
                        }
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
