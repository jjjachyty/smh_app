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
  var url = "https://www.yunsp.org/search.php?page="+page.toString()+"&searchword=" + key;

  var html = await request_data(url);
  Document document = parse(html);

  // 这里使用css选择器语法提取数据
  List<Element> list =
      document.querySelectorAll('.myui-panel_bd .myui-vodlist__media .clearfix');
  for (var i = 0; i < list.length; i++) {
    Video movie = new Video();

    var imgNode = list[i].querySelector("div a").attributes["data-original"];
    movie.Cover = imgNode;

    var ele = list[i].querySelector(".detail");
    for (var j = 0; j < ele.nodes.length; j++) {
      switch (j) {
        case 0:
          movie.Name = ele.nodes[j].text;
          break;
        case 1:
          movie.Director = ele.nodes[j].text.split("：")[1];
          break;
        case 2:
          movie.Actor = ele.nodes[j].text.split("：")[1];
          break;
        case 3:
          var _data = ele.nodes[j].text.split("：");
          movie.Genre = _data[1].substring(0, _data[1].length - 2);
          movie.Region = _data[2].substring(0, _data[2].length - 2);
          movie.Years = _data[3];
          break;
        case 4:
        if (ele.nodes[j].nodes.length ==2){
    movie.DetailURL = "https://www.yunsp.org" +
              ele.nodes[j].nodes[1].attributes["href"];
              break;
        }
            movie.DetailURL = "https://www.yunsp.org" +
              ele.nodes[j].nodes[2].attributes["href"];
      
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
Future<Map<String,List<VideoResources>>> resources(String key) async {
  Map<String,List<VideoResources>> resources = new Map();
  var html = await request_data(key);
  Document document = parse(html);


  List<Element> nodePlatform =  document.querySelectorAll(".nav-tabs li");
  for (var platform in nodePlatform) {
   var platformName = platform.text;
    print(platform.nodes[0].attributes["href"]);
 
  // 这里使用css选择器语法提取数据
  List<Element> nodes =  document.querySelectorAll(''+platform.nodes[0].attributes["href"]+' ul li');
  //只取第一个
  for (var nod in nodes) {
    if (resources[platformName]==null){
      resources[platformName] = List<VideoResources>();
    }
    resources[platformName].add(VideoResources(
      Platform: platformName,
        Name: nod.text,
        URL: "https://www.yunsp.org" + nod.firstChild.attributes["href"]));
  }
   }
  return resources;
}

// 数据的解析
Future<String> getURL(String key) async {
  var html = await request_data(key);
  var begin = html.toString().indexOf("now=base64decode(");
  var end  = html.toString().indexOf("\");var pn=");
  var m3u8URL=  base64Decode(html.toString().substring(begin+18,end));
  // 这里使用css选择器语法提取数据
  return String.fromCharCodes(m3u8URL);
}
