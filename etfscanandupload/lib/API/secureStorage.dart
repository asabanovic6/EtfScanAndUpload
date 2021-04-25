import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Credentials {
  static final storage = FlutterSecureStorage();
  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    await storage.deleteAll();
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  static Future<String> getRefreshToken() async {
    return await storage.read(key: 'refreshToken');
  }

  static Future<void> deleteTokens() async {
    await storage.deleteAll();
  }

  static Future<bool> refreshTokens() async {
    String _refreshToken = await getRefreshToken();
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://sso.etf.unsa.ba/auth/realms/etf.unsa.ba/protocol/openid-connect/token'));
    request.bodyFields = {
      'client_id': 'admin-cli',
      'grant_type': 'refresh_token',
      'refresh_token': _refreshToken
    };
    request.headers.addAll(headers);

    http.StreamedResponse sResponse = await request.send();
    var response = await http.Response.fromStream(sResponse);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      await Credentials.saveTokens(
          responseBody['access_token'], responseBody['refresh_token']);
      return true;
    } else {
      deleteTokens();
      return false;
    }
  }
}
