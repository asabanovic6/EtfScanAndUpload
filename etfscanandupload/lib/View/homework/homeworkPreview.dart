import 'dart:core';

import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/View/homework/homeworksScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'dart:io';
import 'package:filesize/filesize.dart';
import 'dart:developer';
import 'package:path_provider/path_provider.dart';

class ViewerInfoPage extends StatefulWidget {
  File _file;
  String _path;
  String _fileName;
  bool _uploadOption;
  int _studentId;
  int _asgn;
  Homework _homework;
  int _courseId;

  ViewerInfoPage(File file, String path, String fileName, bool uploadOption,
      int studentId, int asgn, Homework homework, int courseId) {
    _file = file;
    _path = path;
    _fileName = fileName;
    _uploadOption = uploadOption;
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _courseId = courseId;
  }

  @override
  _ViewerInfoPageState createState() => _ViewerInfoPageState(_file, _path,
      _fileName, _uploadOption, _studentId, _asgn, _homework, _courseId);
}

class _ViewerInfoPageState extends State<ViewerInfoPage> {
  File _file;
  String _path;
  String _fileName;
  bool _loading;
  bool _uploadOption;
  int _studentId;
  int _asgn;
  Homework _homework;
  int id;
  int _courseId;
  bool _upload = false;
  Person _currentPerson;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _ViewerInfoPageState(
      File file,
      String path,
      String fileName,
      bool uploadOption,
      int studentId,
      int asgn,
      Homework homework,
      int courseId) {
    _file = file;
    _path = path;
    _fileName = fileName;
    _uploadOption = uploadOption;
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _courseId = courseId;
    id = _homework.homework.id;
  }
  @override
  void initState() {
    super.initState();

    _fetchPerson();
  }

  _fetchPerson() async {
    var response = await Api.getPersonById(_studentId);
    if (response.statusCode == 200) {
      Person person = Person.fromJson(response.data);
      setState(() {
        _currentPerson = person;
      });
    }
  }

  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        key: _scaffoldKey,
        //view PDF
        appBar: AppBar(
          title: Text("Pregled rješenja"),
          backgroundColor: Colors.blue.shade800,
          toolbarHeight: 70,
          leading: TextButton(
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(
                  context);
            },
          ),
          actions: <Widget>[
         
          ],
        ),
        path: _path);
  }

 
}
