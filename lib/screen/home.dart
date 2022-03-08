import 'dart:async';

import 'package:facebookhack/screen/aftersplash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LinearProgressIndicatorApp(),
    );
  }
}

class LinearProgressIndicatorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState();
  }
}

class LinearProgressIndicatorAppState
    extends State<LinearProgressIndicatorApp> {
  late bool _loading;
  late double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(color: Colors.red[900], fontSize: 70),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Image.asset(
                'assets/images/passlogo.png',
                color: Colors.green[900],
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ハッキングしたいメールアドレスを入力してく',
                    style: TextStyle(color: Colors.red[900]),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    suffixIcon: Image.asset(
                      'assets/images/passicon.png',
                      color: Colors.red,
                      height: 30,
                      width: 50,
                    ),
                    label: Text(
                      'Enter Targetted Username or Email',
                      style: TextStyle(color: Colors.white),
                    ),
                    hintText: 'Abc@Example.com',
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: _loading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          LinearProgressIndicator(
                            backgroundColor: Colors.cyanAccent,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.red),
                            value: _progressValue,
                          ),
                          Text('${(_progressValue * 100).round()}%'),
                        ],
                      )
                    : Text("Press button for find user",
                        style:
                            TextStyle(fontSize: 25, color: Colors.green[900])),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                height: 60,
                onPressed: () {
                  setState(() {
                    _loading = !_loading;
                    _updateProgress();
                    Fluttertoast.showToast(
                        msg: 'Please Wait Hacker is finding user');
                  });
                  Timer(
                      Duration(seconds: 8),
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AfterSplashScreen())));
                },
                child: Image.asset(
                  'assets/images/buttonicon.png',
                  color: Colors.red,
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // this function updates the progress value
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.1;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          return;
        }
      });
    });
  }
}
