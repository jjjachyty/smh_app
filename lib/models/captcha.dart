import 'package:smh/common/dio.dart';

Future<Response> getCaptcha(String phone) async {
  var response = await get("/base/captcha?Phone=" + phone);
  return response;
}

Future<Response> verificationCaptcha(
    String id, String phone, String value) async {
  var response =
      await post("/base/captcha", {"ID": id, "Phone": phone, "Code": value});
  return response;
}
