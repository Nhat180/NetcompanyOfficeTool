import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/meeting_room.dart';
import 'package:netcompany_office_tool/screens/room_screens/map_screen.dart';


class RoomListScreen extends StatefulWidget {
  const RoomListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  var roomListByFloor24 = allMeetingRooms.where((room) => room.floor == '24').toList();
  var roomListByFloor25 = allMeetingRooms.where((room) => room.floor == '25').toList();
  var roomListByFloor26 = allMeetingRooms.where((room) => room.floor == '26').toList();
  var roomListByFloor27 = allMeetingRooms.where((room) => room.floor == '27').toList();
  var roomListByFloor31 = allMeetingRooms.where((room) => room.floor == '31').toList();

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

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff0f2147),
          onPressed: () async {
            showSearch(
                context: context,
                delegate: CustomSearchDelegate(hintText: 'Search by room or floor'));
          },
          child: const Icon(Icons.search ),
        ),
        //BUTTON LOCATION
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        body: SingleChildScrollView(
          child: showFloorHeader()
          ),
      )
    );
  }

  Widget showFloorHeader() {
    return Column(
        children: [
          // FloorHeader(isExpand: isExpand1, floorNumber: "Floor 24: VietNam", imageFlag: "images/vietnam.png", getFloorData: getRoomFromFloor24(), onExpandChange: (value) {changingExpand(isExpand1, value);}),

          Padding(
            padding: const EdgeInsets.all(8.0),
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
                        "Floor 24: VietNam",
                        style: isExpand1!=true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize: 18)
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
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.58), child: getRoomFromFloor(roomListByFloor24)),
                  // Container(child: getReportsContainer())

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: (isExpand2!=true) ? Color(0xff0f2147): Colors.white,
                  borderRadius: (isExpand2!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Text(
                        "Floor 25: Denmark",
                        style: isExpand2!=true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    Spacer(),
                    Image.asset("images/denmark.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading:  Icon(Icons.room, color: (isExpand2==true)? Color(0xff0f2147): Colors.white),
                // backgroundColor: Colors.black,
                trailing: (isExpand2==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Colors.white),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand2=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.58), child: getRoomFromFloor(roomListByFloor25)),
                  // Container(child: getReportsContainer())
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: (isExpand3!=true) ? Color(0xff0f2147): Colors.white,
                  borderRadius: (isExpand3!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Text(
                        "Floor 26: Canteen",
                        style: isExpand3!=true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    Spacer(),
                    Image.asset("images/vietnam.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading:  Icon(Icons.room, color: (isExpand3==true)? Color(0xff0f2147): Colors.white),
                // backgroundColor: Colors.black,
                trailing: (isExpand3==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Colors.white),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand3=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.58), child: getRoomFromFloor(roomListByFloor26)),
                  // Container(child: getReportsContainer())

                ],
              ),
            ),
          ),

          Padding(
            padding:const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: (isExpand4!=true) ? Color(0xff0f2147): Colors.white,
                  borderRadius: (isExpand4!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Text(
                        "Floor 27: Norway",
                        style: isExpand4!=true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    Spacer(),
                    Image.asset("images/norway.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading:  Icon(Icons.room, color: (isExpand4==true)? Color(0xff0f2147): Colors.white),
                // backgroundColor: Colors.black,
                trailing: (isExpand4==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Colors.white),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand4=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.58), child: getRoomFromFloor(roomListByFloor27)),
                  // Container(child: getReportsContainer())

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                  color: (isExpand5!=true) ? Color(0xff0f2147): Colors.white,
                  borderRadius: (isExpand5!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Text(
                        "Floor 31: The UK",
                        style: isExpand5!=true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                            :
                        TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    Spacer(),
                    Image.asset("images/united-kingdom.png", fit: BoxFit.cover, width: 50, height: 50,)
                  ],
                ),
                leading:  Icon(Icons.room, color: (isExpand5==true)? Color(0xff0f2147): Colors.white),
                // backgroundColor: Colors.black,
                trailing: (isExpand5==true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Colors.white),
                onExpansionChanged: (value){
                  setState(() {
                    isExpand5=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.58), child: getRoomFromFloor(roomListByFloor31)),
                  // Container(child: getReportsContainer())

                ],
              ),
            ),
          ),
        ],
    );
  }

// https://hanghieugiatot.com/listview-inside-expanded-flutter
  Widget getRoomFromFloor(List<MeetingRoom> roomList) {
    return
      ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          final room = roomList[index];
          return cardRoom(room);
        },
      );
  }

  Widget cardRoom(MeetingRoom room) {
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
                    border: Border.all(color: Color(0xff0f2147)),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                  width: 100,
                  height: 100,
                  child: Center(child: Image.asset(room.name=="Ho Chi Minh City" ? "images/presentation-room.png": "images/meeting-room.png", fit: BoxFit.cover ,width: 50, height: 50,))
              ),

              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(room.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                  subtitle: Text("Capacity: " + room.capacity.toString() + (room.capacity.toString()== "1" ? " seat": " seats"), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16) ),
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
  }
}
//https://stackoverflow.com/questions/50567295/listview-filter-search-in-flutter
// https://www.youtube.com/watch?v=KF1KMfQOpjM
class CustomSearchDelegate extends SearchDelegate{
  var meetingRoom = allMeetingRooms.toList();
  final String? hintText;
  // final TextStyle? textStyle ;
  CustomSearchDelegate({this.hintText});

  // @override
  // TextStyle? get searchFieldStyle => textStyle;
  @override
  String? get searchFieldLabel => hintText;

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => NavigationScreen(index: reportScreen)));
        },);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<MeetingRoom> matchQuery = [];
    for (var room in meetingRoom){
      if (room.name.toLowerCase().contains(query.toLowerCase()) || room.floor.toLowerCase().contains(query) ){
        matchQuery.add(room);
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final result = matchQuery[index];
        return ListTile(
          title: Text(result.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
          subtitle: Text("Capacity " + result.capacity.toString()),
          trailing: Text("Floor " + result.floor, style: const TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
          onTap: () {
            // close(context, null);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MapScreen(room: result)
            ));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MeetingRoom> matchQuery = [];
    for (var room in meetingRoom){
      if (room.name.toLowerCase().contains(query.toLowerCase()) || room.floor.contains(query) ){
        matchQuery.add(room);
      }
    }
    return matchQuery.isNotEmpty ? ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final result = matchQuery[index];
        return ListTile(
          title: Text(result.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
          subtitle: Text("Capacity " + result.capacity.toString()),
          trailing: Text("Floor "+ result.floor, style: const TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
          onTap: () {
            close(context, result);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MapScreen(room: result)
            ));

          },
        );
      },
    )
        :
    Center(
        child: Text("Not Found")
    );

    //   matchQuery.isNotEmpty ? ListView.builder(
    //     itemCount: matchQuery.length,
    //     itemBuilder: (context, index){
    //       var result = matchQuery[index];
    //       return ListTile(
    //         title: Text(result.name),
    //       );
    //     }
    // )
    //     :
    // Text("Not Found");
  }

}