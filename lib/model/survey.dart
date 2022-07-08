import 'package:cloud_firestore/cloud_firestore.dart';

class Survey {
  final String? id;
  final String title;
  final String creator;
  final Timestamp dateCreated;
  final Timestamp dateExpired;

  const Survey({
    this.id,
    required this.title,
    required this.creator,
    required this.dateCreated,
    required this.dateExpired,
  });

  Survey.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : id = doc.id,
      title = doc.data()!["title"],
      creator = doc.data()!["createdBy"],
      dateCreated = doc.data()!["created"],
      dateExpired = doc.data()!["close"];
}