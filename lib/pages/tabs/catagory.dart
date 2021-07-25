import 'package:flutter/material.dart';

class categoryPage extends StatefulWidget {
  categoryPage({Key? key}) : super(key: key);

  @override
  _categoryPageState createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("我是分类组件！"),
          leading: Icon(Icons.phone_android),
        ),
        ListTile(
          title: Text("我是分类组件！"),
          leading: Icon(Icons.phone_android),
        ),
        ListTile(
          title: Text("我是分类组件！"),
          leading: Icon(Icons.phone_android),
        ),
      ],
    );
  }
}
