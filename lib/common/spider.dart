import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:smh/models/video.dart';

// 数据的请求
request_data(String key) async {
  var url = "https://www.diaosidao.net/search.php?searchword=" + key;

  var response = await get(url);
  if (response.statusCode == 200) {
    return response.body;
  }
  return '<html>error! status:${response.statusCode}</html>';
}

// 数据的解析
html_parse(String key) async {
  List<Video> videos = new List();
  var html = await request_data(key);
  Document document = parse(html);

  // 这里使用css选择器语法提取数据
  List<Element> list =
      document.querySelectorAll('.col-lg-wide-75 .stui-pannel_bd ul li');
  for (var i = 0; i < list.length; i++) {
    Video movie = new Video();

    var imgNode = list[0].querySelector("div a").attributes["data-original"];
    movie.Cover = imgNode;

    var ele = list[1].querySelector(".detail");
    for (var i = 0; i < ele.nodes.length; i++) {
      print(ele.nodes[i].text);
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

        default:
      }
    }
    videos.add(movie);
  }
  print(videos[0].toJson());
}
