import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_timer_widget/flutter_timer_widget.dart';
import 'package:flutter_timer_widget/timer_controller.dart';
import 'package:flutter_timer_widget/timer_style.dart';
import 'package:fluttertwo/class/SavedPrompts.dart';
import 'package:fluttertwo/screen/prompt_page.dart';
import 'package:provider/provider.dart';
import '../../constant/app_theme.dart';
import 'package:http/http.dart' as http;

class CompositionForm extends StatefulWidget {
  const CompositionForm({Key? key}) : super(key: key);

  @override
  State<CompositionForm> createState() => _CompositionFormState();
}

class _CompositionFormState extends State<CompositionForm> {
  List<SubtitleWidget> sublist = [];
  int clickcount = 0;
  late List<bool> subtitlelist;
  final formKey = GlobalKey<FormState>();
  var acrosticname = TextEditingController();
  var stanza = TextEditingController();
  var kk = TextEditingController();
  var keywords = TextEditingController();
  var themecontroller = TextEditingController();
  var comp2=SavedPrompts('', 'userID', 'title', 'content', 'contentFirst', false, false);

  var deneme = TextEditingController();
  String prompted = 'null';
  bool isLoading = false;

  String? slctdstruc = 'default';
  bool visiblem = true;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Default"), value: "Default"),
      DropdownMenuItem(child: Text("100-150"), value: "100-150"),
      DropdownMenuItem(child: Text("200-250"), value: "200-250"),
      DropdownMenuItem(child: Text("300-350"), value: "300-350"),
      DropdownMenuItem(child: Text("400-450"), value: "400-450"),
    ];
    return menuItems;
  }

  Future<String> sendMessageToChatGPT(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");
    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer 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",
        },
        body: json.encode(body));

    print(response.body);
    Map<String, dynamic> parsedReponse = json.decode(response.body);

    String reply = parsedReponse['choices'][0]['message']['content'];
    prompted = reply;
    return reply;
  }

  bool? isvalid() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      return true;
    }
  }

  addSub() {
    sublist.add(new SubtitleWidget());
    setState(() {});
  }

  void submitForm() async {
    if (comp2.content == 'Default') {
      String yazi =
          'Hello I want you to write an essay.The title of this composition should be ${comp2.title},'
          'The topic of this composition should be ${comp2.contentFirst},'
          'Also, here are the keywords you can use for this essay : ${comp2.userID},Write an essay using this information.'
          ' Please dont write anything outside the essay.Your answer should only include the essay.';
      sendMessageToChatGPT(yazi);
    } else {
      String yazi =
          'Hello I want you to write an essay.The title of this composition should be ${comp2.title},'
          'The topic of this composition should be ${comp2.contentFirst} ,'
          'Also, here are the keywords you can use for this essay : ${comp2.userID},'
          'also this essay should consist of  ${comp2.content} words .Write an essay using this information.'
          ' Please dont write anything outside the essay.Your answer should only include the essay.';
      sendMessageToChatGPT(yazi);
    }
    print('deneme');

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
                                      Row(
                                        children: [
                                          Text(
                                            "Minimum word count",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(44),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.pinkAccent,
                                                  Colors.indigoAccent,
                                                ]),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.pinkAccent
                                                          .withOpacity(.6),
                                                      spreadRadius: 1,
                                                      blurRadius: 16,
                                                      offset: Offset(-8, 8)),
                                                  BoxShadow(
                                                      color: Colors.indigoAccent
                                                          .withOpacity(.2),
                                                      spreadRadius: 3,
                                                      blurRadius: 3,
                                                      offset: Offset(-8, 0)),
                                                  BoxShadow(
                                                      color: Colors.indigoAccent
                                                          .withOpacity(.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 32,
                                                      offset: Offset(-8, 0))
                                                ]),
                                            child: DropdownButton(
                                                dropdownColor:
                                                    Colors.purpleAccent,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedValue = newValue!;
                                                    comp2.content =
                                                        selectedValue;
                                                  });
                                                },
                                                value: selectedValue,
                                                items: dropdownItems),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        validator: (value2) {
                                          if (value2!.isEmpty) {
                                            return 'It can not be empty';
                                          } else {
                                            comp2.title = stanza.text;
                                          }
                                        },
                                        controller: stanza,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Enter the title of the composition'),
                                      ),
                                      TextFormField(
                                        validator: (value2) {
                                          if (value2!.isEmpty) {
                                            return 'It can not be empty';
                                          } else {
                                            comp2.contentFirst = keywords.text;
                                          }
                                        },
                                        controller: keywords,
                                        decoration: InputDecoration(
                                            hintText:
                                                'What do you want in this essay?'),
                                      ),
                                      TextFormField(
                                        validator: (value2) {
                                          comp2.userID = kk.text;
                                        },
                                        controller: kk,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Enter a keyword(s) (optional)'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),


                                  SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Column(
                                      children: [
                                        visiblem
                                            ? buildGestureDetector(context)
                                            : Timerm(),
                                      ],
                                    ),
                                  ),
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
          submitForm();
          setState(() {
            isLoading = true;
          });
          visiblem = false;
          Future.delayed(Duration(seconds: 60), () {
            setState(() {
              isLoading = false;
            });
          }).then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PromtPage(title: prompted, whatisthis: false)),
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
              duration: Duration(seconds: 60),
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

class SubtitleWidget extends StatefulWidget {
  const SubtitleWidget({Key? key}) : super(key: key);

  @override
  State<SubtitleWidget> createState() => _SubtitleWidgetState();
}

class _SubtitleWidgetState extends State<SubtitleWidget> {
  final formKey2 = GlobalKey<FormState>();
  List<String> sbtitles = [];
  var sbs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: TextFormField(
      controller: sbs,
      validator: (value2) {
        if (value2!.isEmpty) {
          return 'It can not be empty';
        } else {
          sbtitles.add(sbs.text);
          print(sbtitles);
        }
      },
      decoration: InputDecoration(hintText: 'Enter a subtitle'),
    ));
  }
}
