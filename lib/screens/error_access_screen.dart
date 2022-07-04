import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/screens/history_menu_screen.dart';


class ErrorAccessScreen extends StatefulWidget {
  const ErrorAccessScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ErrorAccessScreen> {

  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text.rich(
                    TextSpan(
                      text: 'Oops ', // default text style'
                      style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 40, color: Colors.red),
                      children: <TextSpan>[
                        TextSpan(text: 'something went wrong!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xff0f2147))),
                      ],
                    )
                )
            ),
          ),

          Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(

                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    label: const Icon(Icons.arrow_circle_right,
                        size: 30,
                        color: Color(0xff0f2147)),
                    icon: const Text('History',
                        style: TextStyle(
                          color: Color(0xff0f2147),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
                          decoration: TextDecoration.underline,)
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const HistoryMenuScreen()
                      ));

                    },
                  ),
                ],
              )
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left:40.0, top: 150.0),
              child: Text.rich(
                  TextSpan(
                    text: 'Note: ', // default text style'
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xff0f2147)),
                    children: <TextSpan>[
                      TextSpan(text: 'If you update your password recently try logging in again', style: TextStyle(fontSize: 22, color: Color(0xff0f2147))),
                    ],
                  )

              ),

            ),
          )
        ]
    );
  }



}