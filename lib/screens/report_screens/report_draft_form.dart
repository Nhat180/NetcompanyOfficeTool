import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:netcompany_office_tool/model/draft.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_screen.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/httphandler_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';
import '../../constants.dart';
import '../../dialog/form_alert_dialog.dart';
import '../../model/report.dart';


class ReportDraftForm extends StatefulWidget {
  final Draft draft;

  const ReportDraftForm({Key? key, required this.draft}) : super(key: key);

  @override
  State<ReportDraftForm> createState() => _ReportDraftFormState();
}

class _ReportDraftFormState extends State<ReportDraftForm> {
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final FirebaseService firebaseService = FirebaseService();
  final StorageService storageService = StorageService();
  final HttpHandlerService handlerService = HttpHandlerService();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int newDraftImagesCounter = 0;
  String? _dropDownValue;
  DateTime currentTime = DateTime.now();
  bool draftUpdateLoading = false;
  bool imageLoading = false;
  bool loading = false;
  bool isDone = true;



// https://pub.dev/packages/image_picker
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList=[];
  void selectImage(int maxSelected) async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(imageQuality: 50);
    if(selectedImages!.isNotEmpty && selectedImages.length <= maxSelected){
      for(int i = 0; i < selectedImages.length; i++) {
        imageFileList!.add(File(selectedImages[i].path));
        newDraftImagesCounter++;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
          const SnackBar(content: Text("You can only select maximum of 9 images")));
    }
    setState(() {

    });
  }

  void convertUrlsToFile() async {
    imageLoading = true;
    imageFileList = await handlerService.urlsToFiles(widget.draft.id!, widget.draft.imgUrls!);
    setState(() {

    });
    imageLoading = false;
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.draft.title;
    descriptionController.text = widget.draft.description;
    if (widget.draft.imgUrls != null) {
      convertUrlsToFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
          backgroundColor: const Color(0xff0f2147),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (titleController.text == widget.draft.title &&
                  descriptionController.text == widget.draft.description 
              && _dropDownValue == null && newDraftImagesCounter == 0) {
                setState(() {
                  imageFileList!.clear();
                });
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>
                        NavigationScreen(index: reportScreen,)));
              } else {
                setState(() {
                  draftUpdateLoading = true;
                });
                if (titleController.text != widget.draft.title) {
                  await FirebaseFirestore.instance.collection("draftReports")
                      .doc(widget.draft.id).update({'title': titleController.text});
                }
                if (descriptionController.text != widget.draft.description) {
                  await FirebaseFirestore.instance.collection("draftReports")
                      .doc(widget.draft.id)
                      .update({'description': descriptionController.text});
                }
                if (_dropDownValue != null) {
                  await FirebaseFirestore.instance.collection("draftReports")
                      .doc(widget.draft.id)
                      .update({'type': _dropDownValue!});
                }
                if (newDraftImagesCounter > 0) {
                  String? name = await storageService.readSecureData('name');
                  List<File> newDraftImages = [];
                  for (int i = widget.draft.imgUrls!.length; i < imageFileList!.length; i++) {
                    newDraftImages.add(imageFileList![i]);
                  }
                  final List<String> newDraftImageUrls =
                  await firebaseService.uploadFiles(
                      name!, newDraftImages, true, "reports");
                  for (int i = 0; i < newDraftImageUrls.length; i++) {
                    firebaseService.addUrlFile(
                        "draftReports", widget.draft.id!, newDraftImageUrls[i]);
                  }
                }
                setState(() {
                  imageFileList!.clear();
                });
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>
                        NavigationScreen(index: reportScreen,)));
              }
            },
          ),
        ),
        body: (draftUpdateLoading) ? const Center(child: CircularProgressIndicator(),) :
        SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 100,
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              child: Text.rich(
                                TextSpan(
                                  text: 'Tell us your ',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: 'ISSUES', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 50)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                ),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 1,
                          color: Color(0xff0f2147)
                      ),
                    ],
                  ),

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.short_text,
                              color: Color(0xff0f2147),
                            ),
                            hintText: "Give A Short Title ",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  // dropdown menu
                  //https://www.youtube.com/watch?v=z0ihUbwlSHs

                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 1,
                          color: Color(0xff0f2147)
                      ),
                    ],
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("typeReports").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          const Text("Loading.....");
                        } else {
                          List<DropdownMenuItem<String>> items = [];
                          for(int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            items.add(
                              DropdownMenuItem(
                                child: Text(
                                  snap.id,
                                  style: const TextStyle(color: Color(0xff0f2147)),
                                ),
                                value: snap.id,
                              ),
                            );
                          }
                          return Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                child: Icon(Icons.report, color: Color(0xff0f2147),),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  items: items,
                                  onChanged: (value) {
                                    setState(() {
                                      _dropDownValue = value;
                                    });
                                  },
                                  value: _dropDownValue,
                                  hint: (widget.draft.type.toString()).isEmpty ?
                                  const Text(
                                    "Select Report Type",
                                    style: TextStyle(color: Color(0xff0f2147)),
                                  ) : Text(
                                    widget.draft.type,
                                    style: const TextStyle(color: Color(0xff0f2147)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Text("Loading.....");
                      }
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 1,
                          color: Color(0xff0f2147)
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    child: TextField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.notes_rounded,
                          color: Color(0xff0f2147),
                        ),
                        hintText: "Description",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Visibility(
                      maintainState: true,
                      visible: (imageLoading) ? false : true,
                      child: ElevatedButton.icon(   // <-- ElevatedButton
                        onPressed: () {
                          if (imageFileList!.isEmpty || imageFileList!.length < maxNumOfImg) {
                            selectImage(maxNumOfImg - imageFileList!.length);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                const SnackBar(content: Text("You can only select maximum of 9 images")));
                          }},
                        icon: const Icon(
                          Icons.link,
                          size: 24.0,
                        ),
                        label: const Text('Attach'),
                      ),
                    ),
                  ),
                ),

                imageFileList!.isNotEmpty ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: imageFileList!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(
                                    File(imageFileList![index].path),
                                    fit: BoxFit.cover
                                ),
                                Positioned(
                                  right: -4,
                                  top: -4,
                                  child: Container(
                                    color: const Color.fromRGBO(255, 255, 244, 0.7),
                                    child: IconButton(
                                      onPressed:(){
                                        if (index >= widget.draft.imgUrls!.length) {
                                          imageFileList!.removeAt(index);
                                          newDraftImagesCounter--;
                                        } else {
                                          imageFileList!.removeAt(index);
                                          firebaseService.deleteFile(widget.draft.imgUrls![index]);
                                          firebaseService.deleteUrlFile(
                                              widget.draft.id!,
                                              "draftReports",
                                              widget.draft.imgUrls![index]);
                                          widget.draft.imgUrls!.removeAt(index);
                                        }
                                        setState(() {
                                        });
                                      },
                                      icon: const Icon(Icons.delete)
                                      ,color: Colors.red[500],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ) //Image.file(File(imageFileList![index].path), fit: BoxFit.cover
                    :
                (imageLoading) ? const Center(child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),)) :
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(height: 20,
                        child: Text(
                          "Attaching Images If Any",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                    ),
                  ),
                ),
                //attach image


                (loading || !isDone) ?
                smallButton(isDone) : Visibility(
                  maintainState: true,
                  visible: (imageLoading) ? false : true,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 120, right: 120, top: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff0f2147),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.white, // text + icon color
                      ),
                      icon: const Icon(Icons.send, size: 25),
                      label: const Text('Send', style: TextStyle(fontSize: 20)),
                      onPressed: () async {
                        if (titleController.text == '' || titleController.text.isEmpty
                            || descriptionController.text == '' || descriptionController.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const FormAlert();
                              });
                        } else {
                          setState(() {
                            loading = true;
                            isDone = false;
                          });

                          String? name = await storageService.readSecureData('name');
                          final List<String> imgUrls = await
                          firebaseService.uploadFiles(name!, imageFileList, false, "reports");
                          final String title = titleController.text;
                          final String description = descriptionController.text;
                          String formattedDate = DateFormat('yyyy-MM-dd').format(currentTime);
                          String type = '';
                          if (_dropDownValue == null) {
                            if (widget.draft.type == "" || widget.draft.type.isEmpty) {
                              type = "Other";
                            } else {
                              type = widget.draft.type;
                            }
                          } else {
                            type = _dropDownValue!;
                          }
                          Report report  = Report(
                              creator: name,
                              title: title,
                              dateCreate: formattedDate,
                              status: "pending",
                              type: type,
                              description: description,
                              notification: true,
                              imgUrls: imgUrls,
                              totalCom: 0);

                          await firebaseService.addReport(report);
                          await firebaseService.deleteDraft(widget.draft.id!, "draftReports");

                          for (int i = 0; i < widget.draft.imgUrls!.length; i++) {
                            firebaseService.deleteFile(widget.draft.imgUrls![i]);
                          }

                          setState(() {
                            isDone = true;
                          });

                          await Future.delayed(const Duration(seconds: 2));

                          setState(() {
                            loading = false;
                            titleController.clear();
                            descriptionController.clear();
                            _dropDownValue = null;
                            imageFileList?.clear();
                          });

                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => NavigationScreen(index: reportScreen,)));
                        }
                      },
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  Widget smallButton(bool isDone) {
    final color = isDone ? Colors.green : const Color(0xff0f2147);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 55,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
          child: isDone
              ? const Icon(Icons.done, size: 55, color: Colors.white,)
              : const CircularProgressIndicator(color: Colors.white,)
      ),
    );
  }
}

