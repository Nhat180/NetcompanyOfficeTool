import 'package:flutter/material.dart';
import 'package:netcompany_office_tool/model/report_draft.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_detail_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_draft_form.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_form.dart';

import '../../model/reports.dart';


enum WidgetMarker { report, draft}
class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends  State<ReportScreen> {
  var ownList = allReports.where((report) => report.creator == 'Nhat nguyen').toList();

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff0f2147),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const ReportForm()
              ));
            },
            child: const Icon(Icons.border_color ),
          ),
          //BUTTON LOCATION
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: const ListWidget()

      ),
    );
  }
}

class ListWidget extends StatefulWidget{

  const ListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListWidgetState();
}

class ListWidgetState extends State<ListWidget> with SingleTickerProviderStateMixin<ListWidget>{
  WidgetMarker selectedWidgetMarker = WidgetMarker.report;
  // late AnimationController controller;
  // late Animation animation;
  var ownList = allReports.where((report) => report.creator == 'Nhat nguyen').toList();
  var ownDraft = allDrafts.where((report) => report.creator == 'Nhat nguyen').toList();


  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text.rich(
              TextSpan(
                text: 'Tell us your ', // default text style'
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                children: <TextSpan>[
                  TextSpan(text: 'ISSUES', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 50)),
                ],
              ),
            ),
          ],
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 100, // <-- Your width
                  height: 60,
                  child: ElevatedButton(
                    //https://www.youtube.com/watch?v=nDmGGi_RlDM
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                          backgroundColor: (selectedWidgetMarker == WidgetMarker.report) ? MaterialStateProperty.all<Color>(Color(0xff0f2147)) : MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: Colors.black)
                              )
                          )
                      ),
                      onPressed: () {
                        setState(() {
                          selectedWidgetMarker = WidgetMarker.report;
                        });
                      },
                      child: Text(
                          "Report",
                          style: (selectedWidgetMarker == WidgetMarker.report) ?
                          const TextStyle(
                              fontSize:  22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                              :
                          const TextStyle(
                              fontSize:  15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                      )
                  ),
                ),

                SizedBox(
                  width: 100, // <-- Your width
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                          backgroundColor: (selectedWidgetMarker == WidgetMarker.draft) ? MaterialStateProperty.all<Color>(Color(0xff0f2147)) : MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: Colors.black)
                              )
                          )
                      ),
                      onPressed: () {
                        setState(() {
                          selectedWidgetMarker = WidgetMarker.draft;
                        });
                      },
                      child: Text(
                          "Draft",
                          style: (selectedWidgetMarker == WidgetMarker.draft) ?
                          const TextStyle(
                              fontSize:  22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                              :
                          const TextStyle(
                              fontSize:  15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ))
                  ),
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return getCustomContainer();
          },
        )
      ],
    );
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.report:
        return getReportsContainer();
      case WidgetMarker.draft:
        return getDraftsContainer();
    }
  }

  Widget getDraftsContainer() {
    return Expanded(
      child: ownDraft.isEmpty?
      Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search_off,
                size: 100,
                color: Colors.blue,
              ),
              Text(('No Drafts Found'),
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))
            ],
          ))
          :
      ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: ownDraft.length,
        itemBuilder: (context, index) {
          final draft = ownDraft[index];
          return Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10.0),
              leading: Text('[' + draft.status + ']', style: TextStyle(color:Colors.blue),),
              title: Text(draft.title.isEmpty? "No Title" : draft.title ,  overflow: TextOverflow.ellipsis, softWrap: false),
              subtitle: Text(draft.description.isEmpty? "No preview is available" : draft.description, overflow: TextOverflow.ellipsis, softWrap: false),

              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 20.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  //   _onDeleteItemPressed(index);
                },
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ReportDraftForm(draft)
                ));
              },
            ),
          );
        },
      ),
    );
  }

  Widget getReportsContainer() {
    return Expanded(
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
              title: Text(report.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Created on " + report.dateCreate),

                  Text(report.description, style: TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                ],
              ),
              trailing: Text("  " + report.status, style: report.status == "viewed"? TextStyle(color:Colors.red) : TextStyle(color:Colors.green)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => ReportDetailScreen(report)
                ));
              },
            ),
          );
        },
      ),
    );
  }
}