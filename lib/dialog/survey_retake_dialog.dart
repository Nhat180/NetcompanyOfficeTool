import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/screens/survey_screens/survey_detail_screen.dart';

class SurveyRetakeDialog extends StatefulWidget {
  final String surveyID;
  
  const SurveyRetakeDialog({Key? key, required this.surveyID}) : super(key: key);

  @override
  State<SurveyRetakeDialog> createState() => _SurveyRetakeDialogState();
}

class _SurveyRetakeDialogState extends State<SurveyRetakeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      title: const Text("Retake Survey"),
      content: const Text("This survey was taken before, do you want to do it again?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")
        ),

        TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  SurveyDetail(surveyID: widget.surveyID)), (Route<dynamic> route) => false);
            },
            child: const Text("Start!")
        ),
      ],
    );
  }
}
