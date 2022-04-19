import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends  State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              child: Image.asset("images/logo.jpg"),
            ),

            

          )
        ],
      ),
    );
  }
}
