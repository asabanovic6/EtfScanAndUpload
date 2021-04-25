import 'package:flutter/material.dart';


class Title extends StatefulWidget {
  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<Title> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 40),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'Etf scan & upload',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 76, 153),
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          )),
    );
  }
}
