import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwo/constant/app_theme.dart';
import 'package:fluttertwo/class/SavedPrompts.dart';
import 'package:fluttertwo/screen/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class PromptTwo extends StatefulWidget {
  const PromptTwo({Key? key, required this.title, required this.whatisthis})
      : super(key: key);
  final String title;
  final bool whatisthis;

  @override
  State<PromptTwo> createState() => _PromptTwoState();
}

class _PromptTwoState extends State<PromptTwo> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Default"), value: "lib/assets/wp.jpeg"),
      DropdownMenuItem(child: Text("Love"), value: "lib/assets/love.jpg"),
      DropdownMenuItem(child: Text("Winter"), value: "lib/assets/winter.jpg"),
      DropdownMenuItem(child: Text("Morning"), value: "lib/assets/morning.jpg"),
    ];
    return menuItems;
  }

  final screenshotController = ScreenshotController();
  Image? image;
  var doesTheImageExist = false;

  Future<List<SavedPrompts>> readPrompts() async {
    final querysnapshot =
        await FirebaseFirestore.instance.collection("SavedPrompts").get();
    List<QueryDocumentSnapshot> docs = querysnapshot.docs;
    final list = docs
        .map((doc) => SavedPrompts.fromJson(doc.data() as dynamic))
        .toList();
    return list;
  }

  File? _imageFile;

  bool isPinnedChoose = false;
  var promptTitle = TextEditingController();
  String selectedValue = "lib/assets/wp.jpeg";

  Future<void> addPrompt(
    String userID,
    String title,
    String content,
    String contentFirst,
    bool isPinned,
    bool whatisthis,
  ) async {
    final docUser = FirebaseFirestore.instance.collection('SavedPrompts').doc();
    var prompt = HashMap<String, dynamic>();
    prompt["id"] = docUser.id;
    prompt["userID"] = userID;
    prompt["title"] = title;
    prompt["content"] = content;
    prompt["contentFirst"] = contentFirst;
    prompt["isPinned"] = isPinned;
    prompt["whatisthis"] = whatisthis;
    await docUser.set(prompt);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(selectedValue), fit: BoxFit.cover)),
          child: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 10),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '     ',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.7),
                            offset: Offset(2, 0),
                            blurRadius: 16,
                          ),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 18,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 300,
                                maxWidth: 500,
                              ),
                              child: Container(
                                  child: SingleChildScrollView(
                                      child: Text(
                                widget.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ))),
                            ),
                            SizedBox(
                              height: 38,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /*  Row(
                            children: [
                              Icon(Icons.security_update_sharp,color: Colors.purpleAccent,),
                              Text("Scrollable Screen ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purpleAccent),),
                            ],
                          ),*/
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 4),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () async {
                            _takeScreenshotandShare();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 12),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.share,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(34),
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white54,
                                ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.pinkAccent.withOpacity(.6),
                                      spreadRadius: 1,
                                      blurRadius: 16,
                                      offset: Offset(-8, 8)),
                                  BoxShadow(
                                      color:
                                          Colors.indigoAccent.withOpacity(.2),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(-8, 0)),
                                  BoxShadow(
                                      color:
                                          Colors.indigoAccent.withOpacity(.2),
                                      spreadRadius: 5,
                                      blurRadius: 32,
                                      offset: Offset(-8, 0))
                                ]),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                                DropdownButton(
                                    dropdownColor: Colors.white,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue!;
                                        print(selectedValue);
                                      });
                                    },
                                    value: selectedValue,
                                    items: dropdownItems),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Add Favorites"),
            content: Container(
              height: MediaQuery.of(context).size.height / 7,
              child: Column(
                children: [
                  TextField(
                    controller: promptTitle,
                    decoration: InputDecoration(labelText: "Write a title"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    var userID = FirebaseAuth.instance.currentUser!.uid;
                    var firstContent = "${widget.title.characters.take(9)}...";
                    isPinnedChoose = false;
                    addPrompt(userID, promptTitle.text, widget.title,
                            firstContent, isPinnedChoose, widget.whatisthis)
                        .then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false));
                  },
                  child: Text("Add")),
            ],
          ));

  _takeScreenshotandShare() async {
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((Uint8List? screenshot) async {
      if (screenshot != null) {
        final directory = (await getApplicationDocumentsDirectory()).path;
        final imagePath = '$directory/screenshot.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(screenshot);
        await Share.shareFiles([imagePath], mimeTypes: ['image/png']);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
