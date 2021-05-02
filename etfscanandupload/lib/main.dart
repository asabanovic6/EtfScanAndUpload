import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/View/login/loginScreen.dart';
import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:http/http.dart' as http;

// import 'package:zamgerapp/widgets/widgets.dart';

void main() => runApp(EtfScanAndUpload());

final GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();

class EtfScanAndUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      routes: {"/login": (context) => LoginPage()},
      title: 'Zamger App',
      home: AnimatedSplashScreen.withScreenFunction(
          splash: Image.asset('images/etf.png'),
          splashTransition: SplashTransition.fadeTransition,
          screenFunction: () async => checkAPPCredentials()),
      debugShowCheckedModeBanner: false,
    );
  }
}


