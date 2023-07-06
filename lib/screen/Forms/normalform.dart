import 'dart:convert';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_widget/flutter_timer_widget.dart';
import 'package:flutter_timer_widget/timer_controller.dart';
import 'package:flutter_timer_widget/timer_style.dart';
import 'package:fluttertwo/class/infoclass.dart';
import 'package:fluttertwo/screen/prompt_page.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../../class/message.dart';
import 'package:http/http.dart' as http;
class NormalFormPage extends StatefulWidget {
  const NormalFormPage({Key? key}) : super(key: key);

  @override
  State<NormalFormPage> createState() => _NormalFormPageState();
}

class _NormalFormPageState extends State<NormalFormPage> {

  int tag=1;
  List<String>tags=[];
  List<String>options=[
    'Love','Death','Religion','Nature','Beauty','Aging','Desire','Identity','Travel','Apocalypse','War','Celebration','Family','Sad'
  ];
  final formKey=GlobalKey<FormState>();
  var acrosticname=TextEditingController();
  var stanza=TextEditingController();
  var linenumber=TextEditingController();
  var keywords=TextEditingController();
  var themecontroller=TextEditingController();
  var info=Info('null', 0, 0, 'null', ['nul','nul']);
  var deneme=TextEditingController();
  final List<Message> _messages = [];
  String prompted='null';
  bool isLoading=false;
  List<String> poemstruc=['default','abab','aabb','abba','aaaa','aaab','abbb'];
  String? slctdstruc='default';
  bool visiblem=true;
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Poem"),value: "Default"),
      DropdownMenuItem(child: Text("Song"),value: "yes"),
    ];
    return menuItems;
  }

  Future<String> sendMessageToChatGPT(String message) async
  {
    Uri uri=Uri.parse("https://api.openai.com/v1/chat/completions");
    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(
        uri,
        headers:
        {
          "Content-Type":"application/json",
          "Authorization":"Bearer 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",

        }
        ,body: json.encode(body));

    print(response.body);
    Map<String, dynamic> parsedReponse = json.decode(response.body);

    String reply = parsedReponse['choices'][0]['message']['content'];
    prompted=reply;
    return reply;

  }



  bool ?isvalid()
  {
    final isValid=formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      return true;
    }
  }


  void submitForm () async
  {

    print('deneme');
    print(info.line);
    print(info.acrostic);
    print(info.stanza);
    print(info.keyword);
    print(info.tags);
    if(info.acrostic  !='yes')
      {
        String yazi='I want you to compose a poem. Please dont give any explanations when you write this poem.'
            'Just write the poem. \n  ,'
            'Keywords to be used in the poem : ${info.keyword}  \n  ,'
            'Theme of the poem: ${info.tags}   ,'
            'THIS POEM SHOULD CONTAIN A MINIMUM OF ${info.stanza} NUMBER OF STANZA. MAKE SURE THERE ARE NO MORE.AFTER YOU HAVE PRODUCED THE WHOLE POEM, CHECK IT BEFORE SENDING IT TO ME. IF THE NUMBER OF STANZA IS MORE THAN I WANT, DELETE THE EXTRA STANZA';
        sendMessageToChatGPT(yazi);

      }

    if(info.acrostic  =='yes')
    {
      String yazi='I want you to compose a poem. Please dont give any explanations when you write this poem.'
          'Just write the poem. \n  ,'
          'The total number of verse of the poem  should be: ${info.stanza}  .Please dont make the number of verses more than the number I gave you, if I told you 2 stanzas, you should produce a poem with only 2 verse. ,\n'
          'Keywords to be used in the poem : ${info.keyword}  \n  ,'
          'Compose this poem as a song (rhyme and regular verses) \n  ,'
          'Theme of the poem: ${info.tags}   ,';
      sendMessageToChatGPT(yazi);

    }


  }

  String selectedValue = "Default";
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: const Alignment(-0.8, -0.3),
              radius: 1,
              colors: themeProvider.themeMode().gradientColors!
          ),
        ),child: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                child: Column(

                  children: [
                    SizedBox(height: 18,),
                    Row(
                      children: [

                        GestureDetector(onTap: (){
                          Navigator.pop(context);
                        },
                          child: Container(width: 40,height: 40,padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,size: 18,color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 13,),
                    Text("Please provide \ninformation requested below",
                      style: TextStyle(fontSize:29,fontWeight: FontWeight.bold),),
                    Column(
                      children: [
                        Form(key: formKey,child: Column(

                          children: [
                            SizedBox(height: 33,),
                            Column(children: [

                              Row(
                                children: [
                                  Text("Select a structure",style: TextStyle(fontSize: 16),),
                                  SizedBox(width: 18,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                                    decoration:   BoxDecoration(borderRadius: BorderRadius.circular(44),gradient: LinearGradient(colors: [
                                      Colors.pinkAccent,
                                      Colors.indigoAccent,
                                    ]
                                    ),boxShadow: [BoxShadow(
                                        color: Colors.pinkAccent.withOpacity(.6),
                                        spreadRadius: 1,
                                        blurRadius: 16,
                                        offset: Offset(-8,8)
                                    ),
                                      BoxShadow(
                                          color: Colors.indigoAccent.withOpacity(.2),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(-8,0)
                                      ),
                                      BoxShadow(
                                          color: Colors.indigoAccent.withOpacity(.2),
                                          spreadRadius: 5,
                                          blurRadius: 32,
                                          offset: Offset(-8,0)
                                      )
                                    ])
                                    ,child: DropdownButton(  dropdownColor: Colors.purpleAccent,
                                         style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                        onChanged: (String? newValue){
                                          setState(() {
                                            selectedValue = newValue!;
                                            info.acrostic=selectedValue;
                                          });
                                        },
                                        value: selectedValue,
                                        items: dropdownItems
                                    ),
                                  ),
                                ],
                              ),

                              TextFormField(keyboardType: TextInputType.number,validator: (value2)
                              {
                                if(value2!.isEmpty)
                                {
                                  return   'It can not be empty';
                                }

                                else
                                {
                                  info.stanza=int.parse(stanza.text);

                                }
                              },controller: stanza,
                                decoration: InputDecoration(hintText: 'Enter min a stanza number'),
                              ),

                              TextFormField(validator: (value2)
                              {
                                if(value2!.isEmpty)
                                {
                                  return   'It can not be empty';
                                }
                                else
                                {

                                  info.keyword=keywords.text;
                                }
                              },controller: keywords,
                                decoration: InputDecoration(hintText: 'Enter a keyword(s) (optional)'),

                              ),],),
                            SizedBox(height: 11,),
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Choose theme(max 2)",
                                  style: TextStyle(fontSize:16,fontWeight: FontWeight.w500),),
                              ],
                            ),


                            Padding(padding: EdgeInsets.all(1),child: Column(children: [
                              ChipsChoice<String>.multiple(value: tags, onChanged: (val)=> setState((){tags=val;print(val.length);

                              if(val.length==3)
                              {
                                val.length=0;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                Stack(
                                    children: [Container(
                                      padding: EdgeInsets.all(16),
                                      height: 70,decoration: BoxDecoration(
                                        color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),child: Row(
                                      children: [
                                        SizedBox(width: 48,),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.warning_amber,color: Colors.white,),
                                                  Text("Warning",style: TextStyle(fontSize: 18,color: Colors.white),),
                                                ],
                                              ),
                                              Text("You can choose only 2 themes",style: TextStyle(fontSize: 12,color: Colors.white),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    ),]
                                ),behavior: SnackBarBehavior.floating,backgroundColor:Colors.transparent ,elevation: 0,
                                )
                                );
                              }
                              info.tags=val;
                              } ),
                                choiceItems: C2Choice.listFrom(source: options, value: (i,v)=>v, label: (i,v)=>v),
                                choiceActiveStyle: const C2ChoiceStyle(color: Colors.blue,borderColor: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5),)),
                                choiceStyle: const C2ChoiceStyle(color: Colors.black),wrapped: true,
                                choiceAvatarBuilder: (data){return Icon(Icons.verified_outlined,color: Colors.black,);},
                              ),

                              visiblem ? buildGestureDetector(context) : Timerm(),



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
    return GestureDetector(onTap:()
                            {
                              if(isvalid()==true)
                              {
                                submitForm();
                                setState(() {
                                  isLoading=true;
                                });
                                visiblem=false;
                                Future.delayed(Duration(seconds: 15),(){
                                  setState(() {
                                    isLoading=false;

                                  });
                                }).then((value) =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>PromtPage(title: prompted,whatisthis: true)),(route)=>false));
                              }

                            }
                              //submitForm,
                              ,child: isLoading? CircularProgressIndicator():AnimatedContainer(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text('Create',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
                                ],
                              ),duration:
                              Duration(microseconds: 222),height:
                              48,width: 160,decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(44),gradient: LinearGradient(colors: [
                                Colors.pinkAccent,
                                Colors.indigoAccent,
                              ]
                              ),boxShadow: [BoxShadow(
                                  color: Colors.pinkAccent.withOpacity(.6),
                                  spreadRadius: 1,
                                  blurRadius: 16,
                                  offset: Offset(-8,8)
                              ),
                                BoxShadow(
                                    color: Colors.indigoAccent.withOpacity(.2),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(-8,0)
                                ),
                                BoxShadow(
                                    color: Colors.indigoAccent.withOpacity(.2),
                                    spreadRadius: 5,
                                    blurRadius: 32,
                                    offset: Offset(-8,0)
                                )
                              ])
                              ),
                            );
  }
}


class Timerm extends StatelessWidget {
  const Timerm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return     Container(
      width: 61,
      height: 61,
      decoration: BoxDecoration(
        color: Colors.purpleAccent.withOpacity(0.25), // border color
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(2), // border width
        child: Container(alignment: Alignment.center, // or ClipRRect if you need to clip the content
          decoration: BoxDecoration(     gradient: LinearGradient(colors: [
            Colors.pinkAccent,
            Colors.indigoAccent,
          ]
          ),
            shape: BoxShape.circle,
            // inner circle color
          ),
          child: Container(child: FlutterTimer(duration: Duration(seconds: 15), onFinished: (){}, timerController: TimerController(
            elevation: 4,
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(8.0),
            background: Colors.orange,
            timerStyle: TimerStyle.rectangular,
            timerTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
            subTitleTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
          ),),), // inner content
        ),
      ),
    );
  }
}