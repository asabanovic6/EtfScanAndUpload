import 'package:etfscanandupload/View/homework/homeworksScreen.dart';
import 'package:etfscanandupload/View/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/View/login/widgets/button.dart';
import 'package:etfscanandupload/View/login/widgets/email.dart';
import 'package:etfscanandupload/View/login/widgets/password.dart';
import 'package:etfscanandupload/View/login/widgets/welcome.dart';
import 'package:etfscanandupload/View/login/widgets/title.dart' as title;
import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:http/http.dart' as http;

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
              colors: [Colors.blueAccent.shade100, Colors.white30]), 
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
        children: [MenuPage()],
      ),
    );
  }
}

Future<Widget> checkAPPCredentials() async {
  String accessToken = await Credentials.getAccessToken();
  String refreshToken = await Credentials.getRefreshToken();
  if (accessToken == null || refreshToken == null) {
    return LoginPage();
  } else {
    var headers = {'Authorization': 'Bearer ' + accessToken};
    var request = http.Request(
        'GET', Uri.parse('https://zamger.etf.unsa.ba/api_v6/person'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Api();
      return MenuPage();
    } else {
      return LoginPage();
    }
  }
}

