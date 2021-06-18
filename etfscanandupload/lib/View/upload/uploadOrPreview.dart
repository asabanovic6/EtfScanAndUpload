import 'dart:core';

import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/View/homework/homeworkPreview.dart';
import 'package:etfscanandupload/View/homework/homeworksScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'dart:io';
import 'package:filesize/filesize.dart';
import 'dart:developer';
import 'package:path_provider/path_provider.dart';

class UploadOrPreviewPage extends StatefulWidget {
  File _file;
  String _path;
  String _fileName;
  bool _uploadOption;
  int _studentId;
  int _asgn;
  Homework _homework;
  int _courseId;

  UploadOrPreviewPage(
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
  }

  @override
  _UploadOrPreviewPageState createState() => _UploadOrPreviewPageState(_file,
      _path, _fileName, _uploadOption, _studentId, _asgn, _homework, _courseId);
}

class _UploadOrPreviewPageState extends State<UploadOrPreviewPage> {
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
  _UploadOrPreviewPageState(
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

  Widget getImageWidget() {
    return Icon(Icons.assignment_ind_outlined,
        color: Colors.blueAccent.shade100, size: 120);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              backgroundColor: Colors.blue.shade800,
              toolbarHeight: 100,
              title: Text("\n Vaše rješenje je spremno! "),
              centerTitle: true,
              elevation: 0,
              leading: TextButton(
                child: Icon(Icons.arrow_back_ios, color: Colors.white30),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeworksPage(
                              _currentPerson,
                              _upload,
                              _fileName,
                              filesize(_file.lengthSync(), 0))));
                },
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getImageWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size(100, 100), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue.shade700, // button color
                      child: InkWell(
                        splashColor: Colors.white30, // splash color
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewerInfoPage(
                                  _file,
                                  _path,
                                  _fileName,
                                  true,
                                  _studentId,
                                  _asgn,
                                  _homework,
                                  _courseId)));
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.picture_as_pdf_outlined,
                                color: Colors.white30, size: 50), // icon
                            Text("Pregled" + '\n' + "rješenja",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white30)), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(100, 100), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue.shade700, // button color
                      child: InkWell(
                        splashColor: Colors.white30, // splash color
                        onTap: () {
                          _sendFile();
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.upload_file,
                                color: Colors.white30, size: 50), // icon
                            Text("Pošalji" + '\n' + "rješenje",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white30)), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Center(),
      ],
    ));
  }

  Future<void> _sendFile() async {
    try {
      var response = await Api.sendFile(
          _studentId, _asgn, _homework.homework.id, _file, _fileName);
      if (response.statusCode == 201) {
        _checkUpload();
      } else {
        _sendFile();
      }
    } catch (e) {
      _sendFile();
    }
  }

  Future<void> _checkUpload() async {
    var response = await Api.getHomework(
        _homework.homework.id, _asgn, _courseId, _studentId);
    if (response.statusCode == 200) {
      setState(() {
        Homework getHomework = Homework.fromJson(response.data);
        if (getHomework.filename.length == _fileName.length &&
            (int.parse(getFileSize(getHomework.filesize)) -
                        int.parse(getFileSize(filesize(_file.lengthSync(), 0))))
                    .abs() <=
                1) {
          showAlertDialogSuccess(context);
        } else {
          _sendFile();
        }
      });
    }
  }

  String getFileSize(String size) {
    return size.substring(0, size.length - 3);
  }

  showAlertDialogSuccess(BuildContext context) {
    _upload = true;
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Rješenje je poslano!"),
      content: Text("Rješenje: $_fileName" +
          '\n' +
          "Veličina: " +
          filesize(_file.lengthSync(), 0)),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
