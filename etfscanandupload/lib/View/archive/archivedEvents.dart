import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/Model/course.dart';
import 'package:etfscanandupload/Model/courseUnit.dart';
import 'package:etfscanandupload/Model/homeworkInfo.dart';
import 'package:etfscanandupload/Model/score.dart';
import 'package:etfscanandupload/View/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/homeworksInfo.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/View/homework/homeworkInformation.dart';
import 'dart:core';

class ArchivedEventsPage extends StatefulWidget {
  Person _currentPerson;
  Course _course;
  ArchivedEventsPage(Person currentPerson, Course course) {
    _currentPerson = currentPerson;
    _course = course;
  }
  @override
  _ArchivedEventsState createState() =>
      _ArchivedEventsState(_currentPerson, _course);
}

class _ArchivedEventsState extends State<ArchivedEventsPage> {
  List<HomeworkInfo> _homeworks = [];
  Person _currentPerson;
  Course _course;
  Course _courseDetails;
  Score _homeworkActivity;

  _ArchivedEventsState(Person currentPerson, Course course) {
    _currentPerson = currentPerson;
    _course = course;
  }
  @override
  void initState() {
    super.initState();
    _fetchCourseDetails();
  }

  Future<void> _fetchCourseDetails() async {
    var response = await Api.getDetailsOfCourse(
        _course.courseOffering.courseUnit.id,
        _currentPerson.id,
        _course.courseOffering.academicYear.id);
    if (response.statusCode == 200) {
      _courseDetails = Course.fromJson(response.data);
      _courseDetails.score.forEach((score) {
        if (score.courseActivity.name == 'Zadaće') {
          setState(() {
            _homeworkActivity = score;
            _fetchHomeworks();
          });
        }
      });
    }
  }

  _fetchHomeworks() {
    bool contain = false;
    for (int i = 0; i < _homeworkActivity.details.length; i++) {
      for (int j = 0; j < _homeworks.length; j++) {
        if (_homeworks[j].name == _homeworkActivity.details[i].homework.name) {
          contain = true;
          break;
        }
      }
      if (contain == false) {
        _homeworks.add(_homeworkActivity.details[i].homework);
      }
      contain = false;
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
                  child: AppBar(
                    backgroundColor: Colors.blue.shade800,
                    toolbarHeight: 100,
                    title: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '\nArhivirani događaji: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    leading: TextButton(
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPage()));
                        }),
                    centerTitle: true,
                    elevation: 0,
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

  Widget getImageWidget() {
    return Icon(Icons.error_outline_outlined, color: Colors.white, size: 120);
  }

  Widget _buildActiveHomeworks() {
    return (_homeworkActivity != null)
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                itemCount: _homeworks.length,
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
                          _course.courseOffering.courseUnit.abbrev,
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
                                    "Naziv: " + _homeworks[index].name,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Rok: " + _homeworks[index].deadline,
                                      style: TextStyle(color: Colors.white))
                                ],
                              )
                            ]),
                        trailing: TextButton(
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 30.0),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeworkInfoPage(
                                    _homeworks[index].id,
                                    _homeworks[index].courseUnit.id,
                                    _homeworks[index].nrAssignments,
                                    _currentPerson,
                                    true)));
                          },
                        ),
                      ),
                    ),
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchCourseDetails();
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
