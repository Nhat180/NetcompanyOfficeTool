
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/comments/comment_box.dart';
import 'package:netcompany_office_tool/comments/comment_list.dart';
import 'package:netcompany_office_tool/gallery/image_detail.dart';
import 'package:netcompany_office_tool/gallery/photo_grid.dart';
import 'package:netcompany_office_tool/model/report.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_screen.dart';


var urls = <String>[
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  'https://images.unsplash.com/photo-1542998967-692be9110b46?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1550496913-b1a19c3779e9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  'https://ggsc.s3.amazonaws.com/images/uploads/The_Science-Backed_Benefits_of_Being_a_Dog_Owner.jpg',
  'https://images.unsplash.com/photo-1521320226546-87b106956014?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"',
  'https://images.unsplash.com/photo-1483412919093-03a22057d0d7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
];


//https://www.youtube.com/watch?v=q_nesGrGzfw
class ReportDetailScreen extends StatelessWidget{

  final Report report;
  const ReportDetailScreen(this.report, {Key? key}) : super(key: key);

  openGallery(BuildContext context, final int i) => Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => GalleryWidget(
      urlImages: urls,
      index: i,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("netcompany"), //style: GoogleFonts.ubuntu(textStyle: style)
          backgroundColor: const Color(0xff0f2147),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ReportScreen()));
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
                                    report.title.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Text(
                                    "On " + report.dateCreate.toString() ,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Text(
                                    report.status.toString() + " by admin",
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
                          report.description.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        PhotoGrid(
                          imageUrls: urls,

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
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide( //                    <--- top side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide( //                    <--- top side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("Comment(" + report.totalCom.toString() + ")",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,),
                          ),
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommentList()
                      ),
                    ],
                  ),
                ),
              ),
            ),


            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommentBox()
            ),
          ],
        ),
      ),
    );
  }
}