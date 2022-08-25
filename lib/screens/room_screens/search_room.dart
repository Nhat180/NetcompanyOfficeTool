import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/meeting_room.dart';
import 'package:netcompany_office_tool/screens/room_screens/map_screen.dart';

import '../../constants.dart';
import '../navigation_screen.dart';


class SearchRoom extends StatefulWidget {
  const SearchRoom({Key? key}) : super(key: key);

  @override
  SearchRoomState createState() => new SearchRoomState();
}

class SearchRoomState extends State<SearchRoom> {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  var meetingRoom = allMeetingRooms;
  List<MeetingRoom> _searchResult = [];
  bool disableSearch = false;
  TextEditingController controller = new TextEditingController();


  @override
  void initState() {
    super.initState();

  }

  Widget _buildRoomsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: meetingRoom.length,
      itemBuilder: (context, index) {
        final room = meetingRoom[index];
        return Card(
          child: ListTile(
            // ListTile(
            title: Text(room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
            subtitle: Text("Capacity " + room.capacity.toString()),
            trailing: Text("Floor " + room.floor, style: const TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
            onTap: () {
              // close(context, null);
              setState(() {
                disableSearch = true;
              });
              FocusManager.instance.primaryFocus?.unfocus();
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => MapScreen(room: room)
                ));
              });
            },
            // title: new Text(
            //     _searchResult[i].name),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return _searchResult.isNotEmpty ? ListView.builder(
      shrinkWrap: true,
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        final result = _searchResult[i];
        return Card(
          child: ListTile(
            title: Text(result.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
            subtitle: Text("Capacity " + result.capacity.toString()),
            trailing: Text("Floor " + result.floor, style: const TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
            onTap: () async {
            // close(context, null);
              setState(() {
                disableSearch = true;
              });
              FocusManager.instance.primaryFocus?.unfocus();
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => MapScreen(room: result)
                ));
              });

          },
            // title: new Text(
            //     _searchResult[i].name),
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    ):
    Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search_off,
              size: 100,
              color: Colors.blue,
            ),
            Text(('No Room Found'),
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))
          ],
        ));
  }

  Widget _buildSearchBox() {
    return AbsorbPointer(
      absorbing: disableSearch,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      )
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
            color: const Color(0xff0f2147), child: _buildSearchBox()),
        Expanded(
            child: _searchResult.isNotEmpty || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildRoomsList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
        backgroundColor: const Color(0xff0f2147),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NavigationScreen(index: findRoomScreen,)));
          },
        ),
      ),
      body: _buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var room in meetingRoom) {
      if (room.name.toLowerCase().contains(text.toLowerCase()) || room.floor.contains(text)) {
        _searchResult.add(room);
      }
    }
    setState(() {});
  }
}