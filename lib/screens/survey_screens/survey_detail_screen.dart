import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netcompany_office_tool/constants.dart';
import 'package:netcompany_office_tool/model/answer.dart';
import 'package:netcompany_office_tool/model/question.dart';
import 'package:netcompany_office_tool/screens/survey_screens/survey_finish_screen.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';

import '../navigation_screen.dart';

class SurveyDetail extends StatefulWidget {
  final String surveyID;

  const SurveyDetail({Key? key, required this.surveyID}) : super(key: key);

  @override
  State<SurveyDetail> createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final FirebaseService firebaseService = FirebaseService();

  final TextEditingController textController = TextEditingController();
  int questionIndex = 0;
  bool loading = false;
  List<Question> retrievedQuestionList = [];
  
  void initRetrieval() async {
    retrievedQuestionList = await firebaseService.retrieveQuestions(widget.surveyID);
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
        resizeToAvoidBottomInset: false,
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
                margin: const EdgeInsets.only(top: 10, bottom: 8, left: 30, right: 30),
                child: Center(
                  child: Text(
                    retrievedQuestionList[questionIndex].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              // Text(retrievedQuestionList[questionIndex].type),
              (retrievedQuestionList[questionIndex].type == 'MULTIPLECHOICE') ?
                  multipleChoiceWidget() :
              retrievedQuestionList[questionIndex].type == 'SINGLECHOICE' ?
              singleChoiceWidget() : shortAnswerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget multipleChoiceWidget() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("surveys")
            .doc(widget.surveyID).collection("questions")
            .doc(retrievedQuestionList[questionIndex].id).collection("answers").get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isNotEmpty) {
            List<Answer> answerOptions = snapshot.data!.docs.map((docSnapshot) =>
                Answer.fromDocumentSnapshot(docSnapshot)).toList();
            Map<String, dynamic> values = {};
            Map<String, dynamic> choiceCountValues = {};
            for(int i = 0; i < answerOptions.length; i++) {
              values[answerOptions[i].id!] = false;
              choiceCountValues[answerOptions[i].id!] = answerOptions[i].choiceCount;
            }
            return Column(
              children: <Widget> [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: StatefulBuilder(builder: (context, _setState) =>
                            ListTile(
                              onTap: () {
                                _setState(() => values[answerOptions[index].id!] = !values[answerOptions[index].id!]);
                              },
                              leading: Checkbox(
                                value: values[answerOptions[index].id],
                                onChanged: (bool? value) {
                                  _setState(() => values[answerOptions[index].id!] = value);},
                              ),
                              title: Text(answerOptions[index].title),
                            ),
                        ),
                      );
                    }),
                const SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if((questionIndex + 1) == retrievedQuestionList.length) {
                      for (MapEntry e in values.entries) {
                        if (e.value == true) {
                          // ignore: avoid_print
                          print(choiceCountValues[e.key]);
                          FirebaseFirestore.instance.collection("surveys")
                              .doc(widget.surveyID).collection("questions")
                              .doc(retrievedQuestionList[questionIndex].id)
                              .collection("answers").doc(e.key)
                              .update({'choiceCount': choiceCountValues[e.key] + 1});
                        }
                      }
                      setState(() {
                        loading = false;
                      });

                      if (!loading) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const FinishSurvey()));
                      }
                    } else {
                      for (MapEntry e in values.entries) {
                        if (e.value == true) {
                          // ignore: avoid_print
                          print(choiceCountValues[e.key]);
                          FirebaseFirestore.instance.collection("surveys")
                              .doc(widget.surveyID).collection("questions")
                              .doc(retrievedQuestionList[questionIndex].id)
                              .collection("answers").doc(e.key)
                              .update({'choiceCount': choiceCountValues[e.key] + 1});
                        }
                      }
                      setState(() {
                        loading = false;
                      });

                      if (!loading) {
                        setState(() {
                          questionIndex++;
                        });
                      }
                    }
                  },
                  child: (loading) ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,)) : const Text("Next"),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }

  Widget shortAnswerWidget() {
    return Center(
      child: Column(
        children: <Widget> [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xff0f2147)),
                bottom: BorderSide(color: Color(0xff0f2147)),
              )
            ),
            child: TextField(
              controller: textController,
              maxLength: 100,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Your answer here...',
                hintStyle: TextStyle(color: Color(0xff606060), fontSize: 15),
                contentPadding: EdgeInsets.only(left: 15, right: 12),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              String textAnswer = textController.text;
              if((questionIndex + 1) == retrievedQuestionList.length) {

                await firebaseService.addTextAnswer(
                    widget.surveyID,
                    retrievedQuestionList[questionIndex].id!,
                    textAnswer);

                textController.clear();

                setState(() {
                  loading = false;
                });

                if (!loading) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const FinishSurvey()));
                }

              } else {

                await firebaseService.addTextAnswer(
                    widget.surveyID,
                    retrievedQuestionList[questionIndex].id!,
                    textAnswer);

                textController.clear();

                setState(() {
                  loading = false;
                });

                if (!loading) {
                  setState(() {
                    questionIndex++;
                  });
                }
              }
            },
            child: (loading) ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,)) : const Text("Next"),
          ),
        ],
      ),
    );
  }

  Widget singleChoiceWidget() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("surveys")
            .doc(widget.surveyID).collection("questions")
            .doc(retrievedQuestionList[questionIndex].id).collection("answers").get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.data!.docs.isNotEmpty) {
            List<Answer> answerOptions = snapshot.data!.docs.map((docSnapshot) =>
                Answer.fromDocumentSnapshot(docSnapshot)).toList();
            String? optionBefore;
            Map<String, dynamic> values = {};
            Map<String, dynamic> choiceCountValues = {};
            for(int i = 0; i < answerOptions.length; i++) {
              values[answerOptions[i].id!] = false;
              choiceCountValues[answerOptions[i].id!] = answerOptions[i].choiceCount;
            }
            return Column(
              children: <Widget> [
                StatefulBuilder(builder: (context, StateSetter setState) =>
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: (values[answerOptions[index].id!]) ?
                                    const Color(0xff0f2147) : Colors.white
                                )
                            ),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  if (optionBefore == null) {
                                    values[answerOptions[index].id!] = !values[answerOptions[index].id!];
                                    optionBefore = answerOptions[index].id!;
                                  } else {
                                    if (optionBefore == answerOptions[index].id!) {
                                      values[answerOptions[index].id!] = !values[answerOptions[index].id!];
                                      optionBefore = null;
                                    } else {
                                      values[optionBefore!] = false;
                                      values[answerOptions[index].id!] = !values[answerOptions[index].id!];
                                      optionBefore = answerOptions[index].id!;
                                    }
                                  }
                                });
                              },
                              leading: Icon((values[answerOptions[index].id!]) ?
                              Icons.done : null, color: const Color(0xff0f2147)),
                              title: Text(answerOptions[index].title),
                            ),
                          );
                        })
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if((questionIndex + 1) == retrievedQuestionList.length) {
                      for (MapEntry e in values.entries) {
                        if (e.value == true) {
                          // ignore: avoid_print
                          print(choiceCountValues[e.key]);
                          FirebaseFirestore.instance.collection("surveys")
                              .doc(widget.surveyID).collection("questions")
                              .doc(retrievedQuestionList[questionIndex].id)
                              .collection("answers").doc(e.key)
                              .update({'choiceCount': choiceCountValues[e.key] + 1});
                        }
                      }
                      setState(() {
                        loading = false;
                      });

                      if (!loading) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const FinishSurvey()));
                      }
                    } else {
                      for (MapEntry e in values.entries) {
                        if (e.value == true) {
                          // ignore: avoid_print
                          print(e.key);
                          FirebaseFirestore.instance.collection("surveys")
                              .doc(widget.surveyID).collection("questions")
                              .doc(retrievedQuestionList[questionIndex].id)
                              .collection("answers").doc(e.key)
                              .update({'choiceCount': choiceCountValues[e.key] + 1});
                        }
                      }
                      setState(() {
                        loading = false;
                      });

                      if (!loading) {
                        setState(() {
                          questionIndex++;
                        });
                      }
                    }
                  },
                  child: (loading) ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,)) : const Text("Next"),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }
}
