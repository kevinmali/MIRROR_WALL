import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class intro_page extends StatelessWidget {
  const intro_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "",
            body: "",
            image: Center(
              child: Container(
                height: 460,
                width: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(""), fit: BoxFit.fill)),
              ),
            ),
          ),
          PageViewModel(
            title: "",
            body: "",
            image: Center(
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
        done: Text("done"),
        onDone: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("isIntroVisited", true);
          Navigator.pushReplacementNamed(context, 'Home_page');
        },
        next: Text("Next"),
        showNextButton: true,
      ),
    );
  }
}
