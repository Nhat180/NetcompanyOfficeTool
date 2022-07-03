import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netcompany_office_tool/comments/comment_image.dart';


class CommentBox extends StatefulWidget{
  const CommentBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentBoxState();

}

class CommentBoxState extends State<CommentBox>{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(color: Color(0xffEDEDED), borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        TextFormField(
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
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => CommentImage(),
                  );
                }
            ),
            IconButton(icon: const Icon(Icons.send), onPressed: () {}),
          ],))
      ]),
    );
  }
}