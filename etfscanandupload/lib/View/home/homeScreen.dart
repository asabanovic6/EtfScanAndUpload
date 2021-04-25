import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/API/api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _fetchHomepageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Authentication',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auhentication'),
        ),
        body: Center(
          child: Text('Succesful Authentication'),
        ),
      ),
    );
  }
}

_fetchHomepageInfo() async {
  var response = await Api.currentPerson();
  if (response.statusCode == 200) {
    //ovdje uzeti aktivne zadace za person
  }
}
