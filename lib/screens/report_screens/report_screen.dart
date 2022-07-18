import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:netcompany_office_tool/model/draft.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_detail_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_draft_form.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_form.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';
import '../../model/report.dart';


enum WidgetMarker { report, draft}
class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends  State<ReportScreen> {

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
  final FirebaseService firebaseService = FirebaseService();
  final StorageService storageService = StorageService();
  Future<List<Report>>? reportList;
  Future<List<Draft>>? draftList;
  List<Report>? retrievedReportList;
  List<Draft>? retrievedDraftList;

  void initRetrieval() async {
    String? name = await storageService.readSecureData('name');
    retrievedReportList = await firebaseService.retrieveReports(name!);
    retrievedDraftList = await firebaseService.retrieveDrafts(name, "draftReports");
    setState(() {
      reportList = firebaseService.retrieveReports(name);
      draftList = firebaseService.retrieveDrafts(name, "draftReports");
    });

  }


  @override
  void initState() {
    super.initState();
    initRetrieval();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                                  side: const BorderSide(color: Colors.black)
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
        child: FutureBuilder(
          future: draftList,
          builder: (BuildContext context, AsyncSnapshot<List<Draft>> snapshot) {
            if(snapshot.hasError) return const Text("Error");

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: retrievedDraftList!.length,
                itemBuilder: (context, index) {
                  final draft = retrievedDraftList![index];
                  return Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 5),
                    child: Slidable(
                      key: const ValueKey(0),

                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),
                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(
                            onDismissed: () async {
                              retrievedDraftList!.removeAt(index);
                              await firebaseService.deleteDraft("draftReports", draft.id!);
                            }),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: Text('[' + draft.status + ']', style: const TextStyle(color:Colors.blue),),
                        title: Text(draft.title.isEmpty? "No Title" : draft.title ,  overflow: TextOverflow.ellipsis, softWrap: false),
                        subtitle: Text(draft.description.isEmpty? "No preview is available" : draft.description, overflow: TextOverflow.ellipsis, softWrap: false),

                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ReportDraftForm(draft: draft,)
                          ));
                        },
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.done && retrievedDraftList!.isEmpty) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search_off,
                        size: 100,
                        color: Colors.blue,
                      ),
                      Text(('There is no draft'),
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))
                    ],
                  )
              );
            } else {
              return const Center(child:  CircularProgressIndicator());
            }
          },
      )
    );
  }

  Widget getReportsContainer() {
    return Expanded(
      child: FutureBuilder(
        future: reportList,
        builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
          if(snapshot.hasError) return const Text("Error");

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(padding: const EdgeInsets.only(top: 10),
              itemCount: retrievedReportList!.length,
              itemBuilder: (context, index) {
                final report = retrievedReportList![index];
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: report.status == "done"? Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                        child: const Icon(Icons.done, size: 45, color: Colors.white,)) :
                    report.status == "pending"? Image.asset("images/pending.png", fit: BoxFit.cover, width: 45, height: 45,) :
                    Image.asset("images/progress.png", fit: BoxFit.cover, width: 45, height: 45,),

                    title: Text(report.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Created on " + report.dateCreate),

                        Text(report.description, style: const TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                      ],
                    ),
                    trailing: Text("  " + report.status, style: report.status == "pending"
                        ? const TextStyle(color:Colors.red) : report.status == "process"
                        ? const TextStyle(color:Color(0xFFFBC02D)) :  const TextStyle(color:Colors.green)),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => ReportDetailScreen(report)
                      ));
                    },
                  ),
                );
              },
            );
          }
          if(snapshot.connectionState == ConnectionState.done && retrievedReportList!.isEmpty) {
            return Center(
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
                ));
          } else {
            return const Center(child:  CircularProgressIndicator());
          }
          // return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

  void doNothing(BuildContext context) {
  }
}