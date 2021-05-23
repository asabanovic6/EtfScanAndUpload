import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:etfscanandupload/API/secureStorage.dart';
import 'package:etfscanandupload/main.dart';

bool isFile = false;

class Api {
  static Dio client;

  Api() {
    client = new Dio(BaseOptions(
      baseUrl: 'https://zamger.etf.unsa.ba/api_v6',
    ));
    client.interceptors.add(AuthInterceptor());
  }

  static Future<Response<dynamic>> currentPerson() {
    final $url = '/person&resolve[]=ExtendedPerson';
    return client.get($url);
  }

  static Future<Response<dynamic>> getPersonById(int id) {
    final $url = '/person/$id';
    return client.get($url);
  }

  static Future<Response<dynamic>> getUpcomingHomeworks(int student) {
    final $url = '/homework/latest/$student&resolve[]=CourseUnit';
    return client.get($url);
  }

  static Future<Response<dynamic>> getCourse(int id) {
    final $url = '/course/$id';
    return client.get($url);
  }

  static Future<Response<dynamic>> getFileByHomeworkId(
      int homeworkId, int asgn, int student) {
    isFile = true;
    final $url = '/homework/$homeworkId/$asgn/student/$student/file';
    return client.get($url);
  }

  static Future<Response<dynamic>> getHomework(
      int homeworkId, int asgn, int courseId, int student) {
    final $url =
        '/homework/$homeworkId/$asgn/student/$student&resolve[]=Person&resolve[]=Homework&resolve[]=CourseUnit';
    return client.get($url);
  }

  static Future<Response<dynamic>> getStatusOfSubmittedHomeworkById(
      int homeworkId, int asgn, int student) {
    final $url = '/homework/$homeworkId/$asgn/student/$student';
    return client.get($url);
  }
}

class AuthInterceptor extends Interceptor {
  static final String BEARER = 'Bearer ';
  static final String AUTH = 'Authorization';

  @override
  Future onRequest(RequestOptions options) async {
    Api.client.lock();
    String accessToken = await Credentials.getAccessToken();
    Api.client.unlock();
    options.headers[AUTH] = BEARER + accessToken;
    //Ako ocekuje bytes kao response
    if (isFile) {
      options.responseType = ResponseType.bytes;
      isFile = false;
    } else {
      options.responseType = ResponseType.json;
    }
    return options;
  }

  @override
  Future onError(DioError error) async {
    //ako je pokušaj pao jer je istekao token
    if (error.type == DioErrorType.RESPONSE &&
        error.response.statusCode == 401) {
      Api.client.lock();
      if (!await Credentials.refreshTokens()) {
        Api.client.unlock();
        navigator.currentState
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
        return error;
      }
      Api.client.unlock();
      return _retryWithToken(error.request);
      //ako je ponovni pokušaj opet pao, morat će se redirectati na LoginPage
    } else {
      return error;
    }
  }

  Future<Response> _retryWithToken(RequestOptions originalRequest) async {
    originalRequest.headers[AUTH] = BEARER + await Credentials.getAccessToken();
    print("TOKEN JE REFRESHOVAN");
    return Api.client.request(originalRequest.path, options: originalRequest);
  }
}
