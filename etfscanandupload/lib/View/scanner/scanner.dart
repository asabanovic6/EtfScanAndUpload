import 'dart:io';

import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/View/scanner/imageEditor.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ScannerPage extends StatefulWidget {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  int _courseId;

  ScannerPage(int studentId, int asgn, Homework homework, List<File> images,
      int courseId) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
    _courseId = courseId;
  }

  @override
  _ScannerState createState() =>
      _ScannerState(_studentId, _asgn, _homework, _images, _courseId);
}

class _ScannerState extends State<ScannerPage> {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  File scannedDocument;
  File _selectedFile;
  bool _inProcess = false;
  int _courseId;

  _ScannerState(int studentId, int asgn, Homework homework, List<File> images,
      int courseId) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
    _courseId = courseId;
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
            toolbarColor: Colors.blue.shade800,
            toolbarTitle: "",
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.blue.shade800,
            backgroundColor: Colors.white,
          ));
      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ImageEditorPage(
              _studentId, _asgn, _homework, _images, cropped, _courseId)));
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
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              backgroundColor: Colors.blue.shade800,
              toolbarHeight: 100,
              title: Text("\n Učitaj rješenje "),
              centerTitle: true,
              elevation: 0,
              leading: TextButton(
                child: Icon(Icons.arrow_back_ios, color: Colors.white30),
                onPressed: () {
                  Navigator.pop(context);
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
                  size: Size(90, 90), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue.shade700, // button color
                      child: InkWell(
                        splashColor: Colors.white30, // splash color
                        onTap: () {
                          getImage(ImageSource.camera);
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.camera_alt_outlined,
                                color: Colors.white30, size: 50), // icon
                            Text("Camera",
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
                  size: Size(90, 90), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue.shade700, // button color
                      child: InkWell(
                        splashColor: Colors.white30, // splash color
                        onTap: () {
                          getImage(ImageSource.gallery);
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.folder_open_outlined,
                                color: Colors.white30, size: 50), // icon
                            Text("Device",
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
