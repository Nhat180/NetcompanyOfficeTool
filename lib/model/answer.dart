import 'package:cloud_firestore/cloud_firestore.dart';

class Answer {
  final String? id;
  final String title;
  final int choiceCount;

  const Answer({
    this.id,
    required this.title,
    required this.choiceCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'choiceCount': choiceCount
    };
  }

  Answer.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : id = doc.id,
      title = doc.data()!["title"],
      choiceCount = doc.data()!["choiceCount"];
}