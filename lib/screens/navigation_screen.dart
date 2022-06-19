import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:netcompany_office_tool/screens/home_screen.dart';
import 'package:netcompany_office_tool/screens/landscape_mode.dart';
import 'package:netcompany_office_tool/screens/login_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_screen.dart';
import 'package:netcompany_office_tool/screens/suggestion_screen.dart';
import 'package:netcompany_office_tool/screens/surveylist_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';

class NavigationScreen extends StatefulWidget {
  final int index;

  const NavigationScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class Choice {
  final String title;
  final IconData icon;
  const Choice({required this.title, required this.icon});
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Home', icon: Icons.home),
  Choice(title: 'Report', icon: Icons.campaign),
  Choice(title: 'Suggest', icon: Icons.chat),
  Choice(title: 'Survey', icon: Icons.content_paste_rounded),
  Choice(title: 'Logout', icon: Icons.logout),
];

class InitState extends  State<NavigationScreen>{
  String docDate = '';
  int _currentIndex = 0;
  String? name;
  bool check = false;
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final StorageService storageService = StorageService();


  final _currentScreen = [
    HomeScreen(),
    ReportScreen(),
    SuggestionScreen(),
    SurveyListScreen()
  ];


  @override
  void initState()  {
    super.initState();
    DateTime dateTime = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(dateTime);
    // ignore: avoid_print
    print(dateFormat);
    getName();
  }

  void getName() async {
    name = await storageService.readSecureData("name");
    // ignore: avoid_print
    print(name);
  }


  @override
  Widget build(BuildContext context) {
    var _platform = Theme.of(context).platform;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return _platform == TargetPlatform.iOS ? iOSNav() : androidNav();
    } else {
      return const LandScape();
    }
  }


  Widget androidNav() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: widget.index,
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
            backgroundColor: const Color(0xff0f2147),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map<Widget>((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
              onTap: (index) {
                setState(() {
                  if (index == 4) {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    _currentIndex = index;
                    setState(() {
                      check = true;
                    });
                  }
                });
              },
            ),
          ),
          body: (!check) ? _currentScreen[widget.index] : _currentScreen[_currentIndex],
        ),
      ),
    );
  }


  Widget iOSNav(){
    return Scaffold(
      appBar: AppBar(
        title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
        backgroundColor: const Color(0xff0f2147),
      ),
      body: (!check) ? _currentScreen[widget.index] : _currentScreen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xff0f2147)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.campaign),
              label: 'Report',
              backgroundColor: Color(0xff0f2147)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Suggest',
              backgroundColor: Color(0xff0f2147)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_rounded),
              label: 'Survey',
              backgroundColor: Color(0xff0f2147)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
              backgroundColor: Color(0xff0f2147)
          ),
        ],
        onTap: (index) {
          setState(() {
            if (index == 4) {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else {
              _currentIndex = index;
              setState(() {
                check = true;
              });
            }
          });
        },
      ),
    );
  }
}
