import 'dart:io';
import 'dart:typed_data';

import 'package:etfscanandupload/Model/homework.dart';
import 'package:etfscanandupload/View/pdfCreator/creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:etfscanandupload/View/scanner/filters.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';

class ImageEditorPage extends StatefulWidget {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  File _newImage;

  ImageEditorPage(int studentId, int asgn, Homework homework, List<File> images,
      File newImage) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
    _newImage = newImage;
  }

  @override
  _ImageEditorState createState() =>
      _ImageEditorState(_studentId, _asgn, _homework, _images, _newImage);
}

class _ImageEditorState extends State<ImageEditorPage> {
  int _studentId;
  int _asgn;
  Homework _homework;
  List<File> _images;
  File _newImage;
  final GlobalKey _globalKey = GlobalKey();
  final List<List<double>> filters = [
    SEPIA_MATRIX,
    GREYSCALE_MATRIX,
    VINTAGE_MATRIX,
    SWEET_MATRIX
  ];

  _ImageEditorState(int studentId, int asgn, Homework homework,
      List<File> images, File newImage) {
    _studentId = studentId;
    _asgn = asgn;
    _homework = homework;
    _images = images;
    _newImage = newImage;
  }

  void convertWidgetToImage() async {
    RenderRepaintBoundary repaintBoundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    var buffer = byteData.buffer;
    String fileName = _homework.homework.name +
        "_Image_" +
        _images.length.toString() +
        ".png";

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
        file.writeAsBytes(
            buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
        _images.add(file);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CreatorPage(_studentId, _asgn, _homework, _images)));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    final Image image = Image.file(
      _newImage,
      //   width: size.width,
      fit: BoxFit.cover,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Filters",
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: convertWidgetToImage)
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            child: PageView.builder(
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.matrix(filters[index]),
                    child: image,
                  );
                }),
          ),
        ),
      ),
    );
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
