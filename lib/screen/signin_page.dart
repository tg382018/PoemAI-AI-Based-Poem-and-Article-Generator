import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwo/screen/forgotpassword.dart';
import 'package:fluttertwo/screen/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constant/app_theme.dart';
import 'home_screen.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailkey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailsent = TextEditingController();
  bool buttonClicked = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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

  void submitFormOnlogin() async {
    FocusScope.of(context).unfocus();
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.toLowerCase().trim(),
                password: passwordController.text.trim())
            .then((value) {
          if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Stack(children: [
                Container(
                  padding: EdgeInsets.all(16),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 48,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Signin Successful",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              "You joined successfully",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Stack(children: [
                Container(
                  padding: EdgeInsets.all(16),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 48,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Email Confirmation",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              "You didnt confirm email yet",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ));
          }
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Stack(children: [
            Container(
              padding: EdgeInsets.all(16),
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              "Warning",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          'Wrong email or password',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SigninPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
              SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                            width: 222,
                            height: 222,
                            child: Image.asset(
                              "lib/assets/scf.png",
                            )),
                        Text(
                          "WELCOME",
                          style: GoogleFonts.bebasNeue(fontSize: 52),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("PoemAI is waiting for you",
                            style: GoogleFonts.neucha(fontSize: 22)),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'It can not be empty';
                                  } else {
                                    emailController.text = value;
                                  }
                                },
                                controller: emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    hintText: 'Email'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'It can not be empty';
                                  } else {
                                    passwordController.text = value;
                                  }
                                },
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    hintText: 'Password'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: submitFormOnlogin,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.deepPurple),
                              child: Center(
                                  child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not a member ?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                              child: AnimatedContainer(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Register Now',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  duration: Duration(microseconds: 222),
                                  height: 35,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      gradient: LinearGradient(colors: [
                                        Colors.greenAccent,
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
                                      ])),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot password ?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword()));
                              },
                              child: AnimatedContainer(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Reset',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  duration: Duration(microseconds: 222),
                                  height: 31,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      gradient: LinearGradient(colors: [
                                        Colors.pinkAccent,
                                        Colors.red,
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
                                      ])),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Send Password Request"),
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Form(
                key: emailkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'It can not be empty';
                        } else {
                          emailController.text = value;
                        }
                      },
                      controller: emailsent,
                      decoration: InputDecoration(hintText: 'Write your email'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                        onPressed: buttonClicked
                            ? () {
                                setState(() {
                                  buttonClicked = false;
                                });
                              }
                            : null,

                        child: Text('Send')),
                  ],
                ),
              ),
            ),
          ));
}
