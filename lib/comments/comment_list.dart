
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:netcompany_office_tool/model/comment.dart';


class CommentList extends StatefulWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentListState();
}

class CommentListState extends State<CommentList> {
  var comments = allComments;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
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


              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  //update
                  Text(
                    "Total Comment(10)",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),


                  const SizedBox(height: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () => _animateToIndex(comments.length),
                    child: Row(
                      children: [
                        const Text('Latest'),
                        Icon(Icons.arrow_downward)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 450, // Some height
            child: Stack(
              // mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                  controller: _controller,
                  reverse: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 1),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        color: comment.creator == "admin"
                            ? Colors.grey[300]
                            : Colors.blue[100],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5.0),
                        leading: comment.creator == "admin" ? Image.asset(
                          "images/admin.png", fit: BoxFit.cover,
                          width: 50,
                          height: 50,) :
                        Image.asset(
                          "images/officer.png", fit: BoxFit.cover,
                          width: 50,
                          height: 50,),

                        title: Text(comment.creator),
                        subtitle: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: comment.imgUrl.isNotEmpty ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              PhotoView(
                                                imageProvider: NetworkImage(
                                                    comment.imgUrl),

                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(16),
                                                child: Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    ClipOval(
                                                      child: Material(
                                                        color: Colors.white,
                                                        // Button color
                                                        child: InkWell(
                                                          splashColor: Colors.red,
                                                          // Splash color
                                                          onTap: closeDrawer,
                                                          child: const SizedBox(
                                                              width: 30,
                                                              height: 30,
                                                              child: Icon(
                                                                  Icons.close)),
                                                        ),
                                                      ),
                                                    ),

                                                    const Text(''),
                                                    const Text(''),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                    ));
                                  },

                                  child: Container(
                                    height: 180,
                                    width: 150,
                                    // child: Image.asset("images/paper.png", fit: BoxFit.fill),
                                    child: Image.network(
                                        comment.imgUrl, fit: BoxFit.cover),
                                  ),
                                ),
                                // Image.asset("images/paper.png", fit: BoxFit.fitHeight),
                              ],
                            ) :
                            Container(
                                child: Text(comment.cmt))
                        ),
                      ),

                    );
                  },
                ),


                //     ListView.builder(
                //         reverse: false,
                //         shrinkWrap: true,
                //         padding: EdgeInsets.only(top: 1.0),
                //         itemCount: comments.length,
                //         itemBuilder: (BuildContext context, int index) {
                //         return Container(
                //             margin:EdgeInsets.only(
                //               top: 8.0,
                //               bottom: 8.0,
                //               left: 1.0,
                //             ),
                //         padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 15.0),
                //         width: MediaQuery.of(context).size.width * 0.75,
                //           decoration: BoxDecoration(
                //             color: Color(0xFFFFEFEE),
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(15.0),
                //               bottomLeft: Radius.circular(15.0),
                //             )
                //           ),
                //         child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //           comments[index],
                //           style: TextStyle(
                //           color: Colors.blueGrey,
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //         ],
                //         ),
                //         );}
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void closeDrawer() {
    Navigator.of(context).pop();
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * 500,
      duration: Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }
}