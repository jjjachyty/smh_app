import 'package:smh/common/dio.dart';

Future<bool> verificationSms(String id, value) async {
  var response = await post("/base/sms", {"Phone": id, "Code": value});
  return response.State;
}
