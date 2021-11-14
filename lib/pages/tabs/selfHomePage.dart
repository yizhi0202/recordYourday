import 'package:flutter/material.dart';
import '../../res/module/user/user.dart';
import 'package:getwidget/getwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:dio/dio.dart';

class selfHomePage extends StatefulWidget {
  int userID = 0;
  String userPass = '';
  userType myType = userType.traveler;
  String profilePhoto = 'https://www.itying.com/images/flutter/3.png';
  userSex mySex = userSex.male;
  String nickName = 'ak43';
  selfHomePage({Key? key}) : super(key: key);

  @override
  _selfHomePageState createState() => _selfHomePageState();
}

class _selfHomePageState extends State<selfHomePage> {
  final ImagePicker picker = ImagePicker();
//用户本地图片
  late File imagePath; //存放获取到的本地路径
  String selfPath = '';
  String cloudPath = 'image/profilePhoto';
  String fileName = '';
  _openGallery() async {
    // final imagePicker = await picker.pickImage(source: ImageSource.gallery);
    // if (imagePicker != null) {
    //   imagePath = File(imagePicker.path);
    //   selfPath = imagePath.path;
    //   print('图片的路径是${selfPath}');
    //   fileName = selfPath.substring(45);
    //   print('filename is ' + fileName);
    //   String cloudp = cloudPath + '/' + fileName;
    //   try {
    //     CloudBaseCore core = CloudBaseCore.init({
    //       'env': 'hello-cloudbase-7gk3odah3c13f4d1',
    //       'appAccess': {
    //         'key': 'f9fadd353a3e75450ba4080b75789ebd',
    //         'version': '1'
    //       }
    //     });
    //     CloudBaseStorage storage = CloudBaseStorage(core);

    //     await storage.uploadFile(
    //       cloudPath: cloudp,
    //       filePath: selfPath,
    //       onProcess: (int count, int total) {
    //         // 当前进度
    //         print(count);
    //         // 总进度
    //         print(total);
    //       },
    //     );

    //     //get the url of the upload photo
    //     String cloudp2 =
    //         'cloud://hello-cloudbase-7gk3odah3c13f4d1.6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742/' +
    //             cloudp;

    //     // var response = await Dio().post(
    //     //     'https://hello-cloudbase-7gk3odah3c13f4d1.service.tcloudbase.com/getPhotoURL',
    //     //     data: {'cloudpath': cloudp2});
    //     // print(response);
    //     // var result = response.toString();
    //     // print('temp link is ${result}');
    //     List<String> fileIds = [cloudp2];
    //     CloudBaseStorageRes<List<DownloadMetadata>> res =
    //         await storage.getFileDownloadURL(fileIds);
    //     setState(() {
    //       widget.profilePhoto = res.data[0].downloadUrl;
    //     });
    //   } catch (e) {
    //     print(e);
    //   }
    // } else {
    //   imagePath = File('');
    //   print('没有照片');
    // }
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
            GFDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              currentAccountPicture: GFAvatar(
                radius: 50.0,
                backgroundImage:
                    NetworkImage("https://www.itying.com/images/flutter/3.png"),
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
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            height: 100,
            width: 280,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ClipOval(
                child: Image.network(
                  '${widget.profilePhoto}',
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
                      '${widget.nickName}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  GestureDetector(
                    child: (widget.mySex == userSex.male)
                        ? Icon(
                            Icons.male,
                            color: Colors.lightBlue,
                            size: 32,
                          )
                        : Icon(Icons.female, color: Colors.pink, size: 32),
                    onTap: () {
                      setState(() {
                        if (widget.mySex == userSex.male)
                          widget.mySex = userSex.female;
                        else
                          widget.mySex = userSex.male;
                      });
                    },
                  ),
                ],
              )
            ]),
          ),
          Divider(
              color:
                  widget.mySex == userSex.male ? Colors.lightBlue : Colors.pink,
              indent: 8.0,
              endIndent: 8.0),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              print('tap my paceNote');
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
            onTap: () {},
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
            onTap: () {},
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
