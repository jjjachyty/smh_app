import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh/common/dio.dart';
import 'package:smh/models/apply.dart';

class ApplyVideoPage extends StatefulWidget {
  String name;
  ApplyVideoPage(this.name);
  @override
  _ApplyVideoPageState createState() => _ApplyVideoPageState();
}

class _ApplyVideoPageState extends State<ApplyVideoPage> {
  String describe;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("留言"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val) {
                      if (val == null || val == "") {
                        return "名称不能为空";
                      }
                    },
                    onSaved: (val) {
                      widget.name = val;
                    },
                    decoration: InputDecoration(
                      prefixText: "名称：",
                      hintText: "名称、描述",
                    ),
                    initialValue: widget.name,
                  ),
                  TextFormField(
                    maxLines: 3,
                    onSaved: (val) {
                      describe = val;
                    },
                    decoration: InputDecoration(
                        prefixText: "描述：", hintText: "描述(如需补充说明)"),
                  ),
                  ProgressButton(
                    defaultWidget: const Text(
                      '确定',
                      style: TextStyle(color: Colors.white),
                    ),
                    progressWidget: const CircularProgressIndicator(),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        var flag = await addApply(Apply(
                          Name: widget.name,
                          Describe: describe,
                        ));
                        if (flag != null) {
                          Fluttertoast.showToast(
                              msg: flag,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          setState(() {});
                        }
                      }
                    },
                  ),
                ],
              )),
          Divider(),
          ListTile(
            subtitle: Text("求助列表"),
          ),
          Expanded(
            child: FutureBuilder(
              future: getApplys(),
              builder: (context, AsyncSnapshot<Response> shot) {
                if (shot.hasData) {
                  var data = shot.data.Data as List<Apply>;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        title: Text(data[index].Name),
                        // trailing: IconButton(
                        //   icon: Icon(
                        //     Icons.exposure_plus_1,
                        //     color: Colors.red,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        subtitle: Text(data[index].Describe),
                      );
                    },
                  );
                } else {
                  return Text("加载中。。。");
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
