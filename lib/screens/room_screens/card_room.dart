import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/meeting_room.dart';

import 'map_screen.dart';

class CardRoom extends StatefulWidget {
  final MeetingRoom meetingRoom;
  const CardRoom({Key? key, required this.meetingRoom}) : super(key: key);

  @override
  State<CardRoom> createState() => _CardRoomState();
}

class _CardRoomState extends State<CardRoom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        child: Card(
          margin: const EdgeInsets.symmetric( horizontal: 15, vertical: 2),
          color: const Color(0xff0f2147),
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.all(0),
                  decoration:  BoxDecoration(
                    border: Border.all(color: const Color(0xff0f2147)),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                  width: 100,
                  height: 100,
                  child: Center(child: Image.asset(widget.meetingRoom.name=="Ho Chi Minh City" ? "images/presentation-room.png" : "images/meeting-room.png", fit: BoxFit.cover ,width: 50, height: 50,))
              ),

              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(widget.meetingRoom.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                  subtitle: Text("Capacity: " + widget.meetingRoom.capacity.toString() + (widget.meetingRoom.capacity.toString()== "1" ? " seat": " seats"), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16) ),
                  trailing: const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => MapScreen(room: widget.meetingRoom,)
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
