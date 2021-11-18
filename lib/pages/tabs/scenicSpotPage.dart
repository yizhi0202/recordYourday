import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/scenicSpot/scenicSpot.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'

    show BMFModel, BMFCoordinate;
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';

class scenicSpotPage extends StatefulWidget {
  scenicSpotPage({Key? key}) : super(key: key);

  @override
  _scenicSpotPageState createState() => _scenicSpotPageState();
}
 
class _scenicSpotPageState extends State<scenicSpotPage> {

  
    
  List _list = [];

  initState() {
      super.initState();
      getHttp().then((val){
        setState(() {
          _list = val;
          print('_list内容为');
          print(_list);
          print(_list.length);
        });
      });
    }


  Future getHttp() async{
     try{
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseStorage storage = CloudBaseStorage(core);
      CloudBaseDatabase db = CloudBaseDatabase(core);
      var res = await db.collection('scenicSpot').get();
      return res.data;



     }catch(e){
      return print(e);
     }
    }

   Widget buildGrid() {
      List<Widget> tiles = [];//先建一个数组用于存放循环生成的widget
      for(var i in _list) {
        tiles.add(
          new scenicSpot(scenicSpotID: i['scenicSpotID'],
          userID: i['creator'],
          position: BMFCoordinate(i['longitude'],i['latitude']),
          photoUrl: i['scenicSpotPhotoUrl'],
          title: i['title'],
          address: i['address'],
          introduction: i['introduction'],
          subTitle: i['subtitle'],
          voteNum: i['voteNum'],
            profilePhoto: i['profilePhoto'],
            nickName: i['nickName'],
      )
        );
      }
      return ListView(
          children:tiles
      );
    }
  @override
  Widget build(BuildContext context) {
    BMFCoordinate? pt;
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseStorage storage = CloudBaseStorage(core);
    CloudBaseDatabase db = CloudBaseDatabase(core);

    return Scaffold(
      appBar: AppBar(
          primary: true,
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          title: Text('景点'),
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
        body: buildGrid());
  }
}
