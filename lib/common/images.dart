// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smh/common/dio.dart';
import 'package:zefyr/zefyr.dart';

/// Custom image delegate used by this example to load image from application
/// assets.
class CustomImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(source: source);
    if (file == null) return null;
    var _key = DateTime.now().microsecondsSinceEpoch.toString();
    // var _data = await uploadImage(_key, file);
    // if (_data.State) {
    //   return "http://drpnews.apcchis.cn/" + _key;
    // }
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    // print(key);
    // We use custom "asset" scheme to distinguish asset images from other files.
    // if (key.startsWith('asset://')) {
    //   final asset = AssetImage(key.replaceFirst('asset://', ''));
    //   return Image(image: asset);
    // } else {
    //   // Otherwise assume this is a file stored locally on user's device.
    //   final file = File.fromUri(Uri.parse(key));
    //   final image = FileImage(file);
    //   return Image(image: image);
    // }
    return Image.network(key);
  }
}

// Future<Response> uploadImage(String flieName, File image) async {
//   Response _data;
//   if (image != null) {
//     print(await image.length());
//     var _forData = new dio.FormData.fromMap(
//         {"bucket": "drp-news", "img": new dio.UploadFileInfo(image, flieName)});

//     _data = await post("/com/uploadimage", data: _forData);
//     if (_data.state) {
//       print(_data.data);
//     }
//   }
//   return _data;
// }
