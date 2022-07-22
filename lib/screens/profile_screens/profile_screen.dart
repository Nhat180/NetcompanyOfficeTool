import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/screens/profile_screens/privacy_dialog.dart';
import 'profile_list_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}



class ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("netcompany"),
        backgroundColor: const Color(0xff0f2147),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => GridSearchScreen()));
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.all(25),
          //   child:
            Column(
              children: <Widget>[
                AvatarImage(),

                SizedBox(height: 15),
                Text(
                  'pct',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins"),
                ),

                SizedBox(height: 15),
                Text(
                  'Netcompany Staff',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                ),
                SizedBox(height: 30,),
                ProfileListItems(),
              ],
            ),
        ],
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
      gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white,
        Color(0xff0f2147),
        // Colors.blue,
      ],
      ),
      ),
      height: 200,
      padding: EdgeInsets.all(8),
      // decoration: avatarDecoration,
      child: Container(
        // decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/admin.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ProfileListItem(
            icon: Icons.shield,
            text: 'Privacy',
            hasNavigation: true,
            onClickedListener: () {
              showDialog(
                context: context,
                builder: (context) {
                  return PrivacyDialog();
                },
              );
            }
          ),

          ProfileListItem(
            icon: Icons.logout,
            text: 'Logout',
            hasNavigation: false,
              onClickedListener: () => print("Logout")
          ),
        ],
      ),
    );
  }
}

