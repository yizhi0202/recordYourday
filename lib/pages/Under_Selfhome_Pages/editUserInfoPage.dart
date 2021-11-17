import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../res/module/user/user.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class editUserInfoPage extends StatefulWidget {
  @override
  State<editUserInfoPage> createState() => _editUserInfoPageState();
}

class _editUserInfoPageState extends State<editUserInfoPage> {
  userSex user_sex = userSex.female;

  String profilePhoto = 'https://www.itying.com/images/flutter/3.png';

  String nickName = '此人昵称艺术已死';

  bool isSelect = false;
  String imageURL = "";
  bool uploaded = false; 
  TextEditingController nickNameController = TextEditingController();

  List<Asset> images = <Asset>[];
  int _radioGroupA = 0;

  void _handleRadioValueChanged(int? value) {
    setState(() {
      _radioGroupA = value!;
    });
  }

  void eachPhotoUp(
      Asset photo,
      CloudBaseStorage cbstorage,
      ) async {
    var path = await FlutterAbsolutePath.getAbsolutePath(photo.identifier);
    String cloudp = 'image/profilePhoto/' + path.substring(45);
    try {
      await cbstorage.uploadFile(
        cloudPath: cloudp,
        filePath: path,
        onProcess: (int count, int total) {
          // 当前进度
          print(count);
          // 总进度
          print(total);
        },
      ).then((a){});

      //getUrl
      String fileID =
          'cloud://hello-cloudbase-7gk3odah3c13f4d1.6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742/' +
              cloudp;
      List<String> fileIds = [fileID];
      CloudBaseStorageRes<List<DownloadMetadata>> res =
      await cbstorage.getFileDownloadURL(fileIds);
      imageURL = res.data[0].downloadUrl;
    } catch (e) {
      print(e);
    }
  }
  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }
  void upCloudDataBase()  {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseStorage storage = CloudBaseStorage(core);
    CloudBaseDatabase db = CloudBaseDatabase(core);
    
    int len = 0;
    if (images.length > 0) {
      images.forEach((element) async {
        eachPhotoUp(element, storage);
        len++;
      });
    }
    while(len<images.length){int a = 1;}
    Collection userInfo = db.collection('userInfo');
    getid().then((id){
        userInfo.where(
      {
        "userID":id
      }
    ).remove().then((res1){
      // while(false == uploaded){int a = 1;}
      userInfo.add({
        "userID":id,
        "userType":"common",
        "sex":_radioGroupA==0 ? "male":"female",
        "profilePhoto":imageURL,
        "nickname":nickNameController.text
      }).then((res2){print(res2);});
    });
    // userInfo
    //     .add({
    //         "nickname":,
    //         "profilePhoto":,
    //         "sex":,
    //         "userID":,

    //       })
    //       .then((shit) {print(shit);})
    //       .catchError((e) {
    //         print(e);
    //       });
    });
    
  }

  Widget buildGridView() {
    return GestureDetector(
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        crossAxisCount: 1,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 100,
            height: 100,
          );
        }),
      ),
      onTap: () {
        loadAssets();
      },
    );
  }
  
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      isSelect = true;
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('个人资料页'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
          color: Colors.white24,
        ),
        actions: [IconButton(onPressed: () {
            upCloudDataBase();
        }, icon: Icon(Icons.save))],
      ),
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
                    profilePhoto,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
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
                    (user_sex == userSex.male)
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
                user_sex == userSex.male ? Colors.lightBlue : Colors.pink,
                indent: 8.0,
                endIndent: 8.0),
            Padding(padding: EdgeInsets.all(10),child: Text('修改头像'),),
            Padding(padding: EdgeInsets.all(10),child: ClipOval(child: !isSelect
                ? GFIconButton(
              size: GFSize.LARGE,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  loadAssets();
                });
              },
              shape: GFIconButtonShape.circle,
              color: Colors.orangeAccent,
            )
                : Container(
              height: 80,
              width: 80,
              child: buildGridView(),
            )),),
            Padding(padding: EdgeInsets.all(10),child: Text('修改性别'),),
            Padding(padding: EdgeInsets.all(10),child: RadioListTile(
              value: 0,
              groupValue: _radioGroupA,
              activeColor: Colors.lightBlue,
              onChanged: _handleRadioValueChanged,
              title: Text('我是猛男'),
              tileColor: Colors.white24,
              selectedTileColor: Colors.black,
              secondary: Icon(Icons.male),
              //利用_radioGroupA值与当前控件value 进行bool判断
              selected: _radioGroupA == 0,  //是否跟随主题颜色
            ),),
            Padding(padding: EdgeInsets.all(10),child: RadioListTile(
              value: 1,
              groupValue: _radioGroupA,
              activeColor: Colors.pink,
              onChanged: _handleRadioValueChanged,
              title: Text('我是小仙女'),
              tileColor: Colors.white24,
              selectedTileColor: Colors.black,
              secondary: Icon(Icons.female),
              selected: _radioGroupA == 1,
            ),),
            Padding(padding: EdgeInsets.all(10),child: Text('修改昵称'),),
            Padding(padding: EdgeInsets.all(10),child: TextField(controller: nickNameController,decoration: InputDecoration(hintText: '请输入您的绰号'),),)
          ]),

    );
  }
}
