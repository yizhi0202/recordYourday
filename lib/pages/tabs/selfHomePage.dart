import 'package:flutter/material.dart';
import '../../res/module/user/user.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:dio/dio.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

class selfHomePage extends StatefulWidget {
  int userID = 0;
  String userPass = '';
  userType myType = userType.traveler;
  String profilePhoto =
      'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/profilePhoto/image_picker1889215763.jpg';
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
    var imagePicker = await picker.getImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      imagePath = File(imagePicker.path);
      selfPath = imagePath.path;
      print('图片的路径是${selfPath}');
      fileName = selfPath.substring(45);
      print('filename is ' + fileName);
      String cloudp = cloudPath + '/' + fileName;
      try {
        CloudBaseCore core = CloudBaseCore.init({
          'env': 'hello-cloudbase-7gk3odah3c13f4d1',
          'appAccess': {
            'key': '8b94be2cb5bbd669ed0c7e98dc8c3a25',
            'version': '1'
          }
        });
        CloudBaseStorage storage = CloudBaseStorage(core);

        await storage.uploadFile(
          cloudPath: cloudp,
          filePath: selfPath,
          onProcess: (int count, int total) {
            // 当前进度
            print(count);
            // 总进度
            print(total);
          },
        );

        //get the url of the upload photo
        String cloudp2 =
            'cloud://hello-cloudbase-7gk3odah3c13f4d1.6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742/' +
                cloudp;

        // var response = await Dio().post(
        //     'https://hello-cloudbase-7gk3odah3c13f4d1.service.tcloudbase.com/getPhotoURL',
        //     data: {'cloudpath': cloudp2});
        // print(response);
        // var result = response.toString();
        // print('temp link is ${result}');
        List<String> fileIds = [cloudp2];
        CloudBaseStorageRes<List<DownloadMetadata>> res =
            await storage.getFileDownloadURL(fileIds);
        setState(() {
          widget.profilePhoto = res.data[0].downloadUrl;
        });
      } catch (e) {
        print(e);
      }
    } else {
      imagePath = File('');
      print('没有照片');
    }
  }

  // Future<void> selectAssets() async {
  //   List<AssetEntity> assets = await AssetPicker.pickAssets(context);
  //   final List<AssetEntity> result = (await AssetPicker.pickAssets(
  //     context,
  //     maxAssets: 9,
  //     pathThumbSize: 84,
  //     gridCount: 4,
  //     selectedAssets: assets,
  //   ));
  //   if (result != null) {
  //     assets = List<AssetEntity>.from(result);
  //     print(assets.first);
  //     AssetEntity asset = assets.first;
  //     File file = await asset.file ?? File('');
  //     print(file.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            height: 100,
            width: 280,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: ClipOval(
                  child: Image.network(
                    '${widget.profilePhoto}',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _openGallery();
                  });
                },
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
                  (widget.mySex == userSex.male)
                      ? Icon(
                          Icons.male,
                          color: Colors.lightBlue,
                        )
                      : Icon(
                          Icons.female,
                          color: Colors.pink,
                        )
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
            onTap: () {},
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
                Icon(
                  Icons.logout_outlined,
                  color: Colors.yellow,
                  size: 32,
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
// class selfHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var usrpage = userInfoPage();
//     usrpage.initUser(
//         userID: 15678909876,
//         userPass: '1245',
//         profilePhoto: 'https://www.itying.com/images/flutter/4.png',
//         nickname: 'ak43');
//     return Scaffold(
      // appBar: AppBar(
      //   primary: true,
      //   backgroundColor: Colors.lightBlue,
      //   centerTitle: true,
      //   title: Text('我的'),
      //   leading: IconButton(
      //     //drawer
      //     icon: Icon(Icons.menu),
      //     onPressed: () {},
      //   ),
      // ),
      // backgroundColor: Colors.transparent,
//       body: Scaffold(
    //     body: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(height: 8),
    //         GestureDetector(
    //           onTap: () {
    //             print('tap my paceNote');
    //           },
    //           child: ButtonBar(
    //             alignment: MainAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 Icons.menu_book,
    //                 color: Colors.yellow,
    //                 size: 32.0,
    //               ),
    //               Text(
    //                 '我的路书',
    //                 style: TextStyle(fontSize: 18.0),
    //               )
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         GestureDetector(
    //           onTap: () {},
    //           child: ButtonBar(
    //             alignment: MainAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 Icons.nature_people,
    //                 color: Colors.lightGreen,
    //                 size: 32,
    //               ),
    //               Text(
    //                 '我的景点',
    //                 style: TextStyle(fontSize: 18.0),
    //               )
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         GestureDetector(
    //           onTap: () {},
    //           child: ButtonBar(
    //             alignment: MainAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 Icons.star,
    //                 color: Colors.yellow,
    //                 size: 32,
    //               ),
    //               Text(
    //                 '我的收藏',
    //                 style: TextStyle(fontSize: 18),
    //               )
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         GestureDetector(
    //           onTap: () {},
    //           child: ButtonBar(
    //             alignment: MainAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 Icons.account_circle,
    //                 color: Colors.lightBlue,
    //                 size: 32,
    //               ),
    //               Text(
    //                 '个人资料',
    //                 style: TextStyle(fontSize: 18),
    //               )
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         GestureDetector(
    //           onTap: () {},
    //           child: ButtonBar(
    //             alignment: MainAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 Icons.lock_rounded,
    //                 color: Colors.yellow,
    //                 size: 32,
    //               ),
    //               Text(
    //                 '修改密码',
    //                 style: TextStyle(fontSize: 18),
    //               )
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         GestureDetector(
    //           onTap: () {},
    //           child: ButtonBar(
    //             alignment: MainAxisAlignment.start,
    //             children: [
    //               Icon(
    //                 Icons.logout_outlined,
    //                 color: Colors.yellow,
    //                 size: 32,
    //               ),
    //               Text('退出登录', style: TextStyle(fontSize: 18))
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
//   }
// }
