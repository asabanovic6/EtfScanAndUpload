import 'package:flutter/material.dart';

class TextLogin extends StatefulWidget {
  @override
  _TextLoginState createState() => _TextLoginState();
}

class _TextLoginState extends State<TextLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
            ),
            Center(
              child: Text(
                'Elektrotehnički fakultet Univerziteta u Sarajevu',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 0, 76, 153),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '© Amina Šabanović',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
