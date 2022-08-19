import 'package:flutter/material.dart';


class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends  State<FeedbackScreen> {

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }
  // trang chung cho report and suggestion
  Widget initWidget() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/admin.png", height: 380,fit: BoxFit.cover,),
          Text("or"),
          Image.asset("images/admin.png", height: 380,fit: BoxFit.cover,),
        ],
      ),
    );
  }
}