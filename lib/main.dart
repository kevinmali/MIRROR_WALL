import 'package:flutter/material.dart';

import 'views/android_screen/Home_pages.dart';
import 'views/android_screen/Splace_Scrren.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        routes: {
          '/': (context) => const Splash(),
          'Home_page': (context) => const Home(),
        }),
  );
}
