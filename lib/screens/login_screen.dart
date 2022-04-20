import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              height: 350,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  color: Color(0xff0f2147),
                  gradient: LinearGradient(
                      colors: [(Color(0xff0f2147)), (Color(0xff0f2147))],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Image.asset("images/logo_login.png"),
                    height: 330,
                  ),
                ],
              ))),

          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.only(left: 20, right: 20, top: 90),
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   height: 54,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     color: Colors.grey[200],
          //     boxShadow: const [
          //       BoxShadow(
          //           offset: Offset(0, 10),
          //           blurRadius: 50,
          //           color: Color(0xff0f2147)
          //       ),
          //     ],
          //   ),
          //   child: const TextField(
          //     cursorColor: Color(0xff0f2147),
          //     decoration: InputDecoration(
          //       icon: Icon(
          //         Icons.person,
          //         color: Color(0xff0f2147),
          //       ),
          //       hintText: "Enter Your Initial Name",
          //       enabledBorder: InputBorder.none,
          //       focusedBorder: InputBorder.none,
          //     ),
          //   ),
          // ),

          Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 92),
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xff0f2147)),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 90),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    cursorColor: const Color(0xff0f2147),
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: "Your Netcompany Name",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xff0f2147))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xff0f2147))),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color(0xff0f2147),
                        )),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 90, right: 90, top: 50),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [(Color(0xff0f2147)), Color(0xff0f2147)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: const Text(
                "LOGIN",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
