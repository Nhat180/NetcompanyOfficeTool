import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String? id;
  final String? creator;
  final String title;
  final String dateCreate;
  final String status;
  final String type;
  final String description;
  final bool notification;
  final List<String>? imgUrls;
  final int totalCom;

  const Report({
    this.id,
    this.creator,
    required this.title,
    required this.dateCreate,
    required this.status,
    required this.type,
    required this.description,
    required this.notification,
    required this.imgUrls,
    required this.totalCom,
  });

  Map<String, dynamic> toMap() {
    return {
      'creator': creator,
      'title': title,
      'dateCreate': dateCreate,
      'status': status,
      'type': type,
      'description': description,
      'noti': notification,
      'imgUrls': imgUrls,
      'totalCom': totalCom
    };
  }

  Report.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        creator = doc.data()!["creator"],
        title = doc.data()!["title"],
        dateCreate = doc.data()!["dateCreate"],
        status = doc.data()!["status"],
        type = doc.data()!["type"],
        description = doc.data()!["description"],
        notification = doc.data()!["noti"],
        imgUrls = doc.data()?["imgUrls"] == null
                  ? null
                  : doc.data()?["imgUrls"].cast<String>(),
        totalCom = doc.data()!["totalCom"];
}
