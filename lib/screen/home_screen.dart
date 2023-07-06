import 'package:flutter/material.dart';
import 'package:fluttertwo/app_theme.dart';
import 'package:fluttertwo/screen/Forms/acrosticform.dart';
import 'package:fluttertwo/screen/Forms/compositionform.dart';
import 'package:fluttertwo/screen/Forms/normalform.dart';
import 'package:fluttertwo/screen/component/bottom_nav.dart';

import 'package:fluttertwo/screen/prompt_page.dart';
import 'package:fluttertwo/screen/saved_prompts.dart';
import 'package:fluttertwo/screen/signin_page.dart';
import 'package:fluttertwo/screen/signup_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'component/wire_draw.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Offset initialPosition=const Offset(250, 0);
  Offset switchPosition=const Offset(350, 350);
  Offset containerPosition=const Offset(350, 350);
  Offset finalPosition=const Offset(350, 350);
  int settingsacik=0;
  bool settingsbool=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() {
    final Size size=MediaQuery.of(context).size;
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    initialPosition=Offset(size.width*.9, 0);
    containerPosition=Offset(size.width*.9, size.height*.4);
    finalPosition=Offset(size.width*.9, size.height*.5-size.width*.1);
    if(themeProvider.isLightTheme)
      {
        switchPosition=containerPosition;
      }
    else{
      switchPosition=finalPosition;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return Scaffold(


bottomNavigationBar:BottomNav(),


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

            SafeArea(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3,),
     SizedBox(width: 111,child: Container(child: Image.asset("lib/assets/scf.png"))),
       SizedBox(width:size.width*.4,child: Divider(color: Colors.white,)),
        Text("BEST",style: Theme.of(context).textTheme.headline1,),
          Text("Poem\nGenerator App\nIn The World",
          style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  SizedBox(height: 39,),

                  InkWell(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>AcrosticFormPage()));}
                  //AcrosticFormPage()
                      ,child: Container(height:90,child: Image.asset("lib/assets/acrosticbutton.png"))),
                  SizedBox(height: 13,),
                  GestureDetector( onTap: ()
                  {Navigator.push(context, MaterialPageRoute(builder: (context)=>NormalFormPage()));},
                      child: SizedBox(height:90,child: Container(child: Image.asset("lib/assets/normalpoembutton.png")))),
                  SizedBox(height: 13,),
                  GestureDetector( onTap: ()
                  {Navigator.push(context, MaterialPageRoute(builder: (context)=>CompositionForm()));},
                      child: SizedBox(height:90,child: Container(child: Image.asset("lib/assets/articlebutton.png")))),



                ],
              ),
            )),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NormalFormPage()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Image.asset('lib/assets/beta.png',width: 130,height: 125,),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Positioned(
                top: containerPosition.dy-size.width*.1/2-5,
                 left: containerPosition.dx-size.width*.1/2-5,
                child: Container(
                  width: size.width*.1+10,
                  height: size.height*.1+10,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode().switchBgColor!,
                    borderRadius: BorderRadius.circular(30),

                  ),
                )),

                Wire(initialPosition: initialPosition,
                  toOffset: switchPosition,),
                AnimatedPositioned(

                  duration: Duration(milliseconds:0 ),
                  top: switchPosition.dy-size.width*.1/2,
                  left: switchPosition.dx-size.width*.1/2,
                  child: Draggable(child: Container(
                    width: size.width * .1,
                    height: size.width*.1,
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode().thumbColor,
                      border: Border.all(width: 5,color:
                      themeProvider.themeMode().switchColor!
                      ),
                      shape: BoxShape.circle,

                    ),
                  ),
                      onDragUpdate: (details){
                        setState(() {
                          switchPosition=details.localPosition;
                        });
                      },
                      onDragEnd: (details){
                        if(themeProvider.isLightTheme)
                        {
                          setState(() {
                            switchPosition=containerPosition;
                          });
                        }
                        else
                        {
                          setState(() {
                            switchPosition=finalPosition;
                          });
                        }
                        themeProvider.toggleThemeData();
                      },
                      feedback:Container(
                        width: size.width * .1,
                        height: size.width*.1,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,

                        ),
                      )),
                ),

              ],


            ),

          ],
        ),
      ),
    );
  }


}


