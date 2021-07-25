import 'package:flutter/material.dart';

class searchPage extends StatelessWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "返回",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("搜索页面"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.air), onPressed: () {}),
          ],
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: Text("你好安妮"),
              leading: Icon(Icons.security_update_warning),
            ),
            ListTile(
              title: Text("你好安东妮"),
              leading: Icon(Icons.security_update_warning),
            )
          ],
        ));
  }
}
