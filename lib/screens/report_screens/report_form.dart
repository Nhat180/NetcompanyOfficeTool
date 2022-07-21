import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netcompany_office_tool/constants.dart';
import 'package:netcompany_office_tool/dialog/draft_dialog.dart';
import 'package:netcompany_office_tool/model/report.dart';
import 'package:netcompany_office_tool/screens/home_screen.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:intl/intl.dart';
import 'package:netcompany_office_tool/services/firebase_service.dart';
import 'package:netcompany_office_tool/services/storage_service.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends  State<ReportForm>{
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final FirebaseService firebaseService = FirebaseService();
  final StorageService storageService = StorageService();
  final TextEditingController titleController  = TextEditingController();
  final TextEditingController descriptionController  = TextEditingController();
  String? _dropDownValue;
  DateTime currentTime = DateTime.now();
  bool loading = false;
  bool isDone = true;


  //https://pub.dev/packages/image_picker
  final ImagePicker imagePicker = ImagePicker();
  // List<XFile>? imageFileList=[];
  List<File>? imageFileList=[];
  void selectImage(int maxSelected) async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if(selectedImages!.isNotEmpty && selectedImages.length <= maxSelected){
      for(int i = 0; i < selectedImages.length; i++) {
        imageFileList!.add(File(selectedImages[i].path));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
          const SnackBar(content: Text("You can only select maximum of 9 images")));
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text("netcompany", style: GoogleFonts.ubuntu(textStyle: style)),
        backgroundColor: const Color(0xff0f2147),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (titleController.text == '' && titleController.text.isEmpty
                && descriptionController.text == '' && descriptionController.text.isEmpty
                && _dropDownValue == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NavigationScreen(index: reportScreen,)));
            } else {
              _dropDownValue ??= "";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DraftDialog(formType: reportScreen,
                        title: titleController.text,
                        description: descriptionController.text,
                        type: _dropDownValue!);
                  });
            }
          },
        ),
      ),
            body: SingleChildScrollView(
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
                                  hint: const Text(
                                    "Select Report Type",
                                    style: TextStyle(color: Color(0xff0f2147)),
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
                                    imageFileList![index],
                                    fit: BoxFit.cover
                                ),
                                  Positioned(
                                      right: -4,
                                      top: -4,
                                      child: Container(
                                        color: const Color.fromRGBO(255, 255, 244, 0.7),
                                        child: IconButton(
                                          onPressed:(){
                                            imageFileList!.removeAt(index);
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
                  ///https://towardsdev.com/flutter-tutorial-multiple-image-picker-from-camera-gallery-509a092eff90
                  ///https://www.youtube.com/watch?v=HbMjpQ6I1gY conitinue
                  ///https://stackoverflow.com/questions/53612200/flutter-how-to-give-height-to-the-childrens-of-gridview-builder
                  ///https://stackoverflow.com/questions/57864219/how-can-i-make-multiple-image-picker-which-upload-and-set-image-inside-container
                  ///extra: https://medium.flutterdevs.com/multiimage-picker-in-flutter-69bd9f6cedfb
                  ///extra: https://fluttercorner.com/how-to-select-multiple-images-with-flutter/#For_iOS
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


                  GestureDetector(
                    onTap: () async {
                      if (titleController.text == '' || titleController.text.isEmpty
                          || descriptionController.text == '' || descriptionController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Title and description must be filled to submit the form")
                            )
                        );
                      } else {
                        setState(() {
                          loading = true;
                          isDone = false;
                        });

                        String? name = await storageService.readSecureData('name');
                        final List<String> imgUrls = await firebaseService.uploadFiles(imageFileList, "reports"); /// Note: Add suggestion case
                        final String title = titleController.text;
                        final String description = descriptionController.text;
                        String formattedDate = DateFormat('yyyy-MM-dd').format(currentTime);
                        String type = '';
                        if (_dropDownValue == null) {
                          type = "Other";
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
                            imgUrls: imgUrls,
                            totalCom: 0);

                        await firebaseService.addReport(report);

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

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => NavigationScreen(index: reportScreen,)));
                      }
                    },
                    child: (loading || !isDone) ? smallButton(isDone) : Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 90, right: 90, top: 10, bottom: 10),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          (Color(0xff0f2147)),
                          Color(0xff0f2147)
                        ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              )
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
