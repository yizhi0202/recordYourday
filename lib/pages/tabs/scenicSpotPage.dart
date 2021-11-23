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
import 'package:shared_preferences/shared_preferences.dart';

class scenicSpotPage extends StatefulWidget {
  scenicSpotPage({Key? key}) : super(key: key);

  @override
  _scenicSpotPageState createState() => _scenicSpotPageState();
}

class _scenicSpotPageState extends State<scenicSpotPage> {
  List _list = [];
  List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  int getNum = 0;  //the number to control the amount of Spots
  int preGetNum = 0;
  int maxNum = 0;
  String profilePhoto = '';
  bool isUserInfoLoading =false;
  bool isMale = true;
  String nickName ='';

  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }
  Future getFinalSpotData() async {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection userInfo = db.collection('userInfo');
    var contResult = await db.collection('scenicSpot').count();
    maxNum = contResult.total;
    if(getNum < maxNum)
    {
      List temp = await getHttp();
      preGetNum = getNum;
      getNum  = getNum + temp.length;
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
              _list.addAll(temp);
            });
          }

        }
      });
    }


  }
  void _getUserInfo() async{
    if(!isUserInfoLoading)
    {
      setState(() {
        isUserInfoLoading = true;
      });
    }
    getid().then((value) async{
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseDatabase db = CloudBaseDatabase(core);
      var res = await db.collection('userInfo').where({'userID':value}).get();
      if(mounted)
      {
        setState(() {
          isUserInfoLoading = false;
          if(res.data[0]['sex'] == 'female') isMale = false;
          profilePhoto = res.data[0]['profilePhoto'];
          nickName = res.data[0]['nickName'];
        });
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
    this._getUserInfo();
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
  Widget _buildUserInfoProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isUserInfoLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


  Future getHttp() async {
    try {
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseDatabase db = CloudBaseDatabase(core);
      var res = await db.collection('scenicSpot').orderBy('publishTime', 'desc').skip(getNum).limit(5).get();
      return res.data;
    } catch (e) {
      return print(e);
    }
  }

  Widget buildGrid() {

    for (int i = preGetNum; i < _list.length; ++i ) {
      tiles.add(new scenicSpot(
          scenicSpotID: _list[i]['_id'],
          userID: _list[i]['userID'],
          position: BMFCoordinate(_list[i]['latitude'], _list[i]['longitude']),
          photoUrl: _list[i]['scenicSpotPhotoUrl'],
          title: _list[i]['title'],
          address: _list[i]['address'],
          introduction: _list[i]['introduction'],
          subTitle: _list[i]['subtitle'],
          voteNum: _list[i]['voteNum'],
          nickName: _list[i]['nickName'],
          profilePhoto: _list[i]['profilePhoto'],
      ),
      );
    }
    preGetNum = _list.length;
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
            onPressed: () {
              Navigator.pushNamed(context, '/search',arguments: {'searchObject':'scenicSpot'});
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            (isUserInfoLoading)?_buildUserInfoProgressIndicator():
            GFDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              currentAccountPicture: GFAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    profilePhoto),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(nickName, style: TextStyle(fontSize: 18)),
                  Icon(
                    (isMale)?Icons.male:Icons.female,
                    color: (isMale)?Colors.lightBlue:Colors.pink,
                    size: 32,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                 Navigator.of(context).pushNamedAndRemoveUntil(
              "/loginPass", ModalRoute.withName("/loginPass"));
              },
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
