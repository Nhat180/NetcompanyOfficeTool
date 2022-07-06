import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netcompany_office_tool/constants.dart';
import 'package:netcompany_office_tool/model/question.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';

import '../navigation_screen.dart';

class SurveyDetail extends StatefulWidget {
  const SurveyDetail({Key? key}) : super(key: key);

  @override
  State<SurveyDetail> createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final FirebaseService firebaseService = FirebaseService();
  
  int questionIndex = 0;
  List<Question> retrievedQuestionList = [];
  
  void initRetrieval() async {
    retrievedQuestionList = await firebaseService.retrieveQuestions("cBdG0CfsBbvixRHlNaWc");
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    questionIndex = 0;
    initRetrieval();
  }

  @override
  Widget build(BuildContext context) {
    return mainWidget();
  }

  Widget mainWidget() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
          backgroundColor: const Color(0xff0f2147),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NavigationScreen(index: surveyScreen,)));
            },
          ),
        ),
        body: Center(
          child: (retrievedQuestionList.isEmpty) ? const Text("Loading...") :
          Column(
            children: <Widget> [
              Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    retrievedQuestionList[questionIndex].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text( retrievedQuestionList[questionIndex].id!),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: () {
                  setState(() {
                    questionIndex++;
                  });
                },
                child: const Text('Next Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
