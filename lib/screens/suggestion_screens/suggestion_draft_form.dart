import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netcompany_office_tool/model/draft.dart';
import 'package:netcompany_office_tool/screens/navigation_screen.dart';
import 'package:netcompany_office_tool/screens/report_screens/report_screen.dart';
import 'package:netcompany_office_tool/screens/suggestion_screens/suggestion_screen.dart';


class SuggestionDraftForm extends StatefulWidget {
  final Draft draft;

  const SuggestionDraftForm({Key? key, required this.draft}) : super(key: key);

  @override
  State<SuggestionDraftForm> createState() => _SuggestionDraftFormState();
}

class _SuggestionDraftFormState extends State<SuggestionDraftForm> {
  String? _dropDownValue;
  final val = ['Device', 'Electric', 'Meal', 'Elevator', 'Food'];
  TextEditingController _title = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _description = TextEditingController();


// https://pub.dev/packages/image_picker
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList=[];

  void selectImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if(selectedImages!.isNotEmpty && selectedImages.length <= 8){
      for(int i = 0; i < selectedImages.length; i++) {
        imageFileList!.add(File(selectedImages[i].path));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
          const SnackBar(content: Text("You can only select maximum of 8 images")));
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const NavigationScreen(index: 1)
                      )); },),
                    const Text.rich(
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
                          controller: _title  = TextEditingController(text: widget.draft.title.toString()),
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
                          hint: widget.draft.type.toString().isEmpty ?
                          const Text('Select Report Type') : Text(
                            widget.draft.type.toString() + ' problem',
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

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    child: TextField(
                      controller: _description = TextEditingController(text: widget.draft.description.toString()),
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
                        if (imageFileList!.isEmpty || imageFileList!.length < 8) {
                          selectImage();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              const SnackBar(content: Text("You can only select maximum of 8 images")));
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


                Container(
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
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SuggestionScreen()
                      )
                      );
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

