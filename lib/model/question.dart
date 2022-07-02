import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String? id;
  final String title;
  final String type;

  const Question({
    this.id,
    required this.title,
    required this.type,
  });

  Question.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : id = doc.id,
      title = doc.data()!["title"],
      type = doc.data()!["type"];

}