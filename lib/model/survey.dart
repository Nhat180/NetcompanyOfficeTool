import 'package:cloud_firestore/cloud_firestore.dart';

class Survey {
  final String? id;
  final String title;
  final String creator;
  final List<String>? usersHaveTaken;
  final Timestamp dateCreated;
  final Timestamp dateExpired;

  const Survey({
    this.id,
    required this.title,
    required this.creator,
    required this.usersHaveTaken,
    required this.dateCreated,
    required this.dateExpired,
  });

  Survey.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : id = doc.id,
      title = doc.data()!["title"],
      creator = doc.data()!["createdBy"],
        usersHaveTaken = doc.data()?["usersHaveTaken"] == null
          ? null
          : doc.data()?["usersHaveTaken"].cast<String>(),
      dateCreated = doc.data()!["created"],
      dateExpired = doc.data()!["close"];
}