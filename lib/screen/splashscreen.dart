import 'package:facebookhack/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: SplashScreen(
        seconds: 8,
        navigateAfterSeconds: LoginScreen(),
        image: new Image.asset('assets/images/skull.png', color: Colors.white),
        title: Text(
          'Facebook Hacking \n V 1.5 Pro',
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
