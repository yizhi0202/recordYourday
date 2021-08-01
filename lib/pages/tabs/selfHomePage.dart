import 'package:flutter/material.dart';
import '../Under_Selfhome_Pages/userInfoPage.dart';

class selfHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var usrpage = userInfoPage();
    usrpage.initUser(
        userID: 15678909876,
        userPass: '1245',
        profilePhoto: 'https://www.itying.com/images/flutter/4.png',
        nickname: 'ak43');
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text('我的'),
        leading: IconButton(
          //drawer
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      backgroundColor: Colors.transparent,
      body: usrpage.build(context),
    );
  }
}
