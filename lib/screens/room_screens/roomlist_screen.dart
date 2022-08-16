import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/meeting_room.dart';
import 'package:netcompany_office_tool/screens/room_screens/map_screen.dart';


class RoomListScreen extends StatefulWidget {
  const RoomListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  var roomListByFloor24 = allMeetingRooms.where((room) => room.floor == 'Floor 24').toList();
  var roomListByFloor25 = allMeetingRooms.where((room) => room.floor == 'Floor 25').toList();
  var roomListByFloor26 = allMeetingRooms.where((room) => room.floor == 'Floor 26').toList();
  var roomListByFloor27 = allMeetingRooms.where((room) => room.floor == 'Floor 27').toList();
  var roomListByFloor31 = allMeetingRooms.where((room) => room.floor == 'Floor 31').toList();

  TextEditingController controller = new TextEditingController();
  var meetingRoom = allMeetingRooms.toList();
  bool isExpand1=false;
  bool isExpand2=false;
  bool isExpand3=false;
  bool isExpand4=false;
  bool isExpand5=false;
  @override
  void initState() {
// TODO: implement initState
    super.initState();
    isExpand1=false;
    isExpand2=false;
    isExpand3=false;
    isExpand4=false;
    isExpand5=false;
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: Column(
            children: [

              // https://stackoverflow.com/questions/50567295/listview-filter-search-in-flutter
              Container(
                color: Color(0xff0f2147),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        // onChanged: onSearchTextChanged,
                      ),
                      trailing: IconButton(icon: Icon(Icons.cancel), onPressed: () {
                        controller.clear();
                        // onSearchTextChanged('');
                      },),
                    ),
                  ),
                ),
              ),
              controller.text.isEmpty
                  ?
              RoomWithHeader()
                  :
              getSearchFloor(),

            ],
          ),
        ),
      ),
      // const ListWidget()
    );
  }


  Widget RoomWithHeader() {
    return SingleChildScrollView(
      child: Column(
        children: [

          // floor 24
          Padding(
            padding: (isExpand1==true)?const EdgeInsets.all(8.0):const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: (isExpand1!=true) ? Color(0xff0f2147): Colors.white,
                  borderRadius: (isExpand1!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                // initiallyExpanded: false,
                title: Row(
                  children: [
                    Text(
                        "Floor 24: Vietnam",
                        style: isExpand1!=true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize:20)
                    ),
                    Spacer(),
                    Image.asset("images/vietnam.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading:  Icon(Icons.room, color: (isExpand1==true)? Color(0xff0f2147): Colors.white),
                // backgroundColor: Colors.black,
                trailing: (isExpand1==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Colors.white),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand1=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.70), child: getRoomFromFloor24()),
                  // Container(child: getReportsContainer())

                ],
              ),
            ),
          ),

          Padding(
            padding: (isExpand2==true)?const EdgeInsets.all(8.0):const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: (isExpand2!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                // initiallyExpanded: false,
                title: Row(
                  children: [
                    Text(
                        "Floor 25: Denmark",
                        style: isExpand2!=true ?TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( fontWeight: FontWeight.bold, fontSize:20)
                    ),
                    Spacer(),
                    Image.asset("images/denmark.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading: Icon(Icons.room),
                backgroundColor: Colors.white,
                trailing: (isExpand2==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Color(0xff0f2147)),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand2=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.70), child: getRoomFromFloor25()),
                  // Container(child: getReportsContainer())
                ],
              ),
            ),
          ),

          Padding(
            padding: (isExpand3==true)?const EdgeInsets.all(8.0):const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: (isExpand3!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                // initiallyExpanded: false,
                title: Row(
                  children: [
                    Text(
                        "Floor 26: Canteen",
                        style: isExpand3!=true ?TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( fontWeight: FontWeight.bold, fontSize:20)
                    ),
                    Spacer(),
                    Image.asset("images/vietnam.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading: Icon(Icons.room),
                backgroundColor: Colors.white,
                trailing: (isExpand3==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Color(0xff0f2147)),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand3=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.70), child: getRoomFromFloor26()),
                  // Container(child: getReportsContainer())
                ],
              ),
            ),
          ),

          Padding(
            padding: (isExpand4==true)?const EdgeInsets.all(8.0):const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: (isExpand4!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                // initiallyExpanded: false,
                title: Row(
                  children: [
                    Text(
                        "Floor 27: Norway",
                        style: isExpand4!=true ?TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( fontWeight: FontWeight.bold, fontSize:20)
                    ),
                    Spacer(),
                    Image.asset("images/norway.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading: Icon(Icons.room),
                backgroundColor: Colors.white,
                trailing: (isExpand4==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Color(0xff0f2147)),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand4=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.70), child: getRoomFromFloor27()),
                  // Container(child: getReportsContainer())
                ],
              ),
            ),
          ),

          Padding(
            padding: (isExpand5==true)?const EdgeInsets.all(8.0):const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: (isExpand5!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                // initiallyExpanded: false,
                title: Row(
                  children: [
                    Text(
                        "Floor 31: The UK",
                        style: isExpand5!=true ?TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( fontWeight: FontWeight.bold, fontSize:20)
                    ),
                    Spacer(),
                    Image.asset("images/united-kingdom.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading: Icon(Icons.room),
                backgroundColor: Colors.white,
                trailing: (isExpand5==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Color(0xff0f2147)),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand5=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.70), child: getRoomFromFloor31()),
                  // Container(child: getReportsContainer())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// https://hanghieugiatot.com/listview-inside-expanded-flutter
  Widget getRoomFromFloor24() {
    return
      ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        itemCount: roomListByFloor24.length,
        itemBuilder: (context, index) {
          final room = roomListByFloor24[index];
          return Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              child: Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric( horizontal: 15, vertical: 2),
                color: Color(0xff0f2147),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(0),
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Center(child: Image.asset("images/meeting-room.png", fit: BoxFit.cover ,width: 50, height: 50,))
                    ),

                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(room.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                        subtitle: Text("Capacity " + room.capacity.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        trailing: Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => MapScreen(room: room,)
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
  }

  Widget getRoomFromFloor25() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: roomListByFloor25.length,
      itemBuilder: (context, index) {
        final room = roomListByFloor25[index];
        return
          Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              child: Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric( horizontal: 10, vertical: 2),
                color: Colors.blue.shade100,
                child: Row(
                  children: [
                    Container(
                        decoration:  BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Center(child: Image.asset("images/meeting-room.png", fit: BoxFit.cover ,width: 50, height: 50,))
                    ),

                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                        subtitle: Text("Capacity " + room.capacity.toString()),
                        trailing: Icon(
                            Icons.map
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => MapScreen(room: room,)
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

  Widget getRoomFromFloor26() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: roomListByFloor26.length,
      itemBuilder: (context, index) {
        final room = roomListByFloor26[index];
        return
          Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(

              child: Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric( horizontal: 10, vertical: 2),

                color: Colors.blue.shade100,
                child: Row(
                  children: [
                    Container(
                        decoration:  BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Center(child: Image.asset("images/meeting-room.png", fit: BoxFit.cover ,width: 50, height: 50,))
                    ),

                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                        subtitle: Text("Capacity " + room.capacity.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.map),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => MapScreen(room: room,)
                            ));
                          },
                        ),
                        // onTap: () {
                        //   Navigator.pushReplacement(context, MaterialPageRoute(
                        //       builder: (context) => MapRoom(room: room,)
                        //   ));
                        // },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

  Widget getRoomFromFloor27() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: roomListByFloor27.length,
      itemBuilder: (context, index) {
        final room = roomListByFloor27[index];
        return
          Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(

              child: Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric( horizontal: 10, vertical: 2),

                color: Colors.blue.shade100,
                child: Row(
                  children: [
                    Container(
                        decoration:  BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Center(child: Image.asset("images/meeting-room.png", fit: BoxFit.cover ,width: 50, height: 50,))
                    ),

                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                        subtitle: Text("Capacity " + room.capacity.toString()),
                        trailing: Icon(
                            Icons.map
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => MapScreen(room: room,)
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

  Widget getRoomFromFloor31() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: roomListByFloor31.length,
      itemBuilder: (context, index) {
        final room = roomListByFloor31[index];
        return
          Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(

              child: Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric( horizontal: 10, vertical: 2),
                color: Colors.blue.shade100,
                child: Row(
                  children: [
                    Container(
                        decoration:  BoxDecoration(
                          color: Colors.blue.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Center(child: Image.asset("images/meeting-room.png", fit: BoxFit.cover ,width: 50, height: 50,))
                    ),

                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                        subtitle: Text("Capacity " + room.capacity.toString()),
                        trailing: Icon(
                            Icons.map
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => MapScreen(room: room,)
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

  Widget getSearchFloor() {
    return
      SizedBox (
        height: MediaQuery.of(context).size.height*0.8,
        child: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10),
          itemCount: meetingRoom.length,
          itemBuilder: (context, index) {
            final room = meetingRoom[index];
            return ListTile(
              // contentPadding: const EdgeInsets.all(10.0),
              // leading:
              // Image.asset("images/meeting-room.png", fit: BoxFit.cover, width: 50, height: 50,),
              title: Text(room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
              subtitle: Text("Capacity " + room.capacity.toString()),
              trailing: Text(room.floor, style: const TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
              onTap: () {
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //     builder: (context) => ReportDetailScreen(report)
                // ));
              },
            );
          },
        ),

      );
  }


}