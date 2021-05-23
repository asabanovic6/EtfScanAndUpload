import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'dart:io';

class ViewerInfoPage extends StatefulWidget {
  File _file;
  String _path;
  String _fileName;

  ViewerInfoPage(File file, String path, String fileName) {
    _file = file;
    _path = path;
    _fileName = fileName;
  }

  @override
  _ViewerInfoPageState createState() =>
      _ViewerInfoPageState(_file, _path, _fileName);
}

class _ViewerInfoPageState extends State<ViewerInfoPage> {
  File _file;
  String _path;
  String _fileName;
  bool _loading;

  _ViewerInfoPageState(File file, String path, String fileName) {
    _file = file;
    _path = path;
    _fileName = fileName;
  }

  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        //view PDF
        appBar: AppBar(
          title: Text("Dokument: " + _fileName),
          backgroundColor: Colors.blue,
        ),
        path: _path);
  }
}
