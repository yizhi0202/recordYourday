import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:flutter_app_y/res/module/paceNote/paceNote.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class addPaceNotePage extends StatefulWidget {
  Map arguments;
  addPaceNotePage({Key? key, required this.arguments}) : super(key: key);

  @override
  _addPaceNotePageState createState() => _addPaceNotePageState();
}

class _addPaceNotePageState extends State<addPaceNotePage> {
  TextEditingController paceNoteTitle = TextEditingController();
  TextEditingController paceNoteFeeling = TextEditingController();
  bool isSelect = false;
  String spots = "";
  List<Asset> images = <Asset>[];
  // List<String> imagePath = [];

  //to store the cover of pacenote into cloud storage, and get the url of the cover
  Future<String> eachPhotoUp(
    Asset photo,
    CloudBaseStorage cbstorage,
  ) async {
    var path = await FlutterAbsolutePath.getAbsolutePath(photo.identifier);
    String cloudp = 'image/paceNotePhoto/' + path.substring(45);
    try {
      await cbstorage.uploadFile(
        cloudPath: cloudp,
        filePath: path,
        onProcess: (int count, int total) {
          // 当前进度
          //print(count);
          // 总进度
          //print(total);
        },
      );

      //getUrl
      String fileID =
          'cloud://hello-cloudbase-7gk3odah3c13f4d1.6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742/' +
              cloudp;
      List<String> fileIds = [fileID];
      CloudBaseStorageRes<List<DownloadMetadata>> res =
          await cbstorage.getFileDownloadURL(fileIds);
      return res.data[0].downloadUrl;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  void upCloudDataBase() {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseStorage storage = CloudBaseStorage(core);
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('paceNote');
    int len = 0;
    if (images.length > 0) {
      images.forEach((element) async {
        eachPhotoUp(element, storage).then((image_url){
          len++;
          if(len == images.length)
          {
            collection
           .add({
          'userID': widget.arguments['userID'],
          'photo': image_url,
          'title': paceNoteTitle.text,
          'note': paceNoteFeeling.text,
          'score':60,
          'scenicSpotInfo':spots,
          'voteNum':1,
          'audit':true
        })
        .then((_) {
          Navigator.pop(context);
        })
        .catchError((e) {
          print(e);
        });
          }
        });
        
      });
    }
    
  }

  //显示选择后的图像
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
            width: 300,
            height: 300,
          );
        }),
      ),
      onTap: () {
        loadAssets();
      },
    );
  }

  //打开相册，开始选择图片(因为封面只有一个，所以只能选择一个封面)
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

  Widget GetMyCard(
      {String title = '景点标题', String location = '景点详细地址', int ordinum = 1}) {
    ordinum += 1;
    return Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: GFIconButton(
            color: Colors.yellow,
            icon: Text(
              ordinum.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {},
            shape: GFIconButtonShape.circle,
          ),
          title: Text(title),
          subtitle: Text(location),
          trailing: FaIcon(
            FontAwesomeIcons.map,
            color: Colors.lightGreen,
          ),
        ));
  }

  List<Widget> paceNoteList = [];
  void IncreaseSpot(String title, String location)  {
  Map spot;
  Navigator.pushNamed(context, '/searchScenicSpot').then((spot){
    setState(() {
      Map term = spot as Map;
      paceNoteList.add(GetMyCard(
      title: term['title'], location: term['address'], ordinum: paceNoteList.length));
      List photoL = term['scenicSpotPhotoUrl'].split("###").where((s) => !s.isEmpty).toList();
      spots += photoL[0]+"&&&"+term['title']+"&&&"+term['address']+'&&&'+term['introduction']+"&&&"+term['latitude'].toString()+'&&&'+term['longitude'].toString()+"###";
    });
     
  });
 
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('新建路书'),
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
              print('success to publish');
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
      floatingActionButton: GFIconButton(
        color: Colors.yellow,
        iconSize: 40,
        onPressed: () {
          setState(() {
            showToast(context, "上传成功!");
            IncreaseSpot('景点标题', '景点地点');
          });
        },
        icon: Icon(Icons.add),
        shape: GFIconButtonShape.circle,
        tooltip: '添加新段落',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // adjust the floating button location
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 30),
            height: 350,
            child: !isSelect
                ? GFButton(
                    onPressed: () {
                      setState(() {
                        loadAssets();
                      });
                    },
                    text: '上传封面',
                    textStyle: TextStyle(fontSize: 16),
                    shape: GFButtonShape.standard,
                    color: Colors.orangeAccent,
                  )
                : buildGridView(),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '我是标题',
                style: TextStyle(fontSize: 16),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: '输入标题吧'),
              controller: paceNoteTitle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '我是感受',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              controller: paceNoteFeeling,
              maxLength: 1000,
              maxLines: 6,
              decoration: InputDecoration(
                  hintText: '请输入此次路书的整体感受',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  )),
            ),
          ),
          Container(
            height: 680,
            child: ListView.builder(
              itemCount: paceNoteList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return paceNoteList[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
