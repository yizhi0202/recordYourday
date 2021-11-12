import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../res/module/paceNote/paceNote.dart';
import 'package:getwidget/getwidget.dart';
import '../../res/module/user/user.dart';
import '';

class paceNotePage extends StatelessWidget {
  const paceNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: Text('路书'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        drawer: GFDrawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GFDrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                currentAccountPicture: GFAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      "https://www.itying.com/images/flutter/3.png"),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('nick name', style: TextStyle(fontSize: 18)),
                    Icon(
                      Icons.male,
                      color: Colors.lightBlue,
                      size: 32,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.powerOff,
                      size: 25,
                      color: Colors.red,
                    ),
                    Text('退出登录', style: TextStyle(fontSize: 18))
                  ],
                ),
              )
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            GestureDetector(
              child: paceNote(
                paceNoteID: 00,
                userID: 00,
                title: "明日方舟",
                note:
                    "末日生存不服来战,突如其来的假期,突如其来的假期,突如其来的假期,突如其来的假期,突如其来的假期,突如其来的假期,",
                photo:
                    'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/profilePhoto/%E6%A3%AE%E6%9E%97%E9%95%9C%E7%89%87.png',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/paceNoteDetail');
              },
            ),
            GestureDetector(
              child: paceNote(
                paceNoteID: 01,
                userID: 01,
                title: "阚清子",
                note: "突如其来的假期",
                photo: 'https://www.itying.com/images/flutter/2.png',
              ),
              onTap: () {
                print('jump to details');
              },
            ),
            GestureDetector(
              child: paceNote(
                paceNoteID: 02,
                userID: 02,
                title: "小众景点",
                note: "心旷神怡",
                photo: 'https://www.itying.com/images/flutter/2.png',
              ),
              onTap: () {
                print('jump to details');
              },
            ),
          ],
        ));
  }
}
