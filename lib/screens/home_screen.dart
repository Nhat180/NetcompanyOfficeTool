import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen  extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}


///Get the data from Firebase using Function Future Call
// Future<String> getLunchMenu() async {
//   var collection = FirebaseFirestore.instance.collection("lunch");
//   var doc = await collection.doc("mon").get();
//   String value = '';
//   if (doc.exists) {
//     Map<String, dynamic>? data = doc.data();
//     value = data!['main'];
//   }
//   return value;
// }


class _State extends State<HomeScreen> {
  /// Initialize the Future method
  // String main = '';
  // @override
  // void initState()  {
  //   super.initState();
  //   getData();
  // }

  /// Call the Future method
  // void getData() async {
  //   main = await getLunchMenu();
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }


  @override
  Widget build(BuildContext context) {
      // child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      //   future: FirebaseFirestore.instance.collection('lunch').doc('mon').get(),
      //   builder: (_,snapshot) {
      //     if (snapshot.hasError) return const Text("Error");
      //
      //     if (snapshot.hasData) {
      //       var data = snapshot.data!.data();
      //       var value = data!['main'];
      //       return Text(value);
      //     }
      //     return const Center(child: CircularProgressIndicator());
      //   },
      // )
    return Container(
        margin: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget> [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage("images/logo.jpg"),
                fit: BoxFit.fill)
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 12),
              child: Column(
                children: const [
                  Text("Main Dish", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text("Collet Heo Chien Fried pork cutlet", style: TextStyle(fontSize: 15)),
                  Text("Ga rang la chanh Fried Chicken", style: TextStyle(fontSize: 15)),
                ],
              )
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: const [
                    Text("Side Dish", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("Collet Heo Chien Fried pork cutlet", style: TextStyle(fontSize: 15)),
                    Text("Ga rang la chanh Fried Chicken", style: TextStyle(fontSize: 15)),
                  ],
                )
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: const [
                    Text("Soup", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("Collet Heo Chien Fried pork cutlet", style: TextStyle(fontSize: 15)),
                    Text("Ga rang la chanh Fried Chicken", style: TextStyle(fontSize: 15)),
                  ],
                )
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: const [
                    Text("Dessert", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("Collet Heo Chien Fried pork cutlet", style: TextStyle(fontSize: 15)),
                    Text("Ga rang la chanh Fried Chicken", style: TextStyle(fontSize: 15)),
                  ],
                )
            )
          ],
        )
      );
    }
  }
