// import 'dart:convert';
// import 'dart:io';

// import "package:http/http.dart" as http;
// import 'package:smh/common/event_bus.dart';
// import 'package:smh/common/utils.dart';
// import 'package:smh/models/spiders/diaosidao.dart';

// import 'init.dart';

// var host = "http://122.112.151.97:9999/api/v1";
// // var host = "http://127.0.0.1:9999/api/v1";

// class Response {
//   bool State;
//   String Code;
//   String Message;
//   dynamic Data;
//   Response(this.State, this.Code, this.Message, this.Data);
//   //不同的类使用不同的mixin即可
//   Response.fromJson(Map<String, dynamic> json)
//       : State = json["State"],
//         Code = json["Code"],
//         Message = json["Message"],
//         Data = json["Data"];
// }

// Future<Response> get(String path) async {
//   var url = host + path;

//   var r =
//       await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
//   print(url);
//   print(r.body);

//   if (r.statusCode == 200) {
//     return Response.fromJson(json.decode(r.body));
//   } else if (r.statusCode == 401) {
//     eventBus.fire(ToLogin());
//   }

//   return Response(false, "Code", r.body, null);
// }

// Future<Response> post(String path, dynamic data) async {
//   var url = host + path;
//   var r = await http.post(url,
//       body: json.encode(data),
//       headers: {HttpHeaders.authorizationHeader: token});
//   print("token=${token}");
//   print(url);
//   print(r.body);
//   if (r.statusCode == 200) {
//     return Response.fromJson(json.decode(r.body));
//   } else if (r.statusCode == 401) {
//     eventBus.fire(ToLogin());
//   }

//   return Response(false, "Code", r.body, null);
// }

// Future<Response> delete(String path) async {
//   var url = host + path;
//   var r =
//       await http.delete(url, headers: {HttpHeaders.authorizationHeader: token});
//   print("token=${token}");
//   print(url);
//   print(r.body);
//   if (r.statusCode == 200) {
//     return Response.fromJson(json.decode(r.body));
//   } else if (r.statusCode == 401) {
//     eventBus.fire(ToLogin());
//   }

//   return Response(false, "Code", r.body, null);
// }
