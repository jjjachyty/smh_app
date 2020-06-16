import 'dart:io';
import 'package:dio/dio.dart' as dio;

import 'event_bus.dart';
import 'init.dart';

var host = "http://122.112.151.97:9999/api/v1";
// var host = "http://192.168.31.43:9999/api/v1";

dio.Dio api;

class Response {
  bool State;
  String Code;
  String Message;
  dynamic Data;
  Response(this.State, this.Code, this.Message, this.Data);
  //不同的类使用不同的mixin即可
  Response.fromJson(Map<String, dynamic> json)
      : State = json["State"],
        Code = json["Code"],
        Message = json["Message"],
        Data = json["Data"];
}

Future<Response> post(
  String path,
  dynamic data,
) async {
  Response _data;
  try {
    print("token=${token}");

    var _response = await api.post(path, data: data);

    return Response.fromJson(_response.data);
  } on dio.DioError catch (e) {
    if (e.type == dio.DioErrorType.RECEIVE_TIMEOUT ||
        e.type == dio.DioErrorType.CONNECT_TIMEOUT) {
      _data = Response(false, "", "请求超时,请稍后重试", null);
    } else {
      _data = Response(false, "", e.message, null);
    }
  }
  print(_data.Message);
  return _data;
}

Future<Response> get(
  String path, {
  Map<String, dynamic> parameters,
}) async {
  Response _data;
  try {
    print("token=${token}");

    var _response = await api.get(path, queryParameters: parameters);
    return Response.fromJson(_response.data);
  } on dio.DioError catch (e) {
    if (e.type == dio.DioErrorType.RECEIVE_TIMEOUT ||
        e.type == dio.DioErrorType.CONNECT_TIMEOUT) {
      _data = Response(false, "", "请求超时,请稍后重试", null);
    } else {
      _data = Response(false, "", e.message, null);
    }
  }
  return _data;
}

///获取新token
Future<String> refreshToken(String token) async {
  String _token; //获取当前token

  try {
    var response =
        await dio.Dio(dio.BaseOptions(baseUrl: host, connectTimeout: 5000,
                // receiveTimeout: 50000,
                headers: {HttpHeaders.authorizationHeader: token}))
            .post("/base/refreshtoken");

    if (response.data["State"]) {
      _token = response.data['Data']['Token']; //获取返回的新token
      print('oldtoke=${token}   newToken:$_token');
    }
  } on dio.DioError catch (e) {
    if (e.response == null) {
      print('DioError:${e.message}');
    } else {
      if (e.response.statusCode == 422) {
        print('422Error:${e.response.data['msg']}');
        //422状态码代表异地登录，token失效，发送登录失效事件，以便app弹出登录页面
        eventBus.fire(ToLogin());
      }
    }
  }
  return _token;
}

initDio() {
  api = new dio.Dio(dio.BaseOptions(baseUrl: host, connectTimeout: 5000,
      // receiveTimeout: 5000,
      headers: {HttpHeaders.authorizationHeader: token}));

  api.interceptors
      .add(dio.InterceptorsWrapper(onResponse: (dio.Response response) async {
    print("onResponse");
    print("response${response}");
  }, onError: (dio.DioError err) async {
    print("onError");
    print(err.request.uri);
    if (err.response != null && err.response.statusCode == 401 && token != "") {
      print("api.interceptors");
      api.lock();
      token = await refreshToken(
          err.request.headers[HttpHeaders.authorizationHeader]); //获取新token
      print(token);
      api.options.headers[HttpHeaders.authorizationHeader] = token;
      api.unlock();

      var request = err.response.request; //千万不要调用 err.request
      request.headers[HttpHeaders.authorizationHeader] =
          token; //这里要单独修改之前请求里的token请求头为最新的token。
      try {
        var response = await api.request(request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: request,
            onReceiveProgress:
                request.onReceiveProgress //TODO 差一个onSendProgress
            );
        return response;
      } on dio.DioError catch (e) {
        return e;
      }
    }
  }));
}

Future<Response> delete(
  String path, {
  dynamic parameters,
}) async {
  Response _data;
  try {
    var _response = await api.delete(path, queryParameters: parameters);
    return Response.fromJson(_response.data);
  } on dio.DioError catch (e) {
    if (e.type == dio.DioErrorType.RECEIVE_TIMEOUT ||
        e.type == dio.DioErrorType.CONNECT_TIMEOUT) {
      _data = Response(false, "", "请求超时,请稍后重试", null);
    } else {
      _data = Response(false, "", e.message, null);
    }
  }
  return _data;
}
