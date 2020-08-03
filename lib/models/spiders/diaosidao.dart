import 'dart:convert';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/resources.dart';

var userAgent = "Mobile/15E148 Safari/604.1";
// 数据的请求
request_data(String url) async {
  var client = new HttpClient();
  client.userAgent = userAgent;

  var request = await client.getUrl(Uri.parse(url));
  HttpClientResponse response = await request.close();
  if (response.statusCode == 200) {
    String responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  }
  client.close();

  return null;
}

// 数据的解析
Future<List<Video>> dsdSerach(String key,int page) async {
  List<Video> videos = new List();
  var url = "https://www.diaosidao.net/search.php?page="+page.toString()+"&searchword=" + key;

  var html = await request_data(url);
  Document document = parse(html);

  // 这里使用css选择器语法提取数据
  List<Element> list =
      document.querySelectorAll('.col-lg-wide-75 .stui-pannel_bd ul li');
  for (var i = 0; i < list.length; i++) {
    Video movie = new Video();

    var imgNode = list[i].querySelector("div a").attributes["data-original"];
    movie.Cover = imgNode;

    var ele = list[i].querySelector(".detail");
    for (var i = 0; i < ele.nodes.length; i++) {
      switch (i) {
        case 0:
          movie.Name = ele.nodes[i].text;
          break;
        case 1:
          movie.Director = ele.nodes[i].text.split("：")[1];
          break;
        case 2:
          movie.Actor = ele.nodes[i].text.split("：")[1];
          break;
        case 3:
          var _data = ele.nodes[i].text.split("：");
          movie.Genre = _data[1].substring(0, _data[1].length - 2);
          movie.Region = _data[2].substring(0, _data[2].length - 2);
          movie.Years = _data[3];
          break;
        case 4:
          movie.DetailURL = "http://www.diaosidao.net" +
              ele.nodes[i].nodes[2].attributes["href"];
          break;
        default:
      }
    }
    movie.pltform = 0; //
    videos.add(movie);
  }
  return videos;
}

// 数据的解析
Future<List<VideoResources>> resources(String key) async {
  List<VideoResources> resources = new List();
  var html = await request_data(key);
  Document document = parse(html);

  // 这里使用css选择器语法提取数据
  List<Element> nodes = document.querySelectorAll('.stui-pannel-box ul');
  //只取第一个
  for (var nod in nodes[0].nodes) {
    resources.add(VideoResources(
        Name: nod.text,
        URL: "http://www.diaosidao.net" + nod.firstChild.attributes["href"]));
  }
  return resources;
}

// 数据的解析
Future<String> getURL(String key) async {
  var html = await request_data(key);
  Document document = parse(html);

  // 这里使用css选择器语法提取数据
  List<Element> list = document.querySelectorAll('.stui-player__iframe');
  var begin = list[0].text.indexOf("(");
  var end = list[0].text.indexOf(")");
  var res = Uri.decodeFull(list[0].text.substring(begin + 2, end - 1));
  return res;
}
