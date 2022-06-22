import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_detail_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_form.dart';

import '../../model/reports.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late final TextEditingController? _textEditingController = TextEditingController();
  List<Report> searchTitle = [];
  var ownList = allReports.where((report) => report.creator == 'Nhat nguyen').toList();



  @override
  Widget build(BuildContext context) {
    return initWidget();
  }
  Widget initWidget(){
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
                height: 200,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset("images/report.png"),
                          height: 180,
                        ),
                      ],
                    )
                )
            ),

            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Create A Report"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 40),
                  textStyle: const TextStyle(fontSize: 20),
                  primary: const Color(0xff0f2147),
                ),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => const ReportForm()
                  ));
                },
              ),
            ),

            Expanded(
              child: ownList.isEmpty?
              Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search_off,
                        size: 100,
                        color: Colors.blue,
                      ),
                      Text(('No Reports Found'),
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))
                    ],
                  ))
                  :
              ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: ownList.length,
                itemBuilder: (context, index) {
                  final report = ownList[index];
                  return Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: Image.asset("images/paper.png", fit: BoxFit.cover, width: 50, height: 50,),
                      title: Text(report.title,  overflow: TextOverflow.ellipsis, softWrap: false),
                      subtitle: Text("Created on " + report.dateCreate + "\nStatus: " + report.status),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => ReportDetailScreen(report)
                        ));
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () {
                            ownList.removeAt(index);
                            setState(() {
                            });
                          }, icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}
