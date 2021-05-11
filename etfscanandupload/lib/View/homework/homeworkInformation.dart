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
    _fetchAsignments();
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
                            backgroundColor: Colors.blue,
                            toolbarHeight: 100,
                            title: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: _homework.homework.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '\n' +
                                          _homework.homework.courseUnit.abbrev,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\nRok: ' +
                                          _homework.homework.deadline,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                     TextSpan(
                                      text: '\nMogući bodovi: ' +
                                          _homework.homework.maxScore
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ]),
                            ),
                            centerTitle: true,
                            leading: TextButton(
                              child: Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                      ),
                    ),
                  ),
                      ),
                      Expanded(child: _buildFeaturesSection()),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildFeaturesSection() {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
        itemCount: _asignments.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, Colors.blue]),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: _asignments[index].filename != null
                      ? _asignments[index].score == 0
                          ? TextButton(
                              child: Icon(
                                Icons.assignment_turned_in_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                                onPressed: () {
                                //Ovdje ide dio koda za spremanje file-a
                              })
                          : TextButton(
                              child: Icon(
                                Icons.assignment_turned_in_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                //Ovdje ide dio koda za spremanje file-a
                              })
                      : Icon(
                          Icons.lightbulb_outline_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                ),
                title: Text(
                  'Zadatak ' + (index + 1).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Text(
                            "Bodovi: " + _asignments[index].score.toString(),
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          _asignments[index].filename != null
                              ? Text(
                                  "Rješenje: " +
                                      _asignments[index].filename +
                                      '\nVeličina: ' +
                                      _asignments[index].filesize +
                                      '\nTip datoteke: ' +
                                      _asignments[index].filetype +
                                      '\nVrijeme: ' +
                                      _asignments[index].time,
                                  style: TextStyle(color: Colors.white))
                              : Text("Rješenje nije poslano",
                                  style: TextStyle(color: Colors.white)),
                          
                        ],
                        
                      )
                    ]),
                trailing: TextButton(
                  child:
                      Icon(Icons.upload_file, color: Colors.white, size: 40.0),
                  onPressed: () {
                    //Ovdje cu otvoriti scanner
                  },
                ),
              ),
            ),
                  );
        });
  }
}

