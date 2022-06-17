import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'landscape_mode.dart';
import 'navigation_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

Future<bool> login (String name, String password) async {
  const String api = "https://netcompany-crawl-server.herokuapp.com/auth";
  // const String api = "http://10.0.2.2:8080/auth";
  final response = await http.post(Uri.parse(api),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
      'username': name,
      'password': password
    })
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }

}

// Save user info to Firestore
Future<void> setUser (String name) async {
  final firestoreDB = FirebaseFirestore.instance;
  await firestoreDB.collection("users").doc(name).set({
    "username": name,
    "isAdmin": false
  });
}

// Register current user to Firebase auth
Future<void> register (String name, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: name+"@gmail.com",
        password: password
    );
    setUser(name);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      loginFirebase(name, password);
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}

// Sign in current user to Firebase auth
Future<void> loginFirebase (String name, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: name+"@gmail.com",
        password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // ignore: avoid_print
      print('No user found for that email.');
    } else if (e.code == "wrong-password") {
      // ignore: avoid_print
      print('Wrong password');
    }
  }
}

class InitState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _isPassVisible = true;
  
  bool isUsernameEmpty = true;
  bool isPassEmpty = true;
  bool buttonLoading = false;

  var fSnackBar = const SnackBar(content: Text("The username and password must fill"));
  var uSnackBar = const SnackBar(content: Text("The username must fill"));
  var pSnackBar = const SnackBar(content: Text("The password must fill"));
  var alertSnackBar = const SnackBar(content: Text("Wrong username or password"));

  final TextEditingController usernameController  = TextEditingController();
  final TextEditingController passwordController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return initWidget();
    } else {
     return const LandScape();
    }
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
                        controller: usernameController,
                        cursorColor: const Color(0xff0f2147),
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "Your Netcompany Name",
                            errorStyle: const TextStyle(height: 0),
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
                            isUsernameEmpty = true;
                            return '';
                          } else {
                            isUsernameEmpty = false;
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
                        controller: passwordController,
                        cursorColor: const Color(0xff0f2147),
                        obscureText: _isPassVisible,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "Password",
                            errorStyle: const TextStyle(height: 0),
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
                            isPassEmpty = true;
                            return '';
                          } else {
                            isPassEmpty = false;
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
              onTap: () async{
                if (_formKey.currentState!.validate()) {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => NavigationScreen()));
                  final String name = usernameController.text;
                  final String password = passwordController.text;

                  setState(() {
                    buttonLoading = true;
                  });

                  final bool isAuthenticate = await login(name, password);


                  if(isAuthenticate) {
                    register(name, password);
                    setState(() {
                      buttonLoading = false;
                    });
                    if (!buttonLoading) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => NavigationScreen(index: 0)));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(alertSnackBar);
                    setState(() {
                      buttonLoading = false;
                    });
                  }
                } else {
                  if (isUsernameEmpty && isPassEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(fSnackBar);
                  } else if (isPassEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(pSnackBar);
                  } else if (isUsernameEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(uSnackBar);
                  }
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
                child: (buttonLoading)
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                      ))
                : const Text(
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
