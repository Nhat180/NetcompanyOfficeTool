import 'package:flutter/material.dart';
import 'navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _isPassVisible = true;

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
              // height: 350,
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
                      height: 300,
                  ),
                ],
              ))),
            Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: Column(
                children: <Widget>[
                /** Username text field **/
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin:
                          const EdgeInsets.only(left: 25, right: 25, top: 70),
                      // padding: const EdgeInsets.only(left: 50, right: 50),
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
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 68),
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        cursorColor: const Color(0xff0f2147),
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "Your Netcompany Name",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
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

                /** Password text field **/
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin:
                          const EdgeInsets.only(left: 25, right: 25, top: 40),
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
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 38),
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        cursorColor: const Color(0xff0f2147),
                        obscureText: _isPassVisible,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "Password",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 22),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Color(0xff0f2147))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Color(0xff0f2147))),
                            prefixIcon: const Icon(
                              Icons.shield,
                              color: Color(0xff0f2147),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPassVisible = !_isPassVisible;
                                });
                              },
                              child: Icon(_isPassVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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
              ],
            ),
          ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NavigationScreen()));
                } else {
                  setState(() {
                    _autoValidateMode = AutovalidateMode.always;
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
          ],)
      ),
    );
  }
}
