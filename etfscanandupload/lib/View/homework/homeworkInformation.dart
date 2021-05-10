import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/Model/homeworks.dart';

class HomeworkInfoPage extends StatefulWidget {
  int _courseId;
  int _homeworkId;
  int _nrAssignments;
  Person _currentPerson;

  HomeworkInfoPage(
      int homeworkId, int courseId, int nrAssignments, Person currentPerson) {
    _courseId = courseId;
    _homeworkId = homeworkId;
    _nrAssignments = nrAssignments;
    _currentPerson = currentPerson;
  }

  @override
  _HomeworkInfoPageState createState() => _HomeworkInfoPageState(
      _homeworkId, _courseId, _nrAssignments, _currentPerson);
}

class _HomeworkInfoPageState extends State<HomeworkInfoPage> {
  int _courseId;
  int _homeworkId;
  int _nrAssignments;
  Person _currentPerson;
  List<Homework> _asignments = [];

  Homework _homework;
  _HomeworkInfoPageState(
      int homeworkId, int courseId, int nrAssignments, Person currentPerson) {
    _courseId = courseId;
    _homeworkId = homeworkId;
    _nrAssignments = nrAssignments;
    _currentPerson = currentPerson;
  }

  @override
  void initState() {
    super.initState();
    _fetchHomeworkInfo();
  }

  Future<void> _fetchHomeworkInfo() async {
    var response =
        await Api.getHomework(_homeworkId, 1, _courseId, _currentPerson.id);
    if (response.statusCode == 200) {
      setState(() {
        _homework = Homework.fromJson(response.data);
        _fetchAsignments();
      });
    }
  }

  Future<void> _fetchAsignments() async {
    List<Homework> allAsignments = [];
    for (int i = 1; i <= _nrAssignments; i++) {
      Homework asignment;
      var response =
          await Api.getHomework(_homeworkId, i, _courseId, _currentPerson.id);
      if (response.statusCode == 200) {
        asignment = Homework.fromJson(response.data);
        allAsignments.add(asignment);
      }
    }
    setState(() {
      _asignments = allAsignments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _homework != null
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0),
              elevation: 0,
              leading: TextButton(
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.white, Colors.blue]),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      _homework.homework.courseUnit.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        'Naziv zadaće: ' +
                                            _homework.homework.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        'Rok: ' + _homework.homework.deadline,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        'Ostvareno bodova: ' +
                                            _homework.score.toString() +
                                            ' / ' +
                                            _homework.homework.maxScore
                                                .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _buildFeaturesSection(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildFeaturesSection() {
    return Wrap(
      children: _asignments
          .map((item) => Text(item.id.toString()))
          .toList()
          .cast<Widget>(),
    );
  }
}
