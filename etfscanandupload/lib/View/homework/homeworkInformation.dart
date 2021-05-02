import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/Model/homework.dart';

class HomeworkInfoPage extends StatefulWidget {
  int _courseId;
  int _homeworkId;
  Person _currentPerson;

  HomeworkInfoPage(int homeworkId, int courseId, Person currentPerson) {
    _courseId = courseId;
    _homeworkId = homeworkId;
    _currentPerson = currentPerson;
  }

  @override
  _HomeworkInfoPageState createState() =>
      _HomeworkInfoPageState(_homeworkId, _courseId, _currentPerson);
}

class _HomeworkInfoPageState extends State<HomeworkInfoPage> {
  int _courseId;
  int _homeworkId;
  Person _currentPerson;
  Homework _homework;
  _HomeworkInfoPageState(int homeworkId, int courseId, Person currentPerson) {
    _courseId = courseId;
    _homeworkId = homeworkId;
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
      });
    }
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
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      child: Text(
                                        'Naziv zadaće: ' +
                                            _homework.homework.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
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
    return Wrap(children: [
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.7),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Rok: ' + _homework.homework.deadline,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.score,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Ostvareno bodova: ' +
                        _homework.score.toString() +
                        ' / ' +
                        _homework.homework.maxScore.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.user,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    _homework.author.id == null
                        ? 'Autor: Zadaća nije pregledana'
                        : 'Autor: ' + _homework.author.email,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Wrap(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.comment,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    _homework.comment == null
                        ? 'Komentar: Zadaća nije pregledana'
                        : 'Komentar: ' + _homework.comment,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      SizedBox(
        width: 10,
      )
    ]);
  }
}
