import 'dart:io';
import 'dart:math';
import 'package:etfscanandupload/View/homework/homeworkPreview.dart';
import 'package:etfscanandupload/View/scanner/scanner.dart';
import 'package:flutter/material.dart';

import 'package:etfscanandupload/Model/homework.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class CreatorPage extends StatefulWidget {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  int _courseId;

  CreatorPage(int studentId, int asgn, Homework homework, List<File> images,
      int courseId) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
    _courseId = courseId;
  }

  @override
  _CreatorState createState() =>
      _CreatorState(_studentId, _asgn, _homework, _images, _courseId);
}

class _CreatorState extends State<CreatorPage> {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  File scannedDocument;
  int _courseId;
  var pdf = pw.Document();
  _CreatorState(int studentId, int asgn, Homework homework, List<File> images,
      int courseId) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
    _courseId = courseId;
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
      return new Image.file(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rješenja: "),
        backgroundColor: Colors.blue.shade800,
        toolbarHeight: 70,
        leading: TextButton(
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScannerPage(
                    _studentId, _asgn, _homework, _images, _courseId)));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.picture_as_pdf_outlined,
              color: Colors.white,
              size: 37,
            ),
            onPressed: () {
              createPDF();
              savePdf();
            },
          )
        ],
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
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.blue.shade800,
            elevation: 50,
        child: Icon(
          Icons.playlist_add_rounded,
              color: Colors.white,
              size: 55,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScannerPage(
                  _studentId, _asgn, _homework, _images, _courseId)));
        },
      ),
        ),
      ),
    );
  }

  createPDF() async {
    for (var img in _images) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
    _images.clear();
  }

  savePdf() async {
    String fileName = _homework.homework.name + " " + _asgn.toString() + ".pdf";

    Directory directory;
    try {
      if (await _requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory();
        String newPath = "";
        print(directory);
        List<String> paths = directory.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/ETFApp";
        directory = Directory(newPath);
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        String filePath = directory.path + "/$fileName";
        File file = File(filePath.toString());
        await file.writeAsBytes(await pdf.save());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewerInfoPage(file, filePath, fileName, true,
                _studentId, _asgn, _homework, _courseId)));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
