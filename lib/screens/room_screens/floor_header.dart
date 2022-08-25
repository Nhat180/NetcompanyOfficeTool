import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/screens/room_screens/card_room.dart';

import '../../model/meeting_room.dart';
import 'map_screen.dart';

class FloorHeader extends StatefulWidget {
  const FloorHeader({Key? key}) : super(key: key);

  @override
  State<FloorHeader> createState() => _FloorHeaderState();
}

class _FloorHeaderState extends State<FloorHeader> {
  var roomListByFloor24 = allMeetingRooms.where((room) => room.floor == '24').toList();
  var roomListByFloor25 = allMeetingRooms.where((room) => room.floor == '25').toList();
  var roomListByFloor26 = allMeetingRooms.where((room) => room.floor == '26').toList();
  var roomListByFloor27 = allMeetingRooms.where((room) => room.floor == '27').toList();
  var roomListByFloor31 = allMeetingRooms.where((room) => room.floor == '31').toList();

  TextEditingController controller = TextEditingController();
  bool isExpandFloor24=false;
  bool isExpandFloor25=false;
  bool isExpandFloor26=false;
  bool isExpandFloor27=false;
  bool isExpandFloor31=false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    isExpandFloor24=false;
    isExpandFloor25=false;
    isExpandFloor26=false;
    isExpandFloor27=false;
    isExpandFloor31=false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showFloorHeader(isExpandFloor24, roomListByFloor24, "Floor 24: VietNam", "images/vietnam.png"),
        showFloorHeader(isExpandFloor25, roomListByFloor25, "Floor 25: Denmark", "images/denmark.png"),
        showFloorHeader(isExpandFloor26, roomListByFloor26, "Floor 26: Canteen", "images/vietnam.png"),
        showFloorHeader(isExpandFloor27, roomListByFloor27, "Floor 27: Norway", "images/norway.png"),
        showFloorHeader(isExpandFloor31, roomListByFloor31, "Floor 31: The UK", "images/united-kingdom.png")
      ],
    );
  }

  Widget showFloorHeader(bool isExpand, List<MeetingRoom> roomList, String floorName, String floorCountry) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:BoxDecoration(
            color: (isExpand!=true) ? const Color(0xff0f2147): Colors.white,
            borderRadius: (isExpand!=true)? const BorderRadius.all(Radius.circular(8)) : const BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: const Color(0xff0f2147))
        ),
        child: ExpansionTile(
          title: Row(
            children: [
              Text(
                  floorName,
                  style: isExpand != true ? const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                      :
                  const TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize: 18)
              ),
              const Spacer(),
              Image.asset(floorCountry, fit: BoxFit.cover, width: 50, height: 50,)
            ],
          ),
          leading:  Icon(Icons.room, color: (isExpand==true)? const Color(0xff0f2147) : Colors.white),
          // backgroundColor: Colors.black,
          trailing: (isExpand==true)? const Icon(Icons.arrow_drop_down, size: 32, color: Color(0xff0f2147),) : const Icon(Icons.arrow_drop_up, size: 32, color: Colors.white),
          onExpansionChanged: (value){
            setState(() {
              if (floorName == "Floor 24: VietNam") {
                isExpandFloor24 = value;
              } else if (floorName == "Floor 25: Denmark") {
                isExpandFloor25 = value;
              } else if (floorName == "Floor 26: Canteen") {
                isExpandFloor26 = value;
              } else if (floorName == "Floor 27: Norway") {
                isExpandFloor27 = value;
              } else {
                isExpandFloor31 = value;
              }
            });
          },
          children: [
            ConstrainedBox (
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height*0.58
                ),
                child: getRoomFromFloor(roomList)),
            // Container(child: getReportsContainer())
          ],
        ),
      ),
    );
  }

  Widget getRoomFromFloor(List<MeetingRoom> roomList) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: roomList.length,
      itemBuilder: (context, index) {
        final room = roomList[index];
        return CardRoom(meetingRoom: room);
        },
    );
  }
}
