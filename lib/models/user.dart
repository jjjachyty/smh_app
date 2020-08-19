import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/common/init.dart';
import 'package:smh/common/utils.dart';
import 'package:smh/models/comment.dart';

import 'follow.dart';

part 'user.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User {
  int ID;
  String Mail;
  String NickName;
  String Introduce;
  String VIPEndTime;
  int Sex;
  String Avatar;
  String Phone;
  String PassWord;
  String DeviceID;
  String DevicePlatform;
  String IP;
  num Coin;
  String Platform;
  num Longitude;
  num Latitude;
  String CreateAt;
  String LastLogin;
  bool State;
  User({
    this.ID,
    this.Mail,
    this.NickName,
    this.Introduce,
    this.Sex,
    this.VIPEndTime,
    this.Avatar,
    this.Phone,
    this.PassWord,
    this.DeviceID,
    this.DevicePlatform,
    this.IP,
    this.Coin,
    this.Platform,
    this.Longitude,
    this.Latitude,
    this.CreateAt,
    this.LastLogin,
    this.State,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

Future<Response> register(User user) async {
  user.DevicePlatform = Platform.operatingSystem;

  var resp = await post("/user/register", user.toJson());
  if (!resp.State) {
    if (resp.Message.contains("E11000")) {
      resp.Message = "账号已存在,请登录";
    }
  }
  return resp;
}

Future<Response> login(User user) async {
  var resp = await post("/user/login", user.toJson());
  if (resp.State) {
    // setUser(User.fromJson(resp.Data["User"]));
    setToken(resp.Data["Token"]);
  }
  return resp;
}

// Future<Response> getVIP() async {
//   var resp = await post("/user/vip", {});
//   if (resp.State) {
//     currentUser.VIPEndTime = resp.Data as String;
//     setUser(currentUser);
//   }
//   return resp;
// }

Future<Response> loginWithSMS(String phone, String sms) async {
  var resp = await post("/user/loginsms", {"Phone": phone, "PassWord": sms});
  if (resp.State) {
    // setUser(User.fromJson(resp.Data["User"]));
    setToken(resp.Data["Token"]);
  }
  return resp;
}

Future<Response> updateInfo(User user) async {
  return post("/user/updateinfo", user.toJson());
}

// void setUser(User newUser) async {
//   currentUser = newUser;
//   await setStorageString("_user", json.encode(newUser.toJson()));
// }

void setToken(String tk) async {
  token = tk;
  api.options.headers[HttpHeaders.authorizationHeader] = tk;
  await setStorageString("_token", tk);
}

Future<User> getUser() async {
  var _userStr = await getStorageString("_user");
  if (_userStr == null) {
    return null;
  }
  // currentUser = User.fromJson(json.decode(_userStr));
  // return currentUser;
}

void loginOut() {
  // currentUser = null;
  removeStorage("_user");
  removeStorage("_token");
  api.options.headers[HttpHeaders.authorizationHeader] = "";
}

Future<Response> checkPhone(String phone) async {
  var resp = await get("/user/checkphone?phone=" + phone);
  return resp;
}

Future<Response> checkVIP() async {
  var resp = await get("/user/checkvip");
  return resp;
}

Future<User> getUserInfo(int id) async {
  var resp = await get("/user/info/" + id.toString());
  if (resp.State) {
    return User.fromJson(resp.Data);
  }
  return null;
}

Future<Response> userComments(int pageSize, int userid) async {
  var resp = await get("/user/moviecomments?userid=" +
      userid.toString() +
      "&offset=" +
      (pageSize * 15).toString());
  if (resp.State) {
    resp.Data = toList(resp.Data);
  }
  return resp;
}

Future<Response> userFollows(int pageSize) async {
  var resp = await get("/user/follows?&offset=" + (pageSize * 15).toString());
  if (resp.State) {
    resp.Data = toFollowList(resp.Data);
  }
  return resp;
}
