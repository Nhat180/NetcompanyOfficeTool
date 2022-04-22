import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends  State<HomeScreen>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      body: Container(),
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
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
