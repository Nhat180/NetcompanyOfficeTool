import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:netcompany_office_tool/screens/home_screen.dart';
import 'package:netcompany_office_tool/screens/login_screen.dart';
import 'package:netcompany_office_tool/screens/report_screen.dart';
import 'package:netcompany_office_tool/screens/suggestion_screen.dart';
import 'package:netcompany_office_tool/screens/surveylist_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

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
  Choice(title: 'Profile', icon: Icons.account_circle),
];

class InitState extends  State<NavigationScreen>{
  int _currentIndex = 0;
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  final _currentScreen = [
    HomeScreen(),
    ReportScreen(),
    SuggestionScreen(),
    SurveyListScreen()
  ];



  @override
  Widget build(BuildContext context) {
    var _platform = Theme.of(context).platform;
    return _platform == TargetPlatform.iOS ? iOSNav() : androidNav();
  }


  Widget androidNav() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    _currentIndex = index;
                  }
                });
              },
            ),
          ),
          body: _currentScreen[_currentIndex],
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
      body: _currentScreen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
              icon: Icon(Icons.account_circle),
              label: 'Profile',
              backgroundColor: Color(0xff0f2147)
          ),
        ],
        onTap: (index) {
          setState(() {
            if (index == 4) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else {
              _currentIndex = index;
            }
          });
        },
      ),
    );
  }
}
