import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_deck/swipe_deck.dart';

import '../app_theme.dart';

class SavedPromptsPage extends StatefulWidget {
  const SavedPromptsPage({Key? key}) : super(key: key);

  @override
  State<SavedPromptsPage> createState() => _SavedPromptsPageState();
}

class _SavedPromptsPageState extends State<SavedPromptsPage> {
List<List<Color>> gradientColors=[
  [Colors.indigo,Colors.indigoAccent,Colors.black],
  [Colors.pink,Colors.pinkAccent,Colors.amberAccent],
  [Colors.purple,Colors.purpleAccent,Colors.greenAccent],
  [Colors.lime,Colors.limeAccent,Colors.orangeAccent],
  [Colors.red,Colors.redAccent,Colors.black],
  [Colors.cyan,Colors.cyanAccent,Colors.white],
];
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
                center: const Alignment(-0.8, -0.3),
                radius: 1,
                colors: themeProvider.themeMode().gradientColors!
            ),
          ),child: Stack(
          fit: StackFit.expand,
          children: [

            SafeArea(child: Column(
              children: [     SizedBox(height: 22,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(width: 40,height: 40,padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,size: 18,color: Colors.black,
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          SizedBox(height: 5,),
                          Text("    ",
                            style: TextStyle(fontSize: 21,color: Colors.white),),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 11,),
                Row(

                  children: [

                    SizedBox(width: 18,),

                  ],
                ),    SizedBox(height: 11,), SizedBox(height: size.height*.05,width: size.width*.9,
                  child: Container(
                    decoration: BoxDecoration(gradient: LinearGradient(
                      begin: Alignment.topLeft,end: Alignment.topRight,
                      colors: [
                        Colors.white,
                        Colors.white12,
                      ],
                    ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [

                      SizedBox(width: 11,),
                      Icon(Icons.search,color: Colors.black,),
                    ],
                    ),
                  ),
                ),
                SizedBox(height: 22,),
            SizedBox(height: size.height*.1,width: size.width*.9,
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topLeft,end: Alignment.topRight,
                    colors: [
                      Colors.pinkAccent,
                      Colors.indigoAccent,
                    ],
                ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  SizedBox(width: 11,),
                  Column(
                    children: [
                      SizedBox(height: 11,),
                      SizedBox(height: 22,width:22,child: Container(child: Image.asset("lib/assets/pinned.png",),)),
                    ],
                  ) ,
                ],
                ),
              ),
            ),SizedBox(height: 11,),
                SizedBox(height: size.height*.1,width: size.width*.9,
                  child: Container(
                    decoration: BoxDecoration(gradient: LinearGradient(
                      begin: Alignment.topLeft,end: Alignment.topRight,
                      colors: [
                        Colors.pinkAccent,
                        Colors.indigoAccent,
                      ],
                    ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Row(children: [
                      SizedBox(width: 11,),
                      Column(
                        children: [
                          SizedBox(height: 11,),
                          SizedBox(height: 22,width:22,child: Container(child: Image.asset("lib/assets/pinned.png",),)),
                        ],
                      ) ,
                    ],
                    ),
                  ),
                ),
                SizedBox(height: 11,),
                SizedBox(height: size.height*.1,width: size.width*.9,
                  child: Container(
                    decoration: BoxDecoration(gradient: LinearGradient(
                      begin: Alignment.topLeft,end: Alignment.topRight,
                      colors: [
                        Colors.pinkAccent,
                        Colors.indigoAccent,
                      ],
                    ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Row(children: [
                      SizedBox(width: 11,),
                      Column(
                        children: [
                          SizedBox(height: 11,),
                          SizedBox(height: 22,width:22,child: Container(child: Image.asset("lib/assets/pinned.png",),)),
                        ],
                      ) ,
                    ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(height: 41,),
                          Text("aaaa",style: TextStyle(color: Colors.white),),
                          Container(child: SwipeDeck(startIndex: 4,emptyIndicator: Container(
                            child: Center(
                              child: Text('a'),
                            ),
                          ),
                            cardSpreadInDegrees: 5,
                            onSwipeLeft: (){},
                            onSwipeRight: (){},
                            onChange: (index){},
                    widgets: gradientColors.map((e) => CardWidget(e)).toList()),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),




          ],
        ),
        ),
      ),
    );
  }

Widget CardWidget(List<Color> colors) => Container(
  decoration: BoxDecoration(gradient: LinearGradient(
      begin: Alignment.topLeft,end: Alignment.topRight,
  colors: colors,
  ),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(children: [

  ],
  ),
);

}
