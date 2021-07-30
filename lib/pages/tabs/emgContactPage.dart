import 'package:flutter/material.dart';
import '../../res/module/emgContact.dart';

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
        emgContact(
            name: '苏珊',
            profilePhoto: 'https://www.itying.com/images/flutter/1.png',
            phoneNumber: 18765467890),
        emgContact(
            name: '苏珊andognni',
            profilePhoto: 'https://www.itying.com/images/flutter/2.png',
            phoneNumber: 18765467890),
        emgContact(
          name: '李月',
          profilePhoto: 'https://www.itying.com/images/flutter/4.png',
          phoneNumber: 19876543432,
        )
      ],
    );
  }
}
