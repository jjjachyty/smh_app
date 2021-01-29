import 'package:flutter/material.dart';
import 'package:flutter_dlna/flutter_dlna.dart';

class AirPlayPage extends StatefulWidget {
  String url;

  AirPlayPage(this.url);

  @override
  _AirPlayPageState createState() => _AirPlayPageState();
}

class _AirPlayPageState extends State<AirPlayPage> {
  //投屏

  FlutterDlna manager = new FlutterDlna();
  List deviceList = List();
  //当前选择的设备
  String currentDeviceUUID = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //投屏
    manager.init();
    manager.setSearchCallback((devices) {
      if (devices != null && devices.length > 0) {
        this.setState(() {
          this.deviceList = devices;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("请选择投屏设备"),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  this.manager.search();
                })
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 8, right: 8),
          alignment: Alignment.center,
          child: this.deviceList.length == 0
              ? Text("暂无可用的投屏设备,请保持电视和手机在一个wifi内,点击刷新按钮重新搜索")
              : Column(children: [
                  Column(
                      children: this.deviceList.map((e) {
                    return InkWell(
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              height: 55,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    e["name"],
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Color(0xFF111111), fontSize: 12),
                                  )),
                                ],
                              )),
                          Divider(
                            color: Color(0xFFEEEEEE),
                            height: 0.5,
                            endIndent: 2,
                            indent: 2,
                          )
                        ],
                      ),
                      onTap: () async {
                        if (this.currentDeviceUUID == e["id"]) {
                          return;
                        }
                        await this.manager.setDevice(e["id"]);
                        await this
                            .manager
                            .setVideoUrlAndName("来至书名号的投屏", this.widget.url);
                        await this.manager.startAndPlay();
                      },
                    );
                  }).toList()),
                ]),
        ));
  }
}
