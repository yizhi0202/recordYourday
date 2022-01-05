import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;


class searchPage extends StatefulWidget {
  Map arguments;
  searchPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController _keywordController = TextEditingController(); //检索用户输入的景点名
  List _list =[];  //存放检索最终结果
  List resultList = [];
  bool isLoading = false;
  Map? spot;
  dataBack(BuildContext context) {
    Navigator.pop(context, spot);
  }
  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseDatabase db = CloudBaseDatabase(core);
      if(widget.arguments['searchObject'] == 'scenicSpot')
        {
          var res = await db.collection('scenicSpot').where({'title':db.regExp(r'.*'+_keywordController.text+r'.*','i')}).get();
          if(mounted)
          {
            setState(() {
              isLoading = false;
              _list = res.data;
            });
          }
        }
      else{
        var res = await db.collection('paceNote').where({'title':db.regExp(r'.*'+_keywordController.text+r'.*','i')}).get();
        var temp = res.data;
        int len = 0;
        temp.forEach((element) async {
          var result = await db.collection('userInfo').where({'userID': element['userID']}).get();
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

    }
  }
  Widget getMyScenicSpot(String scenicSpotID, String scenicSpotName, String scenicSpotLocation, String introduction, BMFCoordinate position, int voteNum,String photoURL)
  {
    return GestureDetector(
      child: Card(
        child: ListTile(leading: Icon(Icons.nature_people,color: Colors.green,),title: Text(scenicSpotName),subtitle: Text(scenicSpotLocation),),
      ),
      onTap: (){
        Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
          'scenicSpotID':scenicSpotID,
          'scenicSpotName': scenicSpotName,
          'scenicSpotLocation': scenicSpotLocation,
          'introduction':introduction,
          'position': position,
          'voteNum': voteNum,
          'photoURL':photoURL
        });
      },
    );
  }

  Widget getMyPaceNote(String paceNoteID, String userID, String profilePhoto, String title, String nickName, int voteNum,int score, String photo, String note, String scenicSpotInfo)
  {
    return GestureDetector(
      child: Card(
        child: ListTile(leading: Icon(Icons.menu_book,color: Colors.yellow,),title: Text(title),subtitle: Text(note, maxLines: 1, overflow: TextOverflow.ellipsis,),),
      ),
      onTap: (){
        Navigator.pushNamed(context, '/paceNoteDetail',arguments:{
          'paceNoteID': paceNoteID,
          'profilePhoto': profilePhoto,
          'userID':userID,
          'title': title,
          'nickName':nickName,
          'voteNum':voteNum,
          'score':score,
          'photo':photo,
          'note': note,
          'scenicSpotInfo': scenicSpotInfo
        });
      },
    );
  }


  @override
  void initState() {
    super.initState();
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
  Widget _topSearchBar() {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 46,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width - 20 - 80,
            child: TextField(
              controller: _keywordController,
              decoration: InputDecoration(border: InputBorder.none,hintText: '输入查询对象名吧'),
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: _getMoreData)
        ],
      ),
    );
  }

  Widget buildGrid() {
    List temp = [];
    if(widget.arguments['searchObject']=='scenicSpot')
      {
        for(int i =0 ; i< _list.length;++i)
        {
          temp.add(getMyScenicSpot(_list[i]['_id'], _list[i]['title'], _list[i]['address'], _list[i]['introduction'], BMFCoordinate(_list[i]['latitude'],_list[i]['longitude']), _list[i]['voteNum'], _list[i]['scenicSpotPhotoUrl']));
        }
      }
    else{
      for(int i = 0; i< _list.length;++i)
        {
          temp.add(getMyPaceNote(_list[i]['_id'], _list[i]['userID'], _list[i]['profilePhoto'], _list[i]['title'], _list[i]['nickName'], _list[i]['voteNum'], _list[i]['score'],_list[i]['photo'], _list[i]['note'], _list[i]['scenicSpotInfo']));
        }
    }
    
    resultList = temp;
    return ListView.builder(itemCount:resultList.length+1,itemBuilder: (c,index){
      if (index == resultList.length) {
        return _buildProgressIndicator();
      } else {
        return resultList[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "返回",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("搜索页面"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.air), onPressed: () {}),
          ],
        ),
        body: Column(
          children: <Widget>[
            _topSearchBar(),
            Container(
              height: 380,
              child: buildGrid(),
            )
          ],
        ));
  }
}
