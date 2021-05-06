import 'package:flutter/material.dart';
import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/View/homework/homeworksScreen.dart';
import 'package:etfscanandupload/View/login/loginScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

List<Map> drawerItems = [
  {'icon': Icons.book, 'title': 'Zadaće'},
  {'icon': Icons.camera, 'title': 'Scanner'}
];

class _DrawerScreenState extends State<DrawerScreen> {
  String _nameSurname = "Etf Scan & Upload";
  Person _currentPerson;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserNameSurname();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.blue]),
      ),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: Image.asset('image/user_icon.png').image,
                  backgroundColor: Colors.transparent,
                  radius: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _nameSurname,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 80),
            Column(
              children: drawerItems
                  .map((element) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              element['icon'],
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              child: Text(element['title'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onPressed: () => {
                                if (element['title'] == 'Zadaće')
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeworksPage(_currentPerson)))
                                  }
                              },
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                TextButton(
                  onPressed: () async {
                    await Credentials.deleteTokens();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Odjavi se',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _fetchUserNameSurname() async {
    var response = await Api.currentPerson();
    if (response.statusCode == 200) {
      Person person = Person.fromJson(response.data);
      setState(() {
        _currentPerson = person;
        _nameSurname =
            person.name + " " + person.surname;
      });
    }
  }
}
