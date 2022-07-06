import 'package:flutter/material.dart';

class SurveyListScreen extends StatefulWidget {
  const SurveyListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SurveyListScreen> {
  List<String> surveyList = [
    'Orange',
    'Berries',
    'Lemons',
    'Apples',
    'Mangoes',
    'Dates',
  ];
  List<String>? foodListSearch;

  @override
  void initial(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

      // Scaffold(
      // appBar: AppBar(
      //   title: Text("netcompany"),
      //   backgroundColor: const Color(0xff0f2147),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => HistoryMenuScreen()));
      //     },
      //   ),
      // ),
      //
      // body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Survey List ', // default text style'
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),

          Expanded(
            child: surveyList.isEmpty?
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.search_off,
                      size: 100,
                      color: Colors.blue,
                    ),
                    Text(('There is no suvery'),
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))
                  ],
                ))
                :
            GridView.builder(
              padding: EdgeInsets.only(left: 20, right: 20),
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  // padding: (index % 2) == 0 ? EdgeInsets.only(bottom: 15) : EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                    shadowColor: const Color(0xff0f2147),
                    color: Colors.white,
                    child: Expanded(
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.green[500],
                              radius: 40,
                              child: const CircleAvatar(
                                backgroundImage: AssetImage(
                                    "images/survey.png"), //NetworkImage
                                radius: 100,
                              ), //CircleAvatar
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                                'The netcompany tour 2022', textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, softWrap: false
                              //Textstyle
                            ),
                          ), //Text
                          //SizedBox

                          const Text(
                            'Expired to 20/05/2022',
                            style: TextStyle(
                              fontSize: 15,
                            ), //Textstyle
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //SizedBox
                          SizedBox(
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Color(0xff0f2147))),

                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: const [
                                    Icon(Icons.touch_app),
                                    Text('Take')
                                  ],
                                ),
                              ),
                            ),
                          ) ,//SizedBox
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      // ),
    );
  }
}