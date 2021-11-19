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
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  List finalSpotData = [];
  Future getFinalSpotData() async {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection userInfo = db.collection('userInfo');

    List temp = await getHttp();
    int len = 0;
    temp.forEach((element) async {
      var result = await userInfo.where({'userID': element['userID']}).get();
      element['nickName'] = result.data[0]['nickName'];
      element['profilePhoto'] = result.data[0]['profilePhoto'];
      len++;
      if (len == temp.length) {
        if(mounted)
          {
            setState(() {
              isLoading = false;
              _list = temp;
            });
          }
      }
    });
  }

  void _getMoreData() async {
    if (!isLoading) {
      if(mounted)
        {
          setState(() {
            isLoading = true;
          });
        }
      getFinalSpotData();
    }
  }

  @override
  initState() {
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  Future getHttp() async {
    try {
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseDatabase db = CloudBaseDatabase(core);
      var res = await db.collection('scenicSpot').get();

      return res.data;
    } catch (e) {
      return print(e);
    }
  }

  Widget buildGrid() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    for (var i in _list) {
      tiles.add(new scenicSpot(
          scenicSpotID: i['_id'],
          userID: i['userID'],
          position: BMFCoordinate(i['longitude'], i['latitude']),
          photoUrl: i['scenicSpotPhotoUrl'],
          title: i['title'],
          address: i['address'],
          introduction: i['introduction'],
          subTitle: i['subtitle'],
          voteNum: i['voteNum'],
          nickName: i['nickName'],
          profilePhoto: i['profilePhoto'],
      ),

      );
    }
    return ListView.builder(
//+1 for progressbar
      itemCount: tiles.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == tiles.length) {
          return _buildProgressIndicator();
        } else {
          return tiles[index];
        }
      },
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {

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
      body: buildGrid(),
      resizeToAvoidBottomInset: false,
    );
  }
}
