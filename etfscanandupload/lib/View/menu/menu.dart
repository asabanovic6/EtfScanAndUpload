import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/Model/homeworksInfo.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/View/archive/courseUnits.dart';
import 'package:etfscanandupload/View/homework/homeworksScreen.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  HomeworksInfo _homeworks;
  Person _currentPerson;
  String _nameSurname = "";
  String _email = "";
  String _lastAcces = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserNameSurname();
    });
  }

  _fetchUserNameSurname() async {
    var response = await Api.currentPerson();
    if (response.statusCode == 200) {
      Person person = Person.fromJson(response.data);
      _currentPerson = person;
        _nameSurname = person.name + " " + person.surname;
       
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                backgroundColor: Colors.blue.shade800,
                toolbarHeight: 100,
                title: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: _nameSurname,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                     ),
                ),
                centerTitle: true,
                elevation: 0,
              ),
            ),
          ),
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[]),
              TextButton(
                  child: Text("Aktivni događaji",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade800),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue.shade800)))),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeworksPage(_currentPerson, true, null, null),
                        ));
                  }),
              Text(
                "",
              ),
              TextButton(
                  child: Text("Arhivirani događaji",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade800),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue.shade800)))),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyStudyPage(_currentPerson),
                        ));
                  }),
              Text(
                "",
              ),
              TextButton(
                child: Text("Odjavi se",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade800),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue.shade800)))),
                onPressed: () async {
                  await Credentials.deleteTokens();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
              ),
              SizedBox(width: 10),
            ]),
          )
        ],
      ),
    );
  }
}
