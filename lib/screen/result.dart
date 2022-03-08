import 'package:facebookhack/screen/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      AlertDialogMsg(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TopImage(),
            Text(
              'Please try later or an another device thanks for your patience.',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 50,
              minWidth: 150,
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Logout'),
            ),
          ],
        )),
      ),
    );
  }
}

AlertDialogMsg(context) {
  Alert(
    context: context,
    title: "Sorry !",
    desc: "Issues ! Some Technical Issue Detected...",
    style: AlertStyle(
        descStyle: TextStyle(color: Colors.red[900]),
        titleStyle: TextStyle(
            color: Colors.red[900], fontWeight: FontWeight.bold, fontSize: 20)),
    image: Image.asset("assets/images/warning.png"),
  ).show();
}

class TopImage extends StatelessWidget {
  const TopImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: TweenAnimationBuilder(
            duration: Duration(seconds: 10),
            tween: ColorTween(begin: Colors.white, end: Colors.red[900]),
            builder: (BuildContext context, Color? color, Widget? child) {
              return ColorFiltered(
                child: Image.asset(
                  'assets/images/skull.png',
                  color: Colors.white,
                ),
                colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
              );
            }),
      ),
    );
  }
}
