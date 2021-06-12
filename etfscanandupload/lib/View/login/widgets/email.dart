import 'package:flutter/material.dart';
import 'button.dart';

class InputEmail extends StatefulWidget {
  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: ButtonLoginState.usernameController,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 76, 153),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.indigo.shade900,
            labelText: 'Korisničko ime ili e-mail adresa :',
            labelStyle:
                TextStyle(
                color: Color.fromARGB(255, 0, 76, 153),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
