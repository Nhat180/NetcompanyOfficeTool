import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirebaseService {

  Future<void> registerFirebase (String name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: name+"@gmail.com",
          password: "123456"
      );
      setUser(name);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        loginFirebase(name);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> setUser (String name) async {
    final firestoreDB = FirebaseFirestore.instance;
    await firestoreDB.collection("users").doc(name).set({
      "username": name,
      "isAdmin": false
    });
  }

  Future<void> loginFirebase (String name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: name+"@gmail.com",
          password: "123456"
      );
      user = userCredential.user;
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

  Future<DateTime> getCrawlTimeStamp() async {
    var collection = FirebaseFirestore.instance.collection("lunch");
    var doc = await collection.doc("updateTime").get();
    // String value = '';
    DateTime dateTime = DateTime.now();
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data();
      Timestamp timestamp = data!['updateDate'];
      dateTime = timestamp.toDate();
      // value = DateFormat('yyyy-MM-dd – kk:mm:ss').format(dateTime);
    }
    return dateTime;
  }
}