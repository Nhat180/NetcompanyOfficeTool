import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class CommentBox extends StatefulWidget{
  const CommentBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentBoxState();

}

class CommentBoxState extends State<CommentBox>{
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

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
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)
                          )
                      ),
                      builder: (context) => Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 250, width: 100,),
                            image != null ? Image.file(image!, width: 80, height: 140,): Text("No image selected"),

                            ElevatedButton(
                                child: const Text('add image'),
                                onPressed: () {
                                  pickImage();
                                }
                              // onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ));
                }),
            IconButton(icon: const Icon(Icons.send), onPressed: () {}),
          ],))
      ]),
    );
  }
}