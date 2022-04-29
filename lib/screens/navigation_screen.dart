import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:netcompany_office_tool/screens/home_screen.dart';
import 'package:netcompany_office_tool/screens/login_screen.dart';
import 'package:netcompany_office_tool/screens/report_screen.dart';
import 'package:netcompany_office_tool/screens/suggestion_screen.dart';
import 'package:netcompany_office_tool/screens/surveylist_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends  State<NavigationScreen>{
  int _currentIndex = 0;

  final _currentScreen = [
    HomeScreen(),
    ReportScreen(),
    SuggestionScreen(),
    SurveyListScreen()
  ];

  // var platform;

  @override
  Widget build(BuildContext context) {
    // platform = Theme.of(context).platform;
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Netcompany Office Tool"),
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
