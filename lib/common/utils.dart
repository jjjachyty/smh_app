import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smh/common/init.dart';
import 'package:path_provider/path_provider.dart';

SharedPreferences prefs;

Future<void> initSharedPreferences() async {
  if (prefs == null) {
    prefs = await SharedPreferences.getInstance();
  }
}

Future<String> getStorageString(String key) async {
  return prefs.getString(key);
}

Future<bool> getStorageBool(String key) async {
  return prefs.getBool(key);
}

Future<bool> setStorageString(String key, val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(key, val);
}

Future<bool> setStorageBool(String key, val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool(key, val);
}

Future<bool> removeStorage(String key) async {
  return prefs.remove(key);
}

/// 倒计时
Timer countDown(int seconds, Function fun(int count)) {
  var _timer;

  _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
    print(seconds);
    fun(seconds);
    if (seconds == 0) {
      _timer.cancel();
      return;
    }

    seconds--;
  });

  return _timer;
}

double toDouble(String val) {
  var _db = double.tryParse(val);
  if (_db == null) {
    return 0;
  }
  return _db;
}

// bool checkHasVIP() {
//   var expDt = DateTime.parse(currentUser.VIPEndTime);
//   if (DateTime.now().isBefore(expDt)) {
//     return true;
//   }
//   return false;
// }

Future<String> findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}
