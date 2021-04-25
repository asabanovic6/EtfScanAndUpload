import 'package:flutter/material.dart';
import 'package:etfscanandupload/View/home/homeScreen.dart';
import 'package:etfscanandupload/View/login/widgets/button.dart';
import 'package:etfscanandupload/View/login/widgets/email.dart';
import 'package:etfscanandupload/View/login/widgets/password.dart';
import 'package:etfscanandupload/View/login/widgets/welcome.dart';
import 'package:etfscanandupload/View/login/widgets/title.dart' as title;

import 'widgets/title.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white , Color.fromARGB(255, 0, 102, 204)]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  title.Title(),
                  TextLogin(),
                ]),
                InputEmail(),
                PasswordInput(),
                ButtonLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [HomeScreen()],
      ),
    );
  }
}
