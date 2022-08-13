import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netcompany_office_tool/model/draft.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';

import '../constants.dart';

class DraftDialog extends StatefulWidget {
  final int formType;
  final String title;
  final String description;
  final String type;
  final List<File> imgUrls;

  const DraftDialog({Key? key,
    required this.formType,
    required this.title,
    required this.description,
    required this.type,
    required this.imgUrls}) : super(key: key);

  @override
  State<DraftDialog> createState() => _DraftDialogState();
}

class _DraftDialogState extends State<DraftDialog> {
  final FirebaseService firebaseService = FirebaseService();
  final StorageService storageService = StorageService();

  DateTime currentDateTime = DateTime.now();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return (loading) ? WillPopScope(
      onWillPop: () => Future.value(false),
      child: const Center(child: CircularProgressIndicator(),),) :
    AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      title: const Text("Save Draft"),
      content: const Text("Do you want to save this form as a draft to edit later?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  NavigationScreen(index: widget.formType)), (Route<dynamic> route) => false);
            },
            child: const Text("No")
        ),

        TextButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });
              String? name = await storageService.readSecureData('name');
              final List<String> imgUrls = await firebaseService.uploadFiles(
                widget.imgUrls, true,
                  (widget.formType == reportFormType)
                      ? "reports" : "suggestions");
              String formattedDate = DateFormat('yyyy-MM-dd').format(currentDateTime);

              Draft draft = Draft(
                  creator: name,
                  title: widget.title,
                  dateCreate: formattedDate,
                  status: 'draft',
                  type: widget.type,
                  description: widget.description,
                  imgUrls: imgUrls);

              if (widget.formType == reportFormType) {
                await firebaseService.addDraft(draft, "draftReports");
              } else {
                await firebaseService.addDraft(draft, "draftSuggestions");
              }

              setState(() {
                loading = false;
              });

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  NavigationScreen(index: widget.formType)), (Route<dynamic> route) => false);

            },
            child: const Text("Yes")
        ),
      ],
    );
  }
}
