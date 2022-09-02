import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netcompany_office_tool/dialog/privacy_dialog.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';
import '../../dialog/logout_dialog.dart';
import 'profile_list_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}


class ProfileScreenState extends State<ProfileScreen> {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final StorageService storageService = StorageService();
  String? name;

  void getUserName() async {
    name = await storageService.readSecureData('name');
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const AvatarImage(),
          const SizedBox(height: 15),
          Text(
            (name == null) ? 'Loading...' : name!,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins"),
          ),

          // const SizedBox(height: 15),
          // const Text(
          //   'netcompany staff',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
          // ),
          const SizedBox(height: 30,),
          const ProfileListItems(),
        ],
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  const AvatarImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xff0f2147),
          ],
        ),
        color: Colors.white
      ),
      height: 200,
      padding: const EdgeInsets.all(15),
      // decoration: avatarDecoration,
      child: Container(
        // decoration: avatarDecoration,
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blueGrey, width: 5),
            image: const DecorationImage(
              image: AssetImage('images/user.png'),
              scale: 0.5,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({Key? key}) : super(key: key);

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
                  return const PrivacyDialog();
                },
              );
            }
          ),

          ProfileListItem(
            icon: Icons.logout,
            text: 'Sign out',
            hasNavigation: false,
              onClickedListener: () =>
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return const LogoutDialog();
                      })
          ),
        ],
      ),
    );
  }
}

