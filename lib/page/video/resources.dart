import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smh/common/event_bus.dart';
import 'package:smh/common/init.dart';
import 'package:smh/models/video.dart';
import 'package:smh/models/resources.dart';
import 'package:smh/models/spiders/diaosidao.dart';
import 'package:smh/models/watch_history.dart';

class VideoResourcesPage extends StatefulWidget {
  Video movie;
  VideoResourcesPage(this.movie);
  @override
  _VideoResourcesPageState createState() => _VideoResourcesPageState();
}

class _VideoResourcesPageState extends State<VideoResourcesPage> {
  List<VideoResources> res = new List();
  int _currentIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Builder(
        builder: (context) {
          if (res.length > 0) {
            return ListView.separated(
                separatorBuilder: (context, i) => SizedBox(
                      width: 5,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: res.length,
                itemBuilder: (c, i) {
                  return OutlineButton(
                    color: _currentIndex == null
                        ? Colors.white
                        : _currentIndex == i ? Colors.red : Colors.white,
                    child: Text(res[i].Name),
                    onPressed: () {
                      setState(() {
                        _currentIndex = i;
                      });
                      eventBus.fire(PlayMoieEvent(res[i]));
                    },
                  );
                });
          } else {
            return Text("加载中....");
          }
        },
      ),
    );
  }
}
