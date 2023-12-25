import 'package:flutter/material.dart';
import 'package:mirror_wall/views/android_screen/Intro_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/android_screen/Home_pages.dart';
import 'views/android_screen/Splace_Scrren.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isvisited = preferences.getBool("isIntroVisited") ?? false;
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        routes: {
          '/': (context) => const Splash(),
          'intro': (context) => intro_page(),
          'Home_page': (context) => const Home(),
        }),
  );
}
