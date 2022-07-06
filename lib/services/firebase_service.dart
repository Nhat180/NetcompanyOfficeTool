import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:netcompany_office_tool/model/comment.dart';
import 'package:netcompany_office_tool/model/question.dart';
import 'package:netcompany_office_tool/model/report.dart';
import 'package:path/path.dart' as Path;

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

  Future<List<Report>> retrieveReports(String name) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection("reports").where("creator", isEqualTo: name).get();
    return snapshot.docs.map((docSnapshot) => Report.fromDocumentSnapshot(docSnapshot)).toList();
  }

  Future<void> addReport (Report report) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("reports").add(report.toMap());
  }

  /// Note: Add suggestion case
  Future<void> addComment (Comment comment, int commentID, String reportID) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("reports").doc(reportID).collection("comments").doc(commentID.toString()).set(comment.toMap());
  }

  /// Note: Add suggestion case
  Future<int> getTotalComment(String id) async {
    var collection = FirebaseFirestore.instance.collection("reports");
    var doc = await collection.doc(id).get();
    int total = 0;
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data();
      total = data!["totalCom"];
    }
    return total;
  }

  /// Note: Add suggestion case
  Future<List<String>> uploadFiles(List<File>? images) async {
    List<String> url = [];
    firebase_storage.Reference ref;
    if(images!.isEmpty) {
      return url;
    } else {
      for(var image in images) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('reports_img/${Path.basename(image.path)}');
        await ref.putFile(image).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            url.add(value);
          });
        });
      }
      return url;
    }
  }

  Future<String> uploadFile(File image) async {
    String imgUrl = '';
    firebase_storage.Reference reference;
    reference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('comments_img/${Path.basename(image.path)}');
    await reference.putFile(image).whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        imgUrl = value;
      });
    });
    return imgUrl;
  }

  Future<List<Question>> retrieveQuestions(String surveyID) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection("surveys").doc(surveyID).collection("questions").get();
    return snapshot.docs.map((docSnapshot) => Question.fromDocumentSnapshot(docSnapshot)).toList();
  }
}