import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
              colors: themeProvider.themeMode().gradientColors!),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 13,),
                  Container(width: 222,height:222,child: Image.asset("lib/assets/scf.png",)),
                    Text("Hello Again!",style: GoogleFonts.bebasNeue(fontSize: 52),),
               SizedBox(height: 10,),
                  Text("Welcome back,we missed you",style: GoogleFonts.neucha(fontSize: 22)),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: TextField(decoration: InputDecoration(hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                          hintText: 'Email'
                        ),),
                      ),
                    ),
                  ),
SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: TextField(obscureText: true
                          ,decoration: InputDecoration(hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            hintText: 'Password'
                        ),),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.deepPurple
                      ),
                      child: Center(
                        child: Text("Sign In",style:
                          TextStyle(color: Colors.white,fontWeight:
                              FontWeight.bold,fontSize: 15,
                          ),)),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member ?",style: TextStyle(
                       fontWeight: FontWeight.bold
                      ),),
                      SizedBox(width: 10,),
                      Text("Register now",style: TextStyle(
                        color: Colors.blue,fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ],
              ),
            )),


          ],
        ),
      ),
    );
  }
}
