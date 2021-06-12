import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/homeworksInfo.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/View/homework/homeworkInformation.dart';
import 'dart:core';

class HomeworksPage extends StatefulWidget {
  @override
  _HomeworksState createState() => _HomeworksState();
}

class _HomeworksState extends State<HomeworksPage> {
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
      setState(() {
        _currentPerson = person;
        _nameSurname = person.name + " " + person.surname;
        _email = person.email;
        _lastAcces = person.lastAccess;
        _fetchActiveHomeworks();
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
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
                              fontSize: 16,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\n' + _email,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: '\n' + '\nAktivni događaji: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                      centerTitle: true,
                      elevation: 0,
                      leading: TextButton(
                        child:
                            Icon(Icons.logout, color: Colors.white, size: 40),
                        onPressed: () async {
                          await Credentials.deleteTokens();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildActiveHomeworks()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchActiveHomeworks() async {
    var response = await Api.getUpcomingHomeworks(_currentPerson.id);
    if (response.statusCode == 200) {
      setState(() {
        _homeworks = HomeworksInfo.fromJson(response.data);
      });
    }
  }

  Widget _buildActiveHomeworks() {
    return (_homeworks != null)
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                itemCount: _homeworks.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue.shade300,
                              Colors.blue.shade900
                            ]),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: Icon(
                            Icons.hourglass_bottom_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          _homeworks.results[index].courseUnit.abbrev,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                children: <Widget>[
                                  Text(
                                    "Naziv: " + _homeworks.results[index].name,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                      "Rok: " +
                                          _homeworks.results[index].deadline,
                                      style: TextStyle(color: Colors.white))
                                ],
                              )
                            ]),
                        trailing: TextButton(
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.orange, size: 30.0),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeworkInfoPage(
                                    _homeworks.results[index].id,
                                    _homeworks.results[index].courseUnit.id,
                                    _homeworks.results[index].nrAssignments,
                                    _currentPerson)));
                          },
                        ),
                      ),
                    ),
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchActiveHomeworks();
              });
            },
          )
        : Container(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Nema aktivnih događaja',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
  }
}
