import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import '../../res/module/user/user.dart';
import 'package:getwidget/getwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudbase_database/cloudbase_database.dart';


class selfHomePage extends StatefulWidget {
  // int userID = 0;
  // String userPass = '';
  // userType myType = userType.traveler;
  // String profilePhoto = 'https://www.itying.com/images/flutter/3.png';
  // userSex mySex = userSex.male;
  // String nickName = 'ak43';
  selfHomePage({Key? key}) : super(key: key);

  @override
  _selfHomePageState createState() => _selfHomePageState();
}

class _selfHomePageState extends State<selfHomePage> {
  String profilePhoto = '';
  bool isLoading =false;
  bool isMale = true;
  String nickName ='';

  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }
  void _getMoreData()
  {
    if(!isLoading)
      {
        setState(() {
          isLoading = true;
        });
      }
    getid().then((value) async{
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseDatabase db = CloudBaseDatabase(core);
      var res = await db.collection('userInfo').where({'userID':value}).get();
        if(mounted)
          {
            setState(() {
              isLoading = false;
              if(res.data[0]['sex'] == 'female') isMale = false;
              profilePhoto = res.data[0]['profilePhoto'];
              nickName = res.data[0]['nickName'];
            });
          }
    });
  }
  @override
  void initState() {
    this._getMoreData();
    super.initState();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text('我的'),
      ),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            (isLoading)?_buildProgressIndicator():
            GFDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              currentAccountPicture: ClipOval(
                child: Image.network(
                  profilePhoto,
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(nickName, style: TextStyle(fontSize: 16)),
                  Icon(
                    (isMale)?Icons.male:Icons.female,
                    color: (isMale)?Colors.lightBlue:Colors.pink,
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
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isLoading)?_buildProgressIndicator():
          Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            height: 100,
            width: 280,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ClipOval(
                child: Image.network(
                  profilePhoto,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 20),
                    child: Text(
                      nickName,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  (isMale)
                      ? Icon(
                    Icons.male,
                    color: Colors.lightBlue,
                    size: 32,
                  )
                      : Icon(Icons.female, color: Colors.pink, size: 32),
                ],
              )
            ]),
          ),
          Divider(
              color:
              (isMale)? Colors.lightBlue : Colors.pink,
              indent: 8.0,
              endIndent: 8.0),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/myPaceNote');
            },
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book,
                  color: Colors.yellow,
                  size: 32.0,
                ),
                Text(
                  '我的路书',
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/myScenicSpot');
            },
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.nature_people,
                  color: Colors.lightGreen,
                  size: 32,
                ),
                Text(
                  '我的景点',
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/myFavorite');
            },
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 32,
                ),
                Text(
                  '我的收藏',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/editUserInfo');
            },
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.lightBlue,
                  size: 32,
                ),
                Text(
                  '个人资料',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_rounded,
                  color: Colors.yellow,
                  size: 32,
                ),
                Text(
                  '修改密码',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 0.01,
                ),
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
    );
  }
}
