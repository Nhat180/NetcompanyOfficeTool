import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/screens/room_screens/floor_header.dart';
import 'package:netcompany_office_tool/screens/room_screens/search_room.dart';


class RoomListScreen extends StatefulWidget {
  const RoomListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  @override
  void initState() {
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff0f2147),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const SearchRoom()
            ));
          },
          child: const Icon(Icons.search ),
        ),
        //BUTTON LOCATION
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        body: const SingleChildScrollView(
          child: FloorHeader()
          ),
      )
    );
  }
}