import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class addScenicSpotPage extends StatefulWidget {
  addScenicSpotPage({Key? key}) : super(key: key);

  @override
  _addScenicSpotPageState createState() => _addScenicSpotPageState();
}

class _addScenicSpotPageState extends State<addScenicSpotPage> {
  List<Asset> images = <Asset>[];
  // List<String> photoData = [
  //   'https://www.itying.com/images/flutter/1.png',
  //   'https://www.itying.com/images/flutter/2.png',
  //   'https://www.itying.com/images/flutter/3.png',
  //   'https://www.itying.com/images/flutter/4.png',
  // ];
  // List<String> photoPath = [];
  // Widget getEachPhoto(String photourl) {
  //   return Container(
  //     height: 60,
  //     width: 60,
  //     child: Image.file(File(photourl)),
  //     // child: Image.network(
  //     //   photourl,
  //     //   fit: BoxFit.cover,
  //     // ),
  //   );
  // }

  // List<Widget> getAllPhoto() {
  //   return photoData.map((item) => getEachPhoto(item)).toList();
  // }

  // List<Widget> getAllPhoto1() {
  //   return photoPath.map((item) => getEachPhoto(item)).toList();
  // }

  //显示二进制数据图像 搭配FutureBuilder使用(目前没有用到)
  Future<Widget> testByteDataPhoto() async {
    // if (images.length != 0) {
    //   ByteData byteData = await images[0].getByteData();
    //   return Image.memory(byteData.buffer.asUint8List());
    // }
    // return Image.network('https://www.itying.com/images/flutter/3.png');
    ByteData byteData = await images[0].getByteData();
    return Image.memory(byteData.buffer.asUint8List());
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

  @override
  Widget build(BuildContext context) {
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
          ButtonBar(
            children: [
              FaIcon(
                FontAwesomeIcons.paperPlane,
                color: Colors.yellow,
              ),
              Text('发表')
            ],
          ),
          ButtonBar(
            children: [
              FaIcon(
                FontAwesomeIcons.sdCard,
                color: Colors.yellow,
              ),
              Text('保存')
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Text('我是标题'),
          TextField(
            keyboardType: TextInputType.multiline,
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
          Text(
            '我是地址',
          ),
        ],
      ),
    );
  }
}
