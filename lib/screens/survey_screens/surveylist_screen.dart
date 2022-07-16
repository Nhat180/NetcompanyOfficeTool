import 'dart:core';

import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/dialog/survey_retake_dialog.dart';
import 'package:netcompany_office_tool/screens/survey_screens/survey_detail_screen.dart';
import 'package:netcompany_office_tool/screens/survey_screens/survey_welcome_screen.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:intl/intl.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';

import '../../model/survey.dart';

class SurveyListScreen extends StatefulWidget {
  const SurveyListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SurveyListScreen> {
  final StorageService storageService = StorageService();
  final FirebaseService firebaseService = FirebaseService();
  Future<List<Survey>>? surveyList;
  List<Survey>? retrievedSurveyList;
  String? name;

  void initRetrieval() async {
    name = await storageService.readSecureData('name');
    retrievedSurveyList = await firebaseService.retrieveSurveys();
    setState(() {
      surveyList = firebaseService.retrieveSurveys();
    });
  }


  @override
  void initState(){
    super.initState();
    initRetrieval();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: surveyList,
            builder: (BuildContext context,  AsyncSnapshot<List<Survey>> snapshot) {
              if(snapshot.hasError) return const Text("Error");

              if(snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: retrievedSurveyList!.length,
                  itemBuilder: (context, index) {
                    final survey = retrievedSurveyList![index];
                    return Padding(
                      // padding: (index % 2) == 0 ? EdgeInsets.only(bottom: 15) : EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 10,
                        shadowColor: const Color(0xff0f2147),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.green[500],
                                radius: 40,
                                child: const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "images/survey.png"), //NetworkImage
                                  radius: 100,
                                ), //CircleAvatar
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  survey.title, textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis, softWrap: false
                              ),
                            ), //Text
                            //SizedBox

                            Text(
                              'Expired on ' + DateFormat('dd/MM/yyyy').format(survey.dateExpired.toDate()),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              width: (survey.usersHaveTaken!.contains(name!)) ? 100 : 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (survey.usersHaveTaken!.contains(name!)) {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return SurveyRetakeDialog(surveyID: survey.id!,);
                                        });
                                  } else {
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) => WelcomeSurvey(survey: survey)
                                    ));
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(const Color(0xff0f2147))),

                                child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.touch_app),
                                      (survey.usersHaveTaken!.contains(name!)) ?
                                      const Text('Retake') : const Text('Take')
                                    ],
                                  ),
                                ),
                              ),
                            ) ,
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              if (snapshot.connectionState == ConnectionState.done && retrievedSurveyList!.isEmpty) {
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.search_off,
                          size: 100,
                          color: Colors.blue,
                        ),
                        Text(('No survey available at the moment'),
                            style:
                            TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,)
                      ],
                ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}