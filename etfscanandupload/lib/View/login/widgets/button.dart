import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:http/http.dart' as http;

import '../loginScreen.dart';

class ButtonLogin extends StatefulWidget {
  @override
  ButtonLoginState createState() => ButtonLoginState();
}

class ButtonLoginState extends State<ButtonLogin> {
  static final usernameController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(
                0.0,
                0.0,
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () async =>
              loginUser(usernameController.text, passwordController.text),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Prijava',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> loginUser(String username, String password) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://sso.etf.unsa.ba/auth/realms/etf.unsa.ba/protocol/openid-connect/token'));
    request.bodyFields = {
      'username': username,
      'password': password,
      'grant_type': 'password',
      'client_id': 'admin-cli'
    };
    request.headers.addAll(headers);

    http.StreamedResponse sResponse = await request.send();
    var response = await http.Response.fromStream(sResponse);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      await Credentials.saveTokens(
          responseBody['access_token'], responseBody['refresh_token']);
      Api();
      usernameController.text = '';
      passwordController.text = '';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      usernameController.text = '';
      passwordController.text = '';
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Pogrešan unos"),
      content: Text("Pogrešna lozinka ili korisničko ime."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
