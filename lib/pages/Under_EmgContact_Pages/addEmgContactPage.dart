import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class addEmgContactPage extends StatelessWidget {
  addEmgContactPage({Key? key}) : super(key: key);
  TextEditingController? emgNickname;
  TextEditingController? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
          color: Colors.white24,
        ),
        centerTitle: true,
        title: Text('添加紧急联系人'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('绰号'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emgNickname,
              decoration: InputDecoration(hintText: '输入他（她）的称呼吧'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('邮箱号码（目前仅限qq邮箱）'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: email,
              decoration: InputDecoration(hintText: '输入他（她）的邮箱吧'),
            ),
          ),
        ],
      ),
    );
  }
}
