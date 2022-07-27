import 'package:flutter/material.dart';

class FormAlert extends StatefulWidget {
  const FormAlert({Key? key}) : super(key: key);

  @override
  State<FormAlert> createState() => _FormAlertState();
}

class _FormAlertState extends State<FormAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      title: const Text("Required Fields Missing!"),
      content: const Text("Title and description must be filled to submit the form."),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK")
        ),
      ],
    );
  }
}
