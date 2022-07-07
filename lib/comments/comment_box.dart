import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netcompany_office_tool/comments/comment_image.dart';
import 'package:netcompany_office_tool/model/comment.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';


class CommentBox extends StatefulWidget{
  final String id;
  final String featureType;

  const CommentBox({Key? key, required this.id, required this.featureType}) : super(key: key); /// Note: Add report/suggestion case

  @override
  State<StatefulWidget> createState() => CommentBoxState();

}

class CommentBoxState extends State<CommentBox>{
  final StorageService storageService = StorageService();
  final FirebaseService firebaseService = FirebaseService();
  final TextEditingController textController  = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(color: const Color(0xffEDEDED), borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        TextFormField(
          controller: textController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Type here...',
            hintStyle: TextStyle(color: Color(0xff606060), fontSize: 15),
            contentPadding: EdgeInsets.only(right: 90),
          ),
        ),
        Positioned(bottom: 0,right: 0,child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => CommentImage(id: widget.id, featureType: widget.featureType,), /// Note: Add suggestion case
                  );
                }
            ),
            (loading) ? const Center(child: CircularProgressIndicator(),) :
            IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  if (textController.text.isEmpty || textController.text == '') {
                    // ignore: avoid_print
                    print("pls type something");
                  } else {
                    setState(() {
                      loading = true;
                    });
                    String? name = await storageService.readSecureData('name');
                    final int commentID = await firebaseService.getTotalComment(widget.id, widget.featureType);
                    final String text = textController.text;

                    Comment comment = Comment(
                        creator: name,
                        type: "text",
                        text: text,
                        imgUrl: "");


                    await firebaseService.addComment(comment, commentID, widget.id, widget.featureType); /// Note: Add suggestion case
                    FirebaseFirestore.instance.collection(widget.featureType)
                        .doc(widget.id).update({'totalCom': commentID + 1}); /// Note: Add suggestion case
                    textController.clear();

                    setState(() {
                      loading = false;
                    });

                  }
                }),
          ],))
      ]),
    );
  }
}