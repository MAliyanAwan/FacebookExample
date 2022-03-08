import 'package:facebookhack/screen/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splashscreen/splashscreen.dart';

class AfterSplashScreen extends StatefulWidget {
  @override
  _AfterSplashScreenState createState() => _AfterSplashScreenState();
}

class _AfterSplashScreenState extends State<AfterSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: SplashScreen(
        seconds: 10,
        image: new Image.asset('assets/images/skull.png', color: Colors.white),
        navigateAfterSeconds: ResultScreen(),
        title: Text(
          'Attacking Start',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.red[900]),
          textAlign: TextAlign.center,
        ),
        loadingText: Text(
          'パスワードクラッ',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        backgroundColor: Colors.black,
        loaderColor: Colors.red[900],
        photoSize: 100.0,
      ),
    );
  }
}
