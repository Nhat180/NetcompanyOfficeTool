import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netcompany_office_tool/model/comment.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';

class CommentImage extends StatefulWidget {
  final String id;
  final String featureType;

  const CommentImage({Key? key, required this.id, required this.featureType}) : super(key: key); /// Note: Add report/suggestion case

  @override
  CommentImageState createState() => CommentImageState();
}

class CommentImageState extends State<CommentImage> {
  final StorageService storageService = StorageService();
  final FirebaseService firebaseService = FirebaseService();

  bool loading = false;

  File? image;
//https://www.youtube.com/watch?v=IePaAGXzmtU&t=704s
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 50);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton (
                        icon: const Icon(Icons.image),
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        }),

                    IconButton (
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () {
                                pickImage(ImageSource.camera);
                        }
                        ),
                  ],
                ),

                const Text(''),
                ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      splashColor: Colors.red, // Splash color
                      onTap: closeDrawer,
                      child: const SizedBox(width: 30, height: 30, child: Icon(Icons.close)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          image != null ?

          Column(
            children: [
              Image.file(image!, width: 250, height: MediaQuery.of(context).size.height / 3, fit: BoxFit.cover),

              const SizedBox(height: 10,),

              ElevatedButton(
                  child: (loading) ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,)) :
                  const Text('Send', style: TextStyle(fontSize: 15),),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    String? name = await storageService.readSecureData('name');
                    final int commentID = await firebaseService.getTotalComment(widget.id, widget.featureType);
                    final String imgUrl = await firebaseService.uploadFile(image!);

                    Comment comment = Comment(
                        creator: name,
                        type: "image",
                        text: "",
                        imgUrl: imgUrl);

                    await firebaseService.addComment(comment, commentID, widget.id, widget.featureType); /// Note: Add suggestion case
                    FirebaseFirestore.instance.collection(widget.featureType)
                        .doc(widget.id).update({'totalCom': commentID + 1}); /// Note: Add suggestion case
                    closeDrawer();

                    setState(() {
                      loading = false;
                    });
                  }
              ),
            ],
          )
                      :
          Column(
            children: const [
              SizedBox(height: 150),
              Text("No image selected"),
            ],
          ),
        ],
      ),
    );
  }

  void closeDrawer() {
    Navigator.of(context).pop();
  }
}