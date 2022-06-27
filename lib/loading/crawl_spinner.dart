import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CrawlSpinner extends StatelessWidget {
  const CrawlSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        backgroundColor: const Color(0xff0f2147),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget> [
            SpinKitPouringHourGlass(
              color: Color(0xff0f2147),
              size: 50,
            ),
            SizedBox(height: 10,),
            Text("Checking latest menu...",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff0f2147),
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
