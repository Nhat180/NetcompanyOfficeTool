import 'package:cloud_firestore/cloud_firestore.dart';

class Draft {
  final String? id;
  final String? creator;
  final String title;
  final String dateCreate;
  final String status;
  final String type;
  final String description;
  final List<String>? imgUrls;

  const Draft({
    this.id,
    this.creator,
    required this.title,
    required this.dateCreate,
    required this.status,
    required this.type,
    required this.description,
    required this.imgUrls
  });

  Map<String, dynamic> toMap() {
    return {
      'creator': creator,
      'title': title,
      'dateCreate': dateCreate,
      'status': status,
      'type': type,
      'description': description,
      'imgUrls': imgUrls
    };
  }

  Draft.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        creator = doc.data()!["creator"],
        title = doc.data()!["title"],
        dateCreate = doc.data()!["dateCreate"],
        status = doc.data()!["status"],
        type = doc.data()!["type"],
        description = doc.data()!["description"],
        imgUrls = doc.data()?["imgUrls"] == null
            ? null
            : doc.data()?["imgUrls"].cast<String>();
}


const allDrafts =[
  Draft(
      creator: "SADSDA",
      title: '',
      dateCreate: '11/12/2022',
      status: "Draft",
      type: "Device",
      description: "This is one of the most useful case, I wanna buy new laptop to study iOS. However, my family can not be affordable , so can you help me?",
      imgUrls: ["https://play-lh.googleusercontent.com/6f6MrwfRIEnR-OIKIt_O3VdplItbaMqtqgCNSOxcfVMCKGKsOdBK5XcI6HZpjssnB2Y"],
  ),

  Draft(
      creator: 'Nhat nguyen',
      title: '',
      dateCreate: '11/12/2022',
      status: "Draft",
      type: "Device",
      description: "",
      imgUrls: ["https://play-lh.googleusercontent.com/6f6MrwfRIEnR-OIKIt_O3VdplItbaMqtqgCNSOxcfVMCKGKsOdBK5XcI6HZpjssnB2Y"],
  ),

  Draft(
      creator: 'Hoang nguyen',
      title: 'Broken A Red Glass of My mother ',
      dateCreate: '11/12/2022',
      status: "Draft",
      type: "Food",
      description: "this is one of the most useful case",
      imgUrls: ["https://play-lh.googleusercontent.com/6f6MrwfRIEnR-OIKIt_O3VdplItbaMqtqgCNSOxcfVMCKGKsOdBK5XcI6HZpjssnB2Y"],
  ),

  Draft(
      creator: 'Nhat nguyen',
      title: 'Broken A Red Glass of My mother ',
      dateCreate: '13/12/2022',
      status: "Draft",
      type: "Device",
      description: "this is one of the most useful case",
      imgUrls: ["https://play-lh.googleusercontent.com/6f6MrwfRIEnR-OIKIt_O3VdplItbaMqtqgCNSOxcfVMCKGKsOdBK5XcI6HZpjssnB2Y"],
  ),

  Draft(
      creator: 'Nhat nguyen',
      title: 'Broken A Red Glass of My mother ',
      dateCreate: '12/12/2022',
      status: "Draft",
      type: "Device",
      description: "this is one of the most useful case",
      imgUrls: ["https://play-lh.googleusercontent.com/6f6MrwfRIEnR-OIKIt_O3VdplItbaMqtqgCNSOxcfVMCKGKsOdBK5XcI6HZpjssnB2Y"],
  ),

  Draft(
      creator: 'Hong nguyen',
      title: 'Broken A Red Glass of My mother ',
      dateCreate: '11/12/2022',
      status: "Draft",
      type: "Device",
      description: "this is one of the most useful case",
      imgUrls: ["https://play-lh.googleusercontent.com/6f6MrwfRIEnR-OIKIt_O3VdplItbaMqtqgCNSOxcfVMCKGKsOdBK5XcI6HZpjssnB2Y"],
  ),

  Draft(
      creator: 'Nhat nguyen',
      title: 'Broken A Red Glass of My mother ',
      dateCreate: '11/12/2022',
      status: "Draft",
      type: "Device",
      description: "this is one of the most useful case",
      imgUrls: ["https://play-lh.googleusercontent.com/6f6MrwfRIEnR-OIKIt_O3VdplItbaMqtqgCNSOxcfVMCKGKsOdBK5XcI6HZpjssnB2Y"],
  ),


];
