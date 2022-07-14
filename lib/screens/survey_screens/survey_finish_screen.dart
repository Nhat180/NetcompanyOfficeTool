import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import '../navigation_screen.dart';

class FinishSurvey extends StatefulWidget {
  const FinishSurvey({Key? key}) : super(key: key);

  @override
  State<FinishSurvey> createState() => _FinishSurveyState();
}

class _FinishSurveyState extends State<FinishSurvey> {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
        backgroundColor: const Color(0xff0f2147),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset('assets/676-done.json', repeat: false)
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 10.0),
                child: Text(
                  "Thank you for filling this survey!.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold) ,  textAlign: TextAlign.center,),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 25.0),
                child: Text(
                  "We really appreciates your effort and the time you devoted to answering. We will read your feedback, and we'll take it seriously.",
                  style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NavigationScreen(index: surveyScreen)));
                },
                icon: const Icon(Icons.arrow_back, size: 20),
                label: const Text("Take another survey", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          )
      ),
    );
  }
}
