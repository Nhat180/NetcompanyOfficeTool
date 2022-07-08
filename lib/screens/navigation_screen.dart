import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:netcompany_office_tool/dialog/logout_dialog.dart';
import 'package:netcompany_office_tool/loading/crawl_spinner.dart';
import 'package:netcompany_office_tool/screens/home_screen.dart';
import 'package:netcompany_office_tool/screens/landscape_mode.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_screen.dart';
import 'package:netcompany_office_tool/screens/suggestion_screens/suggestion_screen.dart';
import 'package:netcompany_office_tool/screens/error_access_screen.dart';
import 'package:netcompany_office_tool/screens/survey_screens/surveylist_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/httphandler_service.dart';
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
  final StorageService storageService = StorageService();
  final HttpHandlerService handlerService = HttpHandlerService();
  final FirebaseService firebaseService = FirebaseService();
  bool isCrawlAuthenticate = true;
  bool loadingCrawl = false;
  int _currentIndex = 0;
  bool check = false;
  bool checkCrawl = true;
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


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
    _currentIndex = widget.index;
    if (_currentIndex == 0) {
      requestCrawlService();
    }
  }

  void requestCrawlService() async {
    loadingCrawl = true;
    DateTime currentTime = DateTime.now();
    DateTime updateTime = await firebaseService.getCrawlTimeStamp();
    if(currentTime.isAfter(updateTime) || currentTime.isAtSameMomentAs(updateTime)) {
      String? name = await storageService.readSecureData('name');
      String? password = await storageService.readSecureData('password');
      final bool response =  await handlerService.crawl(name!, password!);
      if (response) {
        setState(() {
          loadingCrawl = false;
        });
      } else {
        setState(() {
          isCrawlAuthenticate = response;
          loadingCrawl = false;
        });
      }
    } else {
      setState(() {
        loadingCrawl = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var _platform = Theme.of(context).platform;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      if (loadingCrawl) {
        return const CrawlSpinner();
      } else {
        return _platform == TargetPlatform.iOS ? iOSNav() : androidNav();
      }
    } else {
      return const LandScape();
    }
  }


  Widget androidNav() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: _currentIndex,
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
            backgroundColor: const Color(0xff0f2147),
            bottom: TabBar(
              indicatorColor: Colors.transparent,
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
                    showDialog(context: context,
                        builder: (BuildContext context) {
                          return LogoutDialog(index: _currentIndex,);
                        });
                  }
                  else {
                    _currentIndex = index;
                    if (_currentIndex == 0) {
                      requestCrawlService();
                    }
                    setState(() {
                      isCrawlAuthenticate = true;
                    });
                  }
                });
              },
            ),
          ),
          body: (!isCrawlAuthenticate) ? ErrorAccessScreen()
              : _currentScreen[_currentIndex],
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
      body: (!isCrawlAuthenticate) ? ErrorAccessScreen()
          : _currentScreen[_currentIndex],
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
              icon: Icon(Icons.logout),
              label: 'Logout',
              backgroundColor: Color(0xff0f2147)
          ),
        ],
        onTap: (index) {
          setState(() {
            if (index == 4) {
              showDialog(context: context,
                  builder: (BuildContext context) {
                    return LogoutDialog(index: _currentIndex,);
                  });
            } else {
              _currentIndex = index;
              if (_currentIndex == 0) {
                requestCrawlService();
              }
              setState(() {
                isCrawlAuthenticate = true;
              });
            }
          });
        },
      ),
    );
  }
}
