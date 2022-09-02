import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:netcompany_office_tool/model/draft.dart';
import 'package:netcompany_office_tool/model/suggestion.dart';
import 'package:netcompany_office_tool/screens/suggestion_screens/suggestion_detail_screen.dart';
import 'package:netcompany_office_tool/screens/suggestion_screens/suggestion_draft_form.dart';
import 'package:netcompany_office_tool/screens/suggestion_screens/suggestion_form.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';



class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuggestionState();
}

class _SuggestionState extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff0f2147),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const SuggestionForm()
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
  final FirebaseService firebaseService = FirebaseService();
  final StorageService storageService = StorageService();
  Future<List<Suggestion>>? suggestionList;
  List<Suggestion>? retrievedSuggestionList;
  Future<List<Draft>>? draftList;
  List<Draft>? retrievedDraftList;
  bool isExpand1=true;
  bool isExpand2=false;

  void initRetrieval() async {
    String? name = await storageService.readSecureData('name');
    retrievedSuggestionList = await firebaseService.retrieveSuggestions(name!);
    retrievedDraftList = await firebaseService.retrieveDrafts(name, "draftSuggestions");
    setState(() {
      suggestionList = firebaseService.retrieveSuggestions(name);
      draftList = firebaseService.retrieveDrafts(name, "draftSuggestions");
    });

  }


  @override
  void initState() {
    super.initState();
    isExpand1=true;
    isExpand2=false;
    initRetrieval();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 5.0),
            child: Container(
              decoration:BoxDecoration(
                  color: (isExpand1==true) ? Color(0xff0f2147): Colors.white,
                  borderRadius: (isExpand1==true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text("Suggestion", style: isExpand1==true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                    :
                TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize:20)
                ),
                leading: Icon(Icons.lightbulb_sharp, color: (isExpand1!=true)? Color(0xff0f2147): Colors.white),
                trailing: (isExpand1!=true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Colors.white),

                onExpansionChanged: (value){
                  setState(() {
                    isExpand1=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.60), child: getSuggestionsContainer())
                  // Container(child: getReportsContainer())
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0, bottom: 5.0),
            child: Container(
              decoration:BoxDecoration(
                  color: (isExpand2==true) ? Color(0xff0f2147): Colors.white,
                  borderRadius: (isExpand2==true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color(0xff0f2147))
              ),
              child: ExpansionTile(
                initiallyExpanded: false,
                title: Text("Draft", style: isExpand2==true ?TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)
                    :
                TextStyle( color: Color(0xff0f2147), fontWeight: FontWeight.bold, fontSize:20)
                ),
                leading: Icon(Icons.drafts, color: (isExpand2!=true)? Color(0xff0f2147): Colors.white),
                trailing: (isExpand2!=true)?Icon(Icons.arrow_drop_down,size: 32,color: Color(0xff0f2147),):Icon(Icons.arrow_drop_up,size: 32,color: Colors.white),

                onExpansionChanged: (value){
                  setState(() {
                    isExpand2=value;
                  });
                },
                children: [
                  ConstrainedBox (constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.6), child: getDraftsContainer())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget getDraftsContainer() {
    return FutureBuilder(
          future: draftList,
          builder: (BuildContext context, AsyncSnapshot<List<Draft>> snapshot) {
            if(snapshot.hasError) return const Text("Error");

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
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
                        // dismissible: DismissiblePane(
                        //     onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      title: const Text("Delete draft"),
                                      content: const Text("Do you want to delete this draft"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel")
                                        ),

                                        TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                retrievedDraftList!.removeAt(index);
                                              });
                                              await firebaseService.deleteDraft("draftSuggestions", draft.id!);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Ok")
                                        )
                                      ],
                                    );
                                  });
                            },
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
                              builder: (context) => SuggestionDraftForm(draft: draft,)
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
                        color: Colors.white,
                      ),
                      Text(('There is no draft'),
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  )
              );
            } else {
              return const Center(child:  CircularProgressIndicator());
            }
          },
    );
  }



  Widget getSuggestionsContainer() {
    return FutureBuilder(
          future: suggestionList,
          builder: (BuildContext context, AsyncSnapshot<List<Suggestion>> snapshot) {
            if(snapshot.hasError) return const Text("Error");

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: retrievedSuggestionList!.length,
                itemBuilder: (context, index) {
                  final suggestion = retrievedSuggestionList![index];
                  return Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: suggestion.status == "done"?
                      Image.asset("images/images/suggest_done.png", fit: BoxFit.cover, width: 45, height: 45,) :
                      suggestion.status == "pending"? Image.asset("images/suggest_pending.png", fit: BoxFit.cover, width: 45, height: 45,) :
                      Image.asset("images/suggest_process.png", fit: BoxFit.cover, width: 45, height: 45,),

                      title: Text(suggestion.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) ,overflow: TextOverflow.ellipsis, softWrap: false),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Created on " + suggestion.dateCreate),

                          Text(suggestion.description, style: const TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis, softWrap: false),
                        ],
                      ),
                      trailing: Text("  " + suggestion.status, style: suggestion.status == "pending"
                          ? const TextStyle(color:Colors.red) : suggestion.status == "process"
                          ? const TextStyle(color:Color(0xFFFBC02D)) :  const TextStyle(color:Colors.green)),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SuggestionDetailScreen(suggestion)
                        ));
                      },
                    ),
                  );
                },
              );
            }
            if(snapshot.connectionState == ConnectionState.done && retrievedSuggestionList!.isEmpty) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search_off,
                        size: 100,
                        color: Colors.white,
                      ),
                      Text(('No Suggestions Found'),
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
    );
  }
  void doNothing(BuildContext context) {
  }
}
