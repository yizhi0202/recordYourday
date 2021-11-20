import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:getwidget/getwidget.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_y/res/module/likeAndFavor/likeAndFavorFunction.dart';

import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';

List<String> newPhotos = [
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
];

class scenicSpotDetailPage extends StatefulWidget {
  Map arguments;
  scenicSpotDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _scenicSpotDetailPageState createState() => _scenicSpotDetailPageState();
}

class _scenicSpotDetailPageState extends State<scenicSpotDetailPage> {
  bool keyboard = false; //键盘的弹起、收回状态
  bool favor  = false;
  TextEditingController editingController =
      new TextEditingController(); //输入框的编辑
  //get the photoUrl of uploading by userID
  void getPhotoList(String userID) async {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('scenicSpotPhoto');
    var _ = db.command;
  }
  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }

  @override
  Widget build(BuildContext context) {
    newPhotos = widget.arguments["photoURL"].split("###").where((s) => !s.isEmpty).toList();

    
    double height =
        MediaQuery.of(context).padding.bottom; // 这个很简单，就是获取高度，获取的底部安全区域的高度
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: 270,
              width: 480,
              child: GFCarousel(
                autoPlay: true,
                viewportFraction: 0.8,
                pagination: true,
                passiveIndicator: Colors.grey,
                activeIndicator: Colors.white,
                items: newPhotos.map(
                  (url) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(url, fit: BoxFit.cover),
                      ),
                    );
                  },
                ).toList(),
                onPageChanged: (index) {
                  setState(() {
                    index;
                  });
                },
              ),
            ),
            IconButton(
                onPressed: () {

                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 32,
                )),
          ],
        ),
        Container(
          height: 60,
          width: 480,
          child: ListTile(
              title: Text('景点名称${widget.arguments['scenicSpotName']}'),
              subtitle: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: FaIcon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 18,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                      child: 
                  Text(
                    '景点位置${widget.arguments['scenicSpotLocation']}',
                    maxLines: 20,
                  )
                  )
                ],
              ),
              trailing: Stack(
                children: [
                  Padding(
                      child: Icon(
                        Icons.circle,
                        size: 42,
                        color: (!favor)?Colors.grey:Colors.yellowAccent,
                      ),
                      padding: EdgeInsets.only(top: 8, right: 0)),
                  Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: IconButton(
                        onPressed: () {
                          getid().then((value){
                            favorObject('myFavorScenicSpot', value, widget.arguments['scenicSpotID'],context);
                          });
                          setState(() {
                            favor = true;
                          });
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        )),
                  ),
                ],
              )),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 240,
            child: SingleChildScrollView(
              child: Text(
                '简介${widget.arguments['introduction']}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/comments',arguments: {'scenicSpotID':widget.arguments['scenicSpotID'],'paceNoteID':''});

          },
          child: Padding(padding: EdgeInsets.all(10),child:
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.comment,color: Colors.black,),
              Text(
                '查看全部评论',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),)
        ),

      ],
    ));
  }
}
