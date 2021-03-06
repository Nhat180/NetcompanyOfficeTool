import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/constants.dart';
import 'authentication_screens/login_screen.dart';
import 'navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
    var duration = const Duration(seconds: 4);
        return Timer(duration, loginRoute);
  }
  
  loginRoute(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => NavigationScreen(index: homeScreen,)
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const LoginScreen()
      ));
    }
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
            decoration: const BoxDecoration(
              color: Color(0xff0f2147),
              gradient: LinearGradient(
                colors: [(Color(0xff0f2147)), (Color(0xff0f2147))],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),

          Center(
            child: Container(margin: const EdgeInsets.all(10),
              width: 500,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("images/logo.jpg"),
                  fit: BoxFit.fill)
              )
            ),
          )
        ],
      ),
    );
  }
}
