import 'package:flutter/material.dart';
import 'package:fluttertwo/app_theme.dart';
import 'package:fluttertwo/screen/component/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/constant.dart';
import 'screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  bool isLightTheme=prefs.getBool(SPref.isLight) ?? true;
  runApp(AppStart(isLightTheme:isLightTheme,
  ));
}

class AppStart extends StatelessWidget {
  const AppStart({Key? key, required this.isLightTheme}) : super(key: key);
final bool isLightTheme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>ThemeProvider(isLightTheme: isLightTheme),
      )
    ],child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:themeProvider.themeData(),
      home:const Sidebar(),
      // const HomeScreen(),
    );
  }
}

