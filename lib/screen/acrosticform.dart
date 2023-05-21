import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../glowing_button.dart';

class AcrosticFormPage extends StatefulWidget {
  const AcrosticFormPage({Key? key}) : super(key: key);

  @override
  State<AcrosticFormPage> createState() => _AcrosticFormPageState();
}

class _AcrosticFormPageState extends State<AcrosticFormPage> {

  int tag=1;
  List<String>tags=[];
  List<String>options=[
    'Love','Death','Religion','Nature','Beauty','Aging','Desire','Identity','Travel','Apocalypse','War','Celebration','Family','Sad'
  ];


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
              child: Column(

                children: [
                  SizedBox(height: 18,),
                  Row(
                    children: [

                      Container(width: 40,height: 40,padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,size: 18,color: Colors.black,
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
                        Form(child: Column(

                          children: [
                            SizedBox(height: 33,),
                            Column(children: [TextFormField(
                              decoration: InputDecoration(hintText: 'Enter a word for acrostic'),
                            ),
                              TextFormField(
                                decoration: InputDecoration(hintText: 'Enter a stanza number'),
                              ),
                              TextFormField(
                                decoration: InputDecoration(hintText: 'Enter a line number'),
                              ),
                              TextFormField(
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
                            } ),
                                choiceItems: C2Choice.listFrom(source: options, value: (i,v)=>v, label: (i,v)=>v),
                                choiceActiveStyle: const C2ChoiceStyle(color: Colors.blue,borderColor: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5),)),
                              choiceStyle: const C2ChoiceStyle(color: Colors.black),wrapped: true,
choiceAvatarBuilder: (data){return Icon(Icons.verified_outlined,color: Colors.black,);},
                            ),  GlowingButton(

                            ),
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
          )),




        ],
      ),
      ),
    );
  }
}


