import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netcompany_office_tool/model/reports.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';

// Declare model
class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  // ignore: use_key_in_widget_constructors
  const PhotoGrid(
      {required this.imageUrls,
        required this.onImageClicked,
        required this.onExpandClicked,
        this.maxImages = 4,
      });

  @override
  createState() => _PhotoGridState();
}
var urls = <String>[
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  'https://images.unsplash.com/photo-1542998967-692be9110b46?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1550496913-b1a19c3779e9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  'https://ggsc.s3.amazonaws.com/images/uploads/The_Science-Backed_Benefits_of_Being_a_Dog_Owner.jpg',
  'https://images.unsplash.com/photo-1521320226546-87b106956014?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"',
  'https://images.unsplash.com/photo-1483412919093-03a22057d0d7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
];

// Build Widget
class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    // check length of list report image
    if(urls.isEmpty) {
      // if no, nothing
      return const SizedBox(
          );
    }
    //if one, display single image
    else if (urls.length == 1) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
              urls.first,
              fit: BoxFit.cover, alignment: Alignment.center)
      );
    }
    // display max 4 image and shortcut the remaining image
    else {
      return GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        children: images,
      );
    }
  }
  // build image widget
  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(imageUrl, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: const TextStyle(color: Colors.white ,fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}

//https://www.youtube.com/watch?v=q_nesGrGzfw
class ReportDetailScreen extends StatelessWidget{
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final Report report;
  const ReportDetailScreen(this.report, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
          backgroundColor: const Color(0xff0f2147),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const NavigationScreen(index: 1,)));
            },
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset("images/report.png",
                    height: 60, width: 60,),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          report.title.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          "On " + report.dateCreate.toString() ,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          report.status.toString() + " by admin",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),

                    ],
                  ),
            ),
                ],
              ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 5.0),

                  child: Text(
                    report.description.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhotoGrid(
                    imageUrls: urls,
                    onImageClicked: (i) => print('Image $i was clicked!'),
                    onExpandClicked: () => print('Expand Image was clicked'),
                    maxImages: 4,
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff0f2147), // background
                      onPrimary: Colors.white, // foreground
                    ),

                    onPressed: (){
                      // Navigator.pushReplacement(context, MaterialPageRoute(
                      //     builder: (context) => CommentPage()
                      // ));
                    },
                    child: Text("Total Comment ( " + report.totalCom.toString() + " )", style: TextStyle(fontSize: 20)
                    ),
                  ),
                ),

              ],
            ),
          ),
          
        ),
      ),
    );
  }
}