import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/constants.dart';
import 'package:netcompany_office_tool/model/survey.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:netcompany_office_tool/screens/survey_screens/survey_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netcompany_office_tool/screens/survey_screens/survey_finish_screen.dart';

class WelcomeSurvey  extends StatefulWidget {
  final Survey survey;

  const WelcomeSurvey ({Key? key, required this.survey}) : super(key: key);

  @override
  State<WelcomeSurvey> createState() => _WelcomeSurveyState();
}

class _WelcomeSurveyState extends State<WelcomeSurvey > {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
            backgroundColor: const Color(0xff0f2147),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NavigationScreen(index: surveyScreen)));
              },
            ),
          ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 35.0, left: 35.0, bottom: 10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                      ),
                        children: <TextSpan>[
                          const TextSpan(text: "Welcome to "),
                          TextSpan(text: widget.survey.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const TextSpan(text: " survey"),
                        ],
                    ),
                  ),),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, right: 20.0, left: 20.0, bottom: 30.0),
                    child: Text(
                      "Your valuable feedback will remain confidential, and we will use the responses to improve our working environment.",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,),
                  ),
                  const SizedBox(height: 10,),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SurveyDetail(surveyID: widget.survey.id!)
                      ));
                    },
                    child: const Text("Start Survey!",
                        style: TextStyle(fontSize: 25)),
                  ),
                ],
              )
          ),
        )
    );
  }
}
