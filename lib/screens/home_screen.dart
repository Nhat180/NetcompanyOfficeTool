import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/loading/crawl_spinner.dart';
import 'package:netcompany_office_tool/screens/closedmenu_screen.dart';
import 'package:netcompany_office_tool/screens/weeklylunch_screen.dart';
import 'package:intl/intl.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/httphandler_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';
import 'package:sizer/sizer.dart';

import 'login_screen.dart';

class HomeScreen  extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}




class _State extends State<HomeScreen> {
  final StorageService storageService = StorageService();
  final HttpHandlerService handlerService = HttpHandlerService();
  final FirebaseService firebaseService = FirebaseService();
  DateTime currentTime = DateTime.now();
  String docDate = '';
  bool isCrawlAuthenticate = true;
  bool loadingCrawl = false;
  List<String> mainDish = [];
  List<String> sideDish = [];
  List<String> soup = [];
  List<String> dessert = [];


  void convertDateToAbbrev(String dateFormat) {
    if (dateFormat == 'Monday') {
      docDate = 'mon';
    } else if (dateFormat == 'Tuesday') {
      docDate = 'tue';
    } else if (dateFormat == 'Wednesday') {
      docDate = 'wed';
    } else if (dateFormat == 'Thursday') {
      docDate = 'thu';
    } else if (dateFormat == 'Friday') {
      docDate = 'fri';
    } else {
      docDate = 'wkd';
    }
  }

  void requestCrawlService() async {
    loadingCrawl = true;
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
  void initState() {
    super.initState();
    String dateFormat = DateFormat('EEEE').format(currentTime);
    convertDateToAbbrev(dateFormat);
    requestCrawlService();
    // ignore: avoid_print
    print(loadingCrawl);
  }


  @override
  Widget build(BuildContext context) {
      return (loadingCrawl) ?
      const CrawlSpinner() : (!isCrawlAuthenticate) ?
      const Center(child: Text("It seems there is something wrong, we recommend to login again")) :
      (docDate == 'wkd') ? const ClosedMenu() :
      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('lunch').doc(docDate).get(),
        builder: (_,snapshot) {
          if (snapshot.hasError) return const Text("Error");

          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            mainDish = List<String>.from(data!['main']);
            sideDish = List<String>.from(data['side']);
            soup = List<String>.from(data['soup']);
            dessert = List<String>.from(data['dessert']);
            return Sizer(builder: (context, orientation, deviceType){
              return Container(
                  margin: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                        children: <Widget> [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 125,
                            height: 125,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage("images/img_chef.jpg"),
                                    fit: BoxFit.fill)
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Text("Main Dish", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                                  // Text("Collet Heo Chien Fried pork cutlet", style: TextStyle(fontSize: 15)),
                                  // Text("Thit kho heo tom Poached meat and shrimp", textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                  ListView.builder(
                                      itemCount: mainDish.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Text(mainDish[index],
                                            textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                      }
                                  )
                                ],
                              )
                          ),

                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Text("Side Dish", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                                  ListView.builder(
                                      itemCount: sideDish.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Text(sideDish[index],
                                            textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                      }
                                  )
                                ],
                              )
                          ),

                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Text("Soup", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                                  ListView.builder(
                                      itemCount: soup.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Text(soup[index],
                                            textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                      }
                                  )
                                ],
                              )
                          ),

                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Text("Dessert", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                                  ListView.builder(
                                      itemCount: dessert.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Text(dessert[index],
                                            textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                      }
                                  )
                                ],
                              )
                          ),

                          Container(
                              margin: const EdgeInsets.only(top: 50, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => const WeeklyLunchScreen()));
                                    },
                                    child: Text("Check ", style: TextStyle(fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline)),
                                  ),
                                  Text("this week's lunch menu", style: TextStyle(fontSize: 15.sp))
                                ],
                              )
                          )
                        ],
                      )
                  )
              );
            },);
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
  }
