import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../res/module/emgContact.dart';
import 'package:getwidget/getwidget.dart';

class emgContactPage extends StatefulWidget {
  emgContactPage({Key? key}) : super(key: key);

  @override
  _emgContactPageState createState() => _emgContactPageState();
}

class _emgContactPageState extends State<emgContactPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            GFButton(
              onPressed: () {},
              text: "新建紧急联系人",
              textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
              icon: Icon(
                Icons.add_call,
                color: Colors.white,
              ),
              color: Colors.redAccent,
              shape: GFButtonShape.pills,
            ),
            SizedBox(
              width: 160.0,
            ),
            GFButton(
              onPressed: () {},
              text: "设置报警时间",
              textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
              icon: Icon(
                Icons.add_alert_rounded,
                color: Colors.white,
              ),
              shape: GFButtonShape.pills,
              color: Colors.yellow,
            ),
          ],
        ),
        Divider(
          color: Colors.red,
          indent: 8.0,
          endIndent: 8.0,
        ),
        emgContact(
            name: '苏珊',
            profilePhoto: 'https://www.itying.com/images/flutter/1.png',
            phoneNumber: 18765467890),
        Divider(
          color: Colors.red,
          indent: 8.0,
          endIndent: 8.0,
        ),
        emgContact(
            name: '苏珊andognni',
            profilePhoto: 'https://www.itying.com/images/flutter/2.png',
            phoneNumber: 18765467890),
        Divider(
          color: Colors.red,
          indent: 8.0,
          endIndent: 8.0,
        ),
        emgContact(
          name: '李月',
          profilePhoto: 'https://www.itying.com/images/flutter/4.png',
          phoneNumber: 19876543432,
        ),
        Divider(
          color: Colors.red,
          indent: 8.0,
          endIndent: 8.0,
        ),
      ],
    );
  }
}
