import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwo/screen/promptpagetwo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_deck/swipe_deck.dart';
import '../constant/app_theme.dart';
import 'package:provider/provider.dart';
import '../class/SavedPrompts.dart';

class SavedPromptsPage extends StatefulWidget {
  const SavedPromptsPage({Key? key}) : super(key: key);

  @override
  _SavedPromptsPageState createState() => _SavedPromptsPageState();
}

class _SavedPromptsPageState extends State<SavedPromptsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<SavedPrompts>> allPromptsFuture;
  late Future<List<SavedPrompts>> poemPromptsFuture;
  late Future<List<SavedPrompts>> compositionPromptsFuture;

  List<SavedPrompts>? allDataList = [];
  List<SavedPrompts>? poemDataList = [];
  List<SavedPrompts>? compositionDataList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    allPromptsFuture = readAllPrompts();
    poemPromptsFuture = readOnlyPoems();
    compositionPromptsFuture = readOnlyComps();
  }

  // ...
  Future<List<SavedPrompts>> readAllPrompts() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection("SavedPrompts").get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    List<SavedPrompts> listem = docs
        .map((doc) => SavedPrompts.fromJson(doc.data() as dynamic))
        .toList();
    var userUID = FirebaseAuth.instance.currentUser!.uid;
    listem!.removeWhere((item) => item.userID != userUID);
    return listem;
  }

  Future<List<SavedPrompts>> readOnlyPoems() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection("SavedPrompts").get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    List<SavedPrompts> listem = docs
        .map((doc) => SavedPrompts.fromJson(doc.data() as dynamic))
        .toList();
    var userUID = FirebaseAuth.instance.currentUser!.uid;
    listem!.removeWhere(
        (item) => item.userID != userUID || item.whatisthis == false);
    return listem;
  }

  Future<List<SavedPrompts>> readOnlyComps() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection("SavedPrompts").get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    List<SavedPrompts> listem = docs
        .map((doc) => SavedPrompts.fromJson(doc.data() as dynamic))
        .toList();
    var userUID = FirebaseAuth.instance.currentUser!.uid;
    listem!.removeWhere((item) => item.userID != userUID || item.whatisthis);
    return listem;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ...
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.8, -0.3),
                radius: 1,
                colors: themeProvider.themeMode().gradientColors!,
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(icon: Icon(Icons.copy_all_outlined), text: "All"),
              // Tab 1
              Tab(icon: Icon(Icons.clear_all), text: "Poem"),
              // Tab 2
              Tab(icon: Icon(Icons.article_outlined), text: "Composition"),
              // Tab 3
            ],
          ),
        ),
        body: Container(
          width: 522,
          decoration: BoxDecoration(
            gradient: RadialGradient(
                center: const Alignment(-0.8, -0.3),
                radius: 1,
                colors: themeProvider.themeMode().gradientColors!),
          ),
          child: FutureBuilder(
            future: allPromptsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Bir hata oluştu");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                allDataList = snapshot.data;
                if (allDataList!.isEmpty) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                            center: const Alignment(-0.8, -0.3),
                            radius: 1,
                            colors: themeProvider.themeMode().gradientColors!),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Item'),
                        ],
                      ));
                } else if (allDataList!.length == 1) {
                  return Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 163,
                        ),
                        SizedBox(
                            width: 265,
                            height: 352,
                            child: OnlyCard(
                                allDataList![0].content,
                                allDataList![0].title,
                                allDataList![0].contentFirst,
                                allDataList![0].whatisthis)),
                      ],
                    ),
                  );
                } else {
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                              center: const Alignment(-0.8, -0.3),
                              radius: 1,
                              colors:
                                  themeProvider.themeMode().gradientColors!),
                        ),
                        child: SwipeDeck(
                          // ...
                          widgets: allDataList!.map((e) {
                            return CardWidget(e.content, e.title,
                                e.contentFirst, e.whatisthis);
                          }).toList(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                              center: const Alignment(-0.8, -0.3),
                              radius: 1,
                              colors:
                                  themeProvider.themeMode().gradientColors!),
                        ),
                        child: FutureBuilder(
                          future: poemPromptsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Bir hata oluştu");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              poemDataList = snapshot.data;

                              if (poemDataList!.isEmpty) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                          center: const Alignment(-0.8, -0.3),
                                          radius: 1,
                                          colors: themeProvider
                                              .themeMode()
                                              .gradientColors!),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('No Item'),
                                      ],
                                    ));
                              } else if (poemDataList!.length == 1) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 163,
                                    ),
                                    SizedBox(
                                        width: 265,
                                        height: 352,
                                        child: OnlyCard(
                                            poemDataList![0].content,
                                            poemDataList![0].title,
                                            poemDataList![0].contentFirst,
                                            poemDataList![0].whatisthis)),
                                  ],
                                );
                              } else {
                                return SwipeDeck(
                                  // ...
                                  widgets: poemDataList!.map((e) {
                                    return CardWidget(e.content, e.title,
                                        e.contentFirst, e.whatisthis);
                                  }).toList(),
                                );
                              }
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                      SizedBox(
                        height: 222,
                        child: Container(
                          height: 222,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                                center: const Alignment(-0.8, -0.3),
                                radius: 1,
                                colors:
                                    themeProvider.themeMode().gradientColors!),
                          ),
                          child: FutureBuilder(
                            future: compositionPromptsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Bir hata oluştu");
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                compositionDataList = snapshot.data;
                                if (compositionDataList!.isEmpty) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        gradient: RadialGradient(
                                            center: const Alignment(-0.8, -0.3),
                                            radius: 1,
                                            colors: themeProvider
                                                .themeMode()
                                                .gradientColors!),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('No Item'),
                                        ],
                                      ));
                                } else if (compositionDataList!.length == 1) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 163,
                                      ),
                                      SizedBox(
                                          width: 265,
                                          height: 352,
                                          child: OnlyCard(
                                              compositionDataList![0].content,
                                              compositionDataList![0].title,
                                              compositionDataList![0]
                                                  .contentFirst,
                                              compositionDataList![0]
                                                  .whatisthis)),
                                    ],
                                  );
                                } else {
                                  return SwipeDeck(
                                    // ...
                                    widgets: compositionDataList!.map((e) {
                                      return CardWidget(e.content, e.title,
                                          e.contentFirst, e.whatisthis);
                                    }).toList(),
                                  );
                                }
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget CardWidget(String content, String title, String fcontent, bool what) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PromptTwo(title: content, whatisthis: what)));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.pinkAccent,
            Colors.indigoAccent,
          ]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                      visible: what,
                      child: AnimatedContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Poem',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                          duration: Duration(microseconds: 222),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(44),
                              gradient: LinearGradient(colors: [
                                Colors.redAccent,
                                Colors.green,
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
                              ]))),
                  Visibility(
                      visible: !what,
                      child: AnimatedContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Composition',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                          duration: Duration(microseconds: 222),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(44),
                              gradient: LinearGradient(colors: [
                                Colors.green,
                                Colors.cyan,
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
                              ]))),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Text(title,
                  style: GoogleFonts.akronim(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 37)),
              SizedBox(
                height: 6,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(colors: [
                        Colors.white30,
                        Colors.black38,
                      ])),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Text(
                      fcontent,
                      style: GoogleFonts.arima(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget OnlyCard(String content, String title, String fcontent, bool what) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PromptTwo(title: content, whatisthis: what)));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.pinkAccent,
            Colors.indigoAccent,
          ]),
          borderRadius: BorderRadius.circular(40),
        ),
        height: 344,
        width: 244,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                      visible: what,
                      child: AnimatedContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Poem',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                          duration: Duration(microseconds: 222),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(44),
                              gradient: LinearGradient(colors: [
                                Colors.redAccent,
                                Colors.green,
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
                              ]))),
                  Visibility(
                      visible: !what,
                      child: AnimatedContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Composition',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                          duration: Duration(microseconds: 222),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(44),
                              gradient: LinearGradient(colors: [
                                Colors.green,
                                Colors.cyan,
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
                              ]))),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Text(title,
                  style: GoogleFonts.akronim(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 37)),
              SizedBox(
                height: 6,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(colors: [
                        Colors.white30,
                        Colors.black38,
                      ])),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Text(
                      fcontent,
                      style: GoogleFonts.arima(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
