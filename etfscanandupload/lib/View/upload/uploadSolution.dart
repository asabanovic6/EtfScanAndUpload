import 'dart:convert';

import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/View/home/menu.dart';
import 'package:etfscanandupload/View/homework/homeworkPreview.dart';
import 'package:etfscanandupload/View/homework/homeworksScreen.dart';
import 'package:etfscanandupload/View/upload/uploadSolution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'dart:io';
import 'package:filesize/filesize.dart';
import 'dart:developer';

import 'package:path_provider/path_provider.dart';

class SolutionPage extends StatefulWidget {
  File _file;
  String _path;
  String _fileName;
  String _fileSize;
  int _studentId;
  int _asgn;
  Homework _homework;
  int _courseId;
  bool _uploaded;
  SolutionPage(File file, String path, String fileName, String fileSize,
      int studentId, int asgn, Homework homework, int courseId, bool uploaded) {
    _file = file;
    _path = path;
    _fileName = fileName;
    _fileSize = fileSize;
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _courseId = courseId;
    _uploaded = uploaded;
  }

  @override
  _SolutionPageState createState() => _SolutionPageState(_file, _path,
      _fileName, _fileSize, _studentId, _asgn, _homework, _courseId, _uploaded);
}

class _SolutionPageState extends State<SolutionPage> {
  File _file;
  String _path;
  String _fileName;
  String _fileSize;
  int _studentId;
  int _asgn;
  Homework _homework;
  int id;
  int _courseId;
  bool _uploaded;
  _SolutionPageState(File file, String path, String fileName, String fileSize,
      int studentId, int asgn, Homework homework, int courseId, bool uploaded) {
    _file = file;
    _path = path;
    _fileName = fileName;
    _fileSize = fileSize;
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _courseId = courseId;
    id = _homework.homework.id;
    _uploaded = uploaded;
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
                toolbarHeight: 70,
                centerTitle: true,
                elevation: 0,
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getImageWidget(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[]),
                (_uploaded)
                    ? (Text(
                        'Zadatak je uspješno poslan!' + '\n',
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))
                    : (Text(
                        'Došlo je do greške, zadatak nije poslan!' + '\n',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                Text(
                  'File: ' + '$_fileName' + '\n',
                  style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Veličina: ' + '$_fileSize' + '\n',
                  style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                (_uploaded)
                    ? (TextButton(
                        child: Text("OK",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          ImageCache().clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeworksPage(),
                              ));
                        }))
                    : (TextButton(
                        child: Text("Pokušaj ponovo",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewerInfoPage(
                                    _file,
                                    _path,
                                    _fileName,
                                    true,
                                    _studentId,
                                    _asgn,
                                    _homework,
                                    _courseId),
                              ));
                        })),
                SizedBox(width: 10),
              ]),
        ],
      ),
    );
  }

  Widget getImageWidget() {
    return Icon(Icons.assignment, color: Colors.blue.shade800, size: 120);
  }
}
