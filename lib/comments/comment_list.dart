

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:netcompany_office_tool/model/comment.dart';


class CommentList extends StatefulWidget {
  final String id;
  final String featureType;

  const CommentList({Key? key, required this.id, required this.featureType}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentListState();
}

class CommentListState extends State<CommentList> {
  final FirebaseService firebaseService = FirebaseService();
  int? totalComment;

  // var comments = allComments;
  List<Comment> comments = [];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getTotalComment();
  }

  void getTotalComment() async {
    totalComment = await firebaseService.getTotalComment(widget.id, widget.featureType);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return (totalComment == null) ? Center(child: const CircularProgressIndicator(),) :
    Center(
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
                    bottom: BorderSide( //                  <--- bottom side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //update
                  Text(
                    "Total Comment (" + totalComment!.toString() + ")",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () => _animateToIndex(comments.length),
                    child: Row(
                      children: const [
                        Text('Latest'),
                        Icon(Icons.arrow_downward)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection(widget.featureType)
                  .doc(widget.id).collection("comments").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Text('Something went wrong');

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No comments yet.", style: TextStyle(fontSize: 16),),);
                  } else {
                    if (comments.isEmpty) {
                      for(int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        comments.add(Comment(
                            id: snap.id,
                            creator: snap["creator"],
                            type: snap["type"],
                            text: snap["text"],
                            imgUrl: snap["imgUrl"]));
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          if (totalComment! == 0) {
                            setState(() {
                              totalComment = totalComment! + 1;
                            });
                          }
                        });
                      }
                    } else if (comments.isNotEmpty && comments.length < snapshot.data!.docs.length){
                      DocumentSnapshot snap = snapshot.data!.docs[snapshot.data!.docs.length - 1];
                      comments.add(Comment(
                          id: snap.id,
                          creator: snap["creator"],
                          type: snap["type"],
                          text: snap["text"],
                          imgUrl: snap["imgUrl"]));
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        setState(() {
                          totalComment = totalComment! + 1;
                        });
                      });
                    }
                    return Stack(
                      children: [
                        ListView.builder(
                          controller: _controller,
                          reverse: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 1),
                          itemCount: comments.length,
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                                borderRadius: const BorderRadius.only(
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

                                title: Text(comment.creator!),
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

                                          child: SizedBox(
                                            height: 180,
                                            width: 150,
                                            child: Image.network(
                                                comment.imgUrl, fit: BoxFit.cover),
                                          ),
                                        ),
                                        // Image.asset("images/paper.png", fit: BoxFit.fitHeight),
                                      ],
                                    ) :
                                    Text(comment.text)
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                }
              }
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
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }
}