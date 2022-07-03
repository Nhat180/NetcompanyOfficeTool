import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CommentImage extends StatefulWidget {
  const CommentImage({Key? key}) : super(key: key);

  @override
  CommentImageState createState() => CommentImageState();
}

class CommentImageState extends State<CommentImage> {
  File? image;
//https://www.youtube.com/watch?v=IePaAGXzmtU&t=704s
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
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
                            icon: Icon(Icons.image),
                              onPressed: () {
                                pickImage(ImageSource.gallery);
                              }
                          ),

                          IconButton (
                              icon: Icon(Icons.camera_alt),
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
                  Container(
                      child:
                      Column(
                        children: [
                          Image.file(image!, width: 250, height: 340, fit: BoxFit.cover),

                          ElevatedButton(
                            child: const Text('Send'),
                            onPressed: () {
                            print("Image has been sent");
                            closeDrawer();
                          }
                          // onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      )
                  )
                      :
                  Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 150),
                          Text("No image selected"),
                        ],
                      )),
                ],
              ),
            );
  }

  void closeDrawer() {
    Navigator.of(context).pop();
  }
}