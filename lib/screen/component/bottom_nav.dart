import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwo/main.dart';
import 'package:fluttertwo/screen/home_screen.dart';
import 'package:fluttertwo/screen/signin_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../class/SavedPrompts.dart';
import '../Forms/acrosticform.dart';
import '../saved_prompts.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState

    super.setState(fn);
  }




  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: 52,
      child:   Container(color: Colors.black,
        child:   GNav(activeColor: Colors.white,color: Colors.white,textStyle: TextStyle(color: Colors.white),padding: EdgeInsets.all(16),
          tabs: [
            GButton(onPressed: (){

            },icon: Icons.home,text: "Home"),
            GButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedPromptsPage()));
            },

                icon: Icons.favorite_border,text: "Saved"),

            GButton(onPressed:showMenu,icon: Icons.settings,text: "Settings",),
          ],
        ),
      ),
    );
  }



  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(

            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 6,
                  color: Colors.black,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height/5,
                    child: Container(

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(1.0),
                            topRight: Radius.circular(1.0),
                          ),
                          color: Colors.black,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none, alignment: Alignment(0, 0),
                          children: <Widget>[

                            Positioned(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[

                                  ListTile(
                                    title: Text(
                                      "Log out",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    onTap: () async {


                                          FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SigninPage()),(route) => false));

                                    },
                                  ),

                                  ListTile(
                                    title: Text(
                                      "About us",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    onTap: () {},
                                  ),


                                ],
                              ),
                            )
                          ],
                        ))),
                Container(
                  height: 6,
                  color: Colors.black,
                )
              ],
            ),
          );
        });
  }
}
