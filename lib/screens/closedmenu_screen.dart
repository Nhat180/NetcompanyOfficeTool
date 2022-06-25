import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/screens/weeklylunch_screen.dart';
import 'package:sizer/sizer.dart';

class ClosedMenu extends StatefulWidget {
  const ClosedMenu({Key? key}) : super(key: key);

  @override
  State<ClosedMenu> createState() => _ClosedMenuState();
}

class _ClosedMenuState extends State<ClosedMenu> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
        margin: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/closed.png"))
              ),
            ),

            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const WeeklyLunchScreen()));
                      },
                      child: Text("You can Check ", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                    ),
                    SizedBox(height: 1.h),
                    Text("the next week's lunch menu here", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.sp))
                  ],
                )
            )
          ],
        ),
      );
    });
  }
}
