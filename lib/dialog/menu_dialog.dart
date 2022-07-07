import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MenuDialog extends StatelessWidget {
  final String weekdayAbbrev;
  final String? history;

  const MenuDialog({Key? key, required this.weekdayAbbrev, this.history}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: (history == null) ? FirebaseFirestore.instance.collection('lunch').doc(weekdayAbbrev).get()
          : FirebaseFirestore.instance.collection('lunch').doc(weekdayAbbrev).collection("history").doc(weekdayAbbrev+history!).get(),
      builder: (_,snapshot) {
        if (snapshot.hasError) return const Text("Error");

        if(snapshot.hasData) {
          var data = snapshot.data?.data();
          List<String> mainDish = List<String>.from(data!['main']);
          List<String> sideDish = List<String>.from(data['side']);
          List<String> soup = List<String>.from(data['soup']);
          List<String> dessert = List<String>.from(data['dessert']);
          return Sizer(builder: (context, orientation, deviceType) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Center(
                          child: Text("MENU",
                            style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationStyle: TextDecorationStyle.double),
                          ),
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text("Main Dish", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                            ListView.builder(
                                itemCount: mainDish.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(mainDish[index],
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                }
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 5.h),
                      Container(
                        alignment: Alignment.center,
                        // margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: <Widget>[
                            Text("Side Dish", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                            ListView.builder(
                                itemCount: sideDish.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(sideDish[index],
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                }
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 5.h),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text("Soup", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                            ListView.builder(
                                itemCount: soup.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(soup[index],
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                }
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 5.h),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text("Dessert", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                            ListView.builder(
                                itemCount: dessert.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(dessert[index],
                                      textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp));
                                }
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 30, bottom: 15),
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Color(0xff0f2147)
                          ),
                          child: const Text("CLOSE",
                              style: TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },);
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
