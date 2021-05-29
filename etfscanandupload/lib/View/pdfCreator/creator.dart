import 'dart:io';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:etfscanandupload/View/scanner/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:etfscanandupload/Model/homework.dart';

class CreatorPage extends StatefulWidget {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;

  CreatorPage(int studentId, int asgn, Homework homework, List<File> images) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
  }

  @override
  _CreatorState createState() =>
      _CreatorState(_studentId, _asgn, _homework, _images);
}

class _CreatorState extends State<CreatorPage> {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  File scannedDocument;
  List<Widget> _widgets = [];

  _CreatorState(int studentId, int asgn, Homework homework, List<File> images) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
  }
  void _removeImage(index) {
    this.setState(() {
      _images.removeAt(index);
    });
  }

  Widget _decideImageView(imageFile) {
    if (imageFile == null) {
      return Text("Slika nije spasena");
    } else {
      Widget widget = ColorFiltered(
        child: Image.file(
          imageFile,
        ),
        colorFilter: ColorFilter.mode(Colors.grey.shade100, BlendMode.color),
      );
      _widgets.add(widget);
      return widget;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Displaying Images"),
        leading: TextButton(
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ScannerPage(_studentId, _asgn, _homework, _images)));
          },
        ),
      ),
      body: (_images.length > 0)
          ? ListView.builder(
              itemBuilder: (BuildContext ctx, int index) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    shape:
                        Border.all(width: 2, color: Colors.blueGrey.shade100),
                    elevation: 20,
                    color: Colors.blueGrey.shade100,
                    child: Column(
                      children: <Widget>[
                        _decideImageView(_images[index]),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            child: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.white54,
                              size: 45,
                            ),
                            onPressed: () {
                              _removeImage(index);
                            }),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _images.length,
            )
          : Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Niti jedna slika nije spasena',
                  style: TextStyle(),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera,
          color: Colors.white24,
          size: 50,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ScannerPage(_studentId, _asgn, _homework, _images)));
        },
      ),
    );
  }
}
