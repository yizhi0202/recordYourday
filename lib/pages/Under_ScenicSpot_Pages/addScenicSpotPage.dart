import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:flutter/services.dart';

import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
import 'package:flutter_app_y/res/module/mapSource/POIsearch.dart';

// import 'package:amap_flutter_map/amap_flutter_map.dart';
// import 'package:amap_flutter_base/amap_flutter_base.dart';

class addScenicSpotPage extends StatefulWidget {
  addScenicSpotPage({Key? key}) : super(key: key);

  @override
  _addScenicSpotPageState createState() => _addScenicSpotPageState();
}

class _addScenicSpotPageState extends State<addScenicSpotPage> {
  List<Asset> images = <Asset>[];
  List<String> imagePath = [];
  Map spot = {'title': '名称', 'address': '地址', 'position': ''};
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController introductionController = TextEditingController();

  // static final CameraPosition _kInitialPosition = const CameraPosition(
  //   target: LatLng(39.909187, 116.397451),
  //   zoom: 10.0,
  // );
  //显示二进制数据图像 搭配FutureBuilder使用(目前没有用到)
  // Future<Widget> testByteDataPhoto() async {
  //   if (images.length != 0) {
  //     ByteData byteData = await images[0].getByteData();
  //     var bytesPhoto = byteData.buffer.asUint8List();
  //     var strPhoto = String.fromCharCodes(bytesPhoto);
  //     List<int> list = strPhoto.codeUnits;
  //     var bytesPhoto2 = Uint8List.fromList(list);
  //     return Image.memory(bytesPhoto2);
  //     // ByteData byteData = await images[0].getByteData();
  //     // return Image.memory(byteData.buffer.asUint8List());
  //   }
  //   return Image.network('https://www.itying.com/images/flutter/3.png');
  // }

  void eachPhotoUp(
      Asset photo, CloudBaseStorage cbstorage, Collection collection) async {
    var path = await FlutterAbsolutePath.getAbsolutePath(photo.identifier);
    String cloudp = 'image/scenicSpotPhoto/' + path.substring(45);
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
      );

      //getUrl
      String fileID =
          'cloud://hello-cloudbase-7gk3odah3c13f4d1.6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742/' +
              cloudp;
      List<String> fileIds = [fileID];
      CloudBaseStorageRes<List<DownloadMetadata>> res =
          await cbstorage.getFileDownloadURL(fileIds);

      //storage to database
      collection
          .add({
            'userID': '18670343782',
            'scenicSpotPhotoUrl': res.data[0].downloadUrl
          })
          .then((res) {})
          .catchError((e) {
            print(e);
          });
    } catch (e) {
      print(e);
    }
    print(path);
  }

  void upCloudDataBase() {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseStorage storage = CloudBaseStorage(core);
    CloudBaseDatabase db = CloudBaseDatabase(core);

    Collection collection = db.collection('scenicSpotPhoto');
    if (images.length > 0) {
      images.forEach((element) async {
        eachPhotoUp(element, storage, collection);
      });
    }
  }

  //显示选择后的图像
  Widget buildGridView() {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  //打开相册，开始选择图片
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
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

  void baibuGps() {
    //创建一个定位对象，后续操作时使用
    LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

    // 设置安卓定位参数(按官方文档复制过来就可以了)
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(1000); // 设置发起定位请求时间间隔
    Map androidMap = androidOption.getMap();

    //ios定位参数设置(用不上也要设置,按默认就可以了)
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    Map iosdMap = iosOption.getMap();

    _locationPlugin.requestPermission(); //请求定位权限
    _locationPlugin.prepareLoc(androidMap, iosdMap); //ios和安卓定位设置

    _locationPlugin.startLocation(); //开始定位

    //  获取定位结果
    var gps = _locationPlugin.onResultCallback();
    gps.listen((event) {
      //event就是获取到的结果,是订阅模式的，需要一直监听
      print(event.values);
      print(event["address"]); //打印地址
      print(event["province"]); //省份
    });
    //_locationPlugin.stopLocation();//停止定位（这里暂时不用）
  }

  @override
  Widget build(BuildContext context) {
    // AmapService.init(
    //   iosKey: 'c3b60c1f305f5b18aab83056c6971709',
    //   androidKey: 'be529103cc824e1978a8611fa623ebe1',
    // );

    //to judge if user select a address of scenicSpot
    bool isSelectAddr = false;
    //to receive the address data choosed by user

    getScenicSpotAddr(BuildContext context) async {
      spot =
          await Navigator.pushNamed(context, '/ShowPOICitySearchPage') as Map;
      print('地点的经度为：' + spot['position'].latitude.toString());
      //刷新用户选择后的名称和地址
      setState(() {
        spot = spot;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('新建景点'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              upCloudDataBase();
            },
            child: ButtonBar(
              children: [
                FaIcon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.yellow,
                ),
                Text('发表')
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Text('我是标题'),
          TextField(
            keyboardType: TextInputType.multiline,
            controller: titleController,
            maxLength: 12,
            maxLines: 1,
            minLines: 1,
            decoration: InputDecoration(
                hintText: '请输入景点标题',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                )),
          ),
          Text('我是摘要'),
          TextField(
            keyboardType: TextInputType.multiline,
            controller: subTitleController,
            maxLength: 84,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: '请输入景点摘要',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                )),
          ),
          Text('我是介绍'),
          TextField(
            keyboardType: TextInputType.multiline,
            controller: introductionController,
            maxLength: 600,
            maxLines: 6,
            decoration: InputDecoration(
                hintText: '请输入景点介绍',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                )),
          ),
          Text('我是图片(最多九张哦)'),
          GFButton(
            onPressed: () {
              loadAssets();
            },
            text: "点此上传图片",
            icon: Icon(Icons.add),
          ),
          ListView(
            shrinkWrap: true,
            children: [buildGridView()],
          ),

          GFButton(
            onPressed: () {
              getScenicSpotAddr(context);
            },
            text: '点此选择景点地址',
            icon: Icon(Icons.location_on),
          ),
          ListTile(
            title: Text(spot['title'], style: TextStyle(fontSize: 16)),
            subtitle: Text(
              spot['address'],
              style: TextStyle(fontSize: 16),
            ),
            trailing: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  spot = spot;
                });
              },
            ),
          )

          //TextButton(onPressed: baibuGps, child: Text('开始定位')),
        ],
      ),
    );
  }
}
