import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends  State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    startTimer();
  }
  
  startTimer() async {
    var duration = Duration(seconds: 1);
        return new Timer(duration, loginRoute);
  }
  
  loginRoute(){
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginScreen()
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: new Color(0xff0f2147),
              gradient: LinearGradient(
                colors: [(new Color(0xff0f2147)), (new Color(0xff0f2147))],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),

          Center(
            child: Container(
                margin: EdgeInsets.all(10),
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://haymora.com/upload/images/cong_nghe_thong_tin/software/netcompany/netcompany-logo.jpg'),
                  fit: BoxFit.fill)
              )
            ),
          )
        ],
      ),
    );
  }
}
