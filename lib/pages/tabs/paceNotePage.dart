import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../res/module/paceNote/paceNote.dart';

import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:getwidget/getwidget.dart';
import '../../res/module/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class paceNotePage extends StatefulWidget {
  paceNotePage({Key? key}) : super(key: key);

  @override
  _paceNotePageState createState() => _paceNotePageState();
}

class _paceNotePageState extends State<paceNotePage> {
  List _list = [];
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  List finalPaceNoteData = [];
  String profilePhoto = '';
  bool isUserInfoLoading =false;
  bool isMale = true;
  String nickName ='';

  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }


    Future getFinalPaceNoteData() async {
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
      setState(() {
        isLoading = true;
      });
      getFinalPaceNoteData();
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
      var res = await db.collection('paceNote').get();

      return res.data;
    } catch (e) {
      return print(e);
    }
  }

    Widget buildGrid() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    for (var i in _list) {
      tiles.add(new paceNote(
          paceNoteID: i['_id'],
          profilePhoto: i['profilePhoto'],
          userID:i['userID'],
          title: i['title'],
          nickName:i['nickName'],
          voteNum:i['voteNum'],
          score:i['score'],
          photo:i['photo'],
          note: i['note'],
          scenicSpotInfo: i['scenicSpotInfo']
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
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: Text('路书'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search',arguments: {'searchObject':'paceNote'});
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
        body: buildGrid()
        );
  }
}


