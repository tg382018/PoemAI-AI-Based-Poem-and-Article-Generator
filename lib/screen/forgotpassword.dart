import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constant/app_theme.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailkey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailsent = TextEditingController();
  bool buttonClicked = true;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: const Alignment(-0.8, -0.3),
              radius: 1,
              colors: themeProvider.themeMode().gradientColors!),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 61, horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Form(
                      key: emailkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 10),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
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
                            height: 18,
                          ),
                          Text(
                            "RESET PASSWORD",
                            style: GoogleFonts.bebasNeue(fontSize: 52),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'It can not be empty';
                              } else {
                                emailController.text = value;
                              }
                            },
                            controller: emailsent,
                            decoration:
                                InputDecoration(hintText: 'Write your email'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: buttonClicked
                                  ? () {
                                      setState(() {
                                        final isValid =
                                            emailkey.currentState!.validate();

                                        if (isValid) {
                                          FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                                  email: emailsent.text.trim());
                                          setState(() {
                                            buttonClicked = false;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Stack(children: [
                                                Container(
                                                  padding: EdgeInsets.all(16),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      5,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 48,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .account_circle,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  "Request Mail Sent",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              "If the e-mail you entered is registered in/nthe system\nwe have sent an e-mail. Please check your inbox.",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .white),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                            ));
                                          });
                                        }
                                      });
                                    }
                                  : null,

                              /* () {
                      if (buttonClicked == true) {
                        return;
                      }
                      else {
                        final isValid=emailkey.currentState!.validate();

                        if(isValid) {
                          FirebaseAuth.instance.sendPasswordResetEmail(email: emailsent.text);
                          setState(() {
                            buttonClicked=true;
                          });

                        }


                      }
                    }*/
                              child: Text('Send')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
