import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/View/login/loginScreen.dart';
import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:http/http.dart' as http;

// import 'package:zamgerapp/widgets/widgets.dart';

void main() => runApp(ZamgerApp());

final GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();

class ZamgerApp extends StatelessWidget {
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

Future<Widget> checkAPPCredentials() async {
  String accessToken = await Credentials.getAccessToken();
  String refreshToken = await Credentials.getRefreshToken();
  if (accessToken == null || refreshToken == null) {
    return LoginPage();
  } else {
    var headers = {'Authorization': 'Bearer ' + accessToken};
    var request = http.Request(
        'GET', Uri.parse('https://zamger.etf.unsa.ba/api_v6/person'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Api();
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
