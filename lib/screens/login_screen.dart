import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=> InitState();
}

class InitState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }
  Widget initWidget(){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(25), bottomRight:  Radius.circular(25)),

                color: Color(0xff0f2147),
                gradient: LinearGradient(
                  colors: [(new Color(0xff0f2147)), (new Color(0xff0f2147))],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image.asset("images/logo_login.png"),
                      height: 330,
                    ),
                  ],
                )
              )
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 90),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xff0f2147)
                  ),
                ],
              ),
              child: TextField(
                cursorColor: Color(0xff0f2147),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xff0f2147),
                  ),
                  hintText: "Enter Your Initial Name",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => HomeScreen()
                ));
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 90, right: 90, top: 90),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [(new  Color(0xff0f2147)), new Color(0xff0f2147)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)
                    ),
                  ],
                ),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
            ),



          ],
        )
      ),
    );
  }
}