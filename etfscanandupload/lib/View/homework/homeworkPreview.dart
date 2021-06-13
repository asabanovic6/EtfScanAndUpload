import 'dart:core';

import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/View/homework/homeworksScreen.dart';
import 'package:etfscanandupload/View/upload/uploadSolution.dart';
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

  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        //view PDF
        appBar: AppBar(
          title: Text("Pregled rješenja"),
          backgroundColor: Colors.blue.shade800,
          toolbarHeight: 70,
          leading: TextButton(
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeworksPage()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.upload_file,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                _sendFile();
              },
            )
          ],
        ),
        path: _path);
  }

  Future<void> _sendFile() async {
    var response = await Api.sendFile(
        _studentId, _asgn, _homework.homework.id, _file, _fileName);
    if (response.statusCode == 201) {
      _checkUpload();
    } else {
      _upload = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SolutionPage(_file, _path, _fileName, "0",
                  _studentId, _asgn, _homework, _courseId, _upload)));
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
          //Ovdje je uspjelo
          _upload = true;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SolutionPage(
                    _file,
                    _path,
                    _fileName,
                    getHomework.filesize,
                    _studentId,
                    _asgn,
                    _homework,
                    _courseId,
                    _upload),
              ));
        } else {
          _upload = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SolutionPage(
                      _file,
                      _path,
                      _fileName,
                      getHomework.filesize,
                      _studentId,
                      _asgn,
                      _homework,
                      _courseId,
                      _upload)));
        }
      });
    }
  }

  String getFileSize(String size) {
    return size.substring(0, size.length - 3);
  }
}
