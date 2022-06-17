import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netcompany_office_tool/screens/home_screen.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_screen.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends  State<ReportForm>{
  final style = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final val = ['Device', 'Electric', 'Meal', 'Elevator', 'Food'];
  String? _dropDownValue;
  //https://pub.dev/packages/image_picker
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList=[];

  void selectImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if(selectedImages!.isNotEmpty){
      imageFileList!.addAll(selectedImages);
    }
    setState(() {

    });
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const NavigationScreen(index: 1,)));
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
                                text: 'Tell us your ', // default text style'
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                children: <TextSpan>[
                                  TextSpan(text: 'ISSUES', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 50)),
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
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: TextField(
                            decoration: InputDecoration(
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

                      child: Row(
                        children: [

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: Icon(Icons.report, color: Color(0xff0f2147),),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: DropdownButton(
                              underline:Container(),
                              hint: _dropDownValue == null ?
                              const Text('Select Report Type') : Text(
                                _dropDownValue! + ' problem',
                              ),
                              items: val.map(
                                    (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text('$value problem'),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value) {
                                setState(
                                      () {
                                    _dropDownValue = value;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
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

                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    child: TextField(

                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
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
                        onPressed: () {selectImage();},
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
                            return   Padding(
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
                                        color: Color.fromRGBO(255, 255, 244, 0.7),
                                        child: IconButton(
                                          onPressed:(){
                                            imageFileList!.removeAt(index);
                                            setState(() {
                                            });
                                          },
                                          icon: Icon(Icons.delete)
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
                    onTap: () {

                    },

                    child: Container(
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
}
