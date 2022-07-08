
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netcompany_office_tool/comments/comment_box.dart';
import 'package:netcompany_office_tool/comments/comment_list.dart';
import 'package:netcompany_office_tool/constants.dart';
import 'package:netcompany_office_tool/gallery/image_detail.dart';
import 'package:netcompany_office_tool/gallery/photo_grid.dart';
import 'package:netcompany_office_tool/model/report.dart';
import 'package:netcompany_office_tool/model/suggestion.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_screen.dart';




//https://www.youtube.com/watch?v=q_nesGrGzfw
class SuggestionDetailScreen extends StatelessWidget{

  final Suggestion suggestion;
  const SuggestionDetailScreen(this.suggestion, {Key? key}) : super(key: key);

  openGallery(BuildContext context, final int i) => Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => GalleryWidget(
      urlImages: suggestion.imgUrls!,
      index: i,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle:
          const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))), //style: GoogleFonts.ubuntu(textStyle: style)
          backgroundColor: const Color(0xff0f2147),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NavigationScreen(index: suggestionScreen)));
            },
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
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
                                    suggestion.title.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Text(
                                    "Created on " + suggestion.dateCreate.toString() ,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Text(
                                    suggestion.status.toString() + " by admin",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
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
                          suggestion.description.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        PhotoGrid(
                          imageUrls: suggestion.imgUrls!,

                          onImageClicked: (i) {
                            openGallery(context, i);
                          } ,
                          onExpandClicked: (i) {
                            openGallery(context, i);
                          },
                          maxImages: 4,
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommentList(id: suggestion.id!, featureType: "suggestions",)
                      ),
                    ],
                  ),
                ),
              ),
            ),


            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommentBox(id: suggestion.id!, featureType: "suggestions",) /// Note: Add suggestion case
            ),
          ],
        ),
      ),
    );
  }
}