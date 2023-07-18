import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_timer_widget/flutter_timer_widget.dart';
import 'package:flutter_timer_widget/timer_controller.dart';
import 'package:flutter_timer_widget/timer_style.dart';
import 'package:fluttertwo/class/infoclass.dart';
import 'package:fluttertwo/screen/prompt_page.dart';
import 'package:provider/provider.dart';
import '../../constant/app_theme.dart';
import 'package:http/http.dart' as http;

class BetaModelForm extends StatefulWidget {
  const BetaModelForm({Key? key}) : super(key: key);

  @override
  State<BetaModelForm> createState() => _BetaModelFormState();
}

class _BetaModelFormState extends State<BetaModelForm> {
  int tag = 1;
  List<String> tags = [];
  List<String> options = [
    'Love',
    'Death',
    'Religion',
    'Nature',
    'Beauty',
    'Aging',
    'Desire',
    'Identity',
    'Travel',
    'Apocalypse',
    'War',
    'Celebration',
    'Family',
    'Sad'
  ];
  final formKey = GlobalKey<FormState>();
  var acrosticname = TextEditingController();
  var stanza = TextEditingController();
  var linenumber = TextEditingController();
  var keywords = TextEditingController();
  var themecontroller = TextEditingController();
  var info = Info('null', 0, 0, 'null', ['nul', 'nul']);
  var deneme = TextEditingController();
  String prompted = 'null';
  bool isLoading = false;
  List<String> poemstruc = [
    'default',
    'abab',
    'aabb',
    'abba',
    'aaaa',
    'aaab',
    'abbb'
  ];
  String? slctdstruc = 'default';
  bool visiblem = true;
  String? cevap = 'default';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Poem"), value: "Default"),
      DropdownMenuItem(child: Text("Song"), value: "yes"),
    ];
    return menuItems;
  }

  Future<void> sendPoemData(
      String poemCreatorString, String poemLine, String poemMaxWords) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.102:8001/poemapi/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'poem_creator_string': poemCreatorString,
        'poem_line': poemLine,
        'poem_max_words': poemMaxWords,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      String poem = parsedResponse['poem'];
      cevap=poem;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to send poem data.');
    }
  }



  bool? isvalid() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      return true;
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    sendPoemData('love', "3", "10");
  }

  String selectedValue = "Default";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: const Alignment(-0.8, -0.3),
              radius: 1,
              colors: themeProvider.themeMode().gradientColors!),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Row(
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
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        "Please provide \ninformation requested below",
                        style: TextStyle(
                            fontSize: 29, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "Note! \nPlease note that the poetry generated on this page is generated with the beta PoemAI artificial intelligence model. The results you get may be illogical. We are working on improving our model. ",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 33,
                                  ),
                                  Column(
                                    children: [
                                      TextFormField(
                                        validator: (value2) {
                                          if (value2!.isEmpty) {
                                            return 'It can not be empty';
                                          } else {
                                            info.keyword = keywords.text;
                                          }
                                        },
                                        controller: keywords,
                                        decoration: InputDecoration(
                                            hintText: 'Enter a keyword(s) '),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 41,
                                  ),
                                  visiblem
                                      ? buildGestureDetector(context)
                                      : Timerm(),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isvalid() == true) {
          sendPoemData(info.keyword,'4','15');
          setState(() {
            isLoading = true;
          });
          visiblem = false;
          Future.delayed(Duration(seconds: 15), () {
            setState(() {
              isLoading = false;
            });
          }).then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PromtPage(title: cevap!, whatisthis: true)),
              (route) => false));
        }
      }
      //submitForm,
      ,
      child: isLoading
          ? CircularProgressIndicator()
          : AnimatedContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              duration: Duration(microseconds: 222),
              height: 48,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44),
                  gradient: LinearGradient(colors: [
                    Colors.pinkAccent,
                    Colors.indigoAccent,
                  ]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.pinkAccent.withOpacity(.6),
                        spreadRadius: 1,
                        blurRadius: 16,
                        offset: Offset(-8, 8)),
                    BoxShadow(
                        color: Colors.indigoAccent.withOpacity(.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(-8, 0)),
                    BoxShadow(
                        color: Colors.indigoAccent.withOpacity(.2),
                        spreadRadius: 5,
                        blurRadius: 32,
                        offset: Offset(-8, 0))
                  ])),
    );
  }
}

class Timerm extends StatelessWidget {
  const Timerm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 61,
      height: 61,
      decoration: BoxDecoration(
        color: Colors.purpleAccent.withOpacity(0.25), // border color
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(2), // border width
        child: Container(
          alignment: Alignment.center,
          // or ClipRRect if you need to clip the content
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.pinkAccent,
              Colors.indigoAccent,
            ]),
            shape: BoxShape.circle,
            // inner circle color
          ),
          child: Container(
            child: FlutterTimer(
              duration: Duration(seconds: 15),
              onFinished: () {},
              timerController: TimerController(
                elevation: 4,
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(8.0),
                background: Colors.orange,
                timerStyle: TimerStyle.rectangular,
                timerTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 30),
                subTitleTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ), // inner content
        ),
      ),
    );
  }
}
