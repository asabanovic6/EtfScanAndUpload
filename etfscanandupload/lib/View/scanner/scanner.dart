import 'dart:io';

import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/View/pdfCreator/creator.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ScannerPage extends StatefulWidget {
  int _studentId;
  int _asgn;
Homework _homework;
  List<File> _images;

  ScannerPage(int studentId, int asgn, Homework homework, List<File> images) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
  }

  @override
  _ScannerState createState() =>
      _ScannerState(_studentId, _asgn, _homework, _images);
}

class _ScannerState extends State<ScannerPage> {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  File scannedDocument;
  File _selectedFile;
  bool _inProcess = false;

  _ScannerState(int studentId, int asgn, Homework homework, List<File> images) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
  }

  Widget getImageWidget() {
    return Icon(Icons.camera_alt_outlined, color: Colors.white70, size: 120);
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: source, maxHeight: 480, maxWidth: 640);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blue,
            toolbarTitle: "RPS Cropper",
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.blue,
            backgroundColor: Colors.white,
          ));
      _images.add(cropped);
      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              CreatorPage(_studentId, _asgn, _homework, _images)));
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getImageWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                    color: Colors.blue,
                    child: Text(
                      "Camera",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    }),
                MaterialButton(
                    color: Colors.blue,
                    child: Text(
                      "Device",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    })
              ],
            )
          ],
        ),
        (_inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(),
      ],
    ));
  }
}
