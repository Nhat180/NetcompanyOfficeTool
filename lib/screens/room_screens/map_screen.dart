
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_overlay_map/image_overlay_map.dart';
import 'package:netcompany_office_tool/model/meeting_room.dart';
import 'package:netcompany_office_tool/screens/room_screens/roomlist_screen.dart';
import 'package:photo_view/photo_view.dart';

class MapScreen extends StatefulWidget {

  final MeetingRoom room;
  MapScreen({Key? key, required this.room}) : super(key: key);

  // final List<Facility> _facilityList = [
  //   // Facility(1, "facility1", 0, 0), // center
  //   Facility(2, "Da Lat", "Floor 25", 20, 50),
  //   // Facility(3, "Ha Noi", 20, -200),
  //   // Facility(4, "facility4", 0, -100),
  //   // Facility(5, "facility5", 0, 100),
  // ];

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final String url;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("netcompany"), //style: GoogleFonts.ubuntu(textStyle: style)
          backgroundColor: const Color(0xff0f2147),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const RoomListScreen()));
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            _getWebMap(
                widget.room.floor == "24" ? "https://user-images.githubusercontent.com/68225942/184541064-26d56c92-cfbb-49f0-b0bf-dde519d9bfdc.jpg" :
                widget.room.floor == "25" ?"https://user-images.githubusercontent.com/68225942/184541030-0075bdaa-2263-4a3e-9c89-3226ebb5ceca.jpg" :
                widget.room.floor == "26" ?"https://user-images.githubusercontent.com/68225942/184541650-19ca6103-350e-4680-a583-1db2870bbe7e.jpg" :
                widget.room.floor == "27" ?"https://user-images.githubusercontent.com/68225942/184540916-efcdc2c3-29d8-4652-ba0f-6ec08d9144aa.jpg" :
                "https://user-images.githubusercontent.com/68225942/184540891-1f9b94b6-1a53-48b9-b6dc-59b3cac1f08a.jpg"
            ),
          ],
        ));
  }

  Widget _getWebMap(String url) {
    return FutureBuilder(
        future: _calculateImageDimension(url),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasError) {
              return Center(
                child: Text("error happened when download image"),
              );
            }
            return Center(
              child: MapContainer(
                  new Image(image: CachedNetworkImageProvider(url)),
                  snapShot.data,
                  markers: _getMarker(widget.room, snapShot.data),

                  markerWidgetBuilder: _getMarkerWidget,
                  onTab: _onTab,
                  onMarkerClicked: _onMarkerClicked
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<Size> _calculateImageDimension(String imageUrl) {
    Completer<Size> completer = Completer();
    Image image = new Image(image: CachedNetworkImageProvider(imageUrl));
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  List<MarkerModel> _getMarker(MeetingRoom room, Size size) {
    List<MarkerModel> result = [];

    double dx = size.width / 2 + room.coordinatorX;
    double dy = size.height / 2 - room.coordinatorY;
    result.add(MarkerModel(room, Offset(dx, dy)));
    return result;
  }

  Widget _getMarkerWidget(double scale, MarkerModel data) {

    // Facility facility = data.data;
    MeetingRoom room = data.data;

    return Column(
      children: [
        Bubble(
            alignment: Alignment.center,
            color: const Color.fromARGB(255, 212, 234, 244),
            borderColor: Colors.black,
            borderWidth: 2,
            margin: const BubbleEdges.only(top: 8),
            child:
            Text(room.name,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 15.0)
            )),
        // );
        Icon(Icons.location_on, color: Colors.red),
      ],
    );
  }

  _onMarkerClicked(MarkerModel markerModel) {
    return showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context)
        {
          return SizedBox(
            height: 280,
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Image.network(
                    (markerModel.data as MeetingRoom).imgUrl,
                    fit: BoxFit.cover,height: 280, width: 150,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              PhotoView(
                                imageProvider: NetworkImage((markerModel.data as MeetingRoom).imgUrl),
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((markerModel.data as MeetingRoom).name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            )),
                        const Divider(
                          color: Colors.grey,
                          height: 2,
                          thickness: 2,
                        ),

                        RoomInfo("* Floor: ", (markerModel.data as MeetingRoom).floor.toString()),
                        RoomInfo("* Capacity: ", (markerModel.data as MeetingRoom).capacity.toString()),
                        RoomInfo("* Facility: ", (markerModel.data as MeetingRoom).equipment.join(', ')),


                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }

  _onTab() {
    print("onTab");
    // final lat = latLng.latitude;
    // final long = latLng.longitude;
  }

  void closeDrawer() {
    Navigator.of(context).pop();
  }

  Widget RoomInfo(String title, String data) {
    return
      Align(alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 4.0, left: 4.0, right: 4.0),
            child: Text.rich(
              TextSpan(
                  text: title,
                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  children: <InlineSpan>[
                    TextSpan(
                      text: data,
                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
                    )
                  ]
              ),
            )),
      );
  }
}



