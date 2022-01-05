import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/scenicSpot/scenicSpot.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';

class searchScenicSpotPage extends StatefulWidget {
  searchScenicSpotPage({Key? key}) : super(key: key);

  @override
  _searchScenicSpotPageState createState() => _searchScenicSpotPageState();
}

class _searchScenicSpotPageState extends State<searchScenicSpotPage> {
    Map spot = {};
    List _list = [];
    final _keywordController =
    TextEditingController();
    dataBack(BuildContext context) {
    Navigator.pop(context, spot);
  }
    void _onTapSearch() async {
      
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    var res = await db.collection('scenicSpot').where({'title':db.regExp(r'.*'+_keywordController.text+r'.*','i')}).get();
    // List result = [];
    // for(var i in res.data)
    // {
    //   result.add(i);
    // }
    setState(() {
      _list = res.data;
    });
    
  }

    Widget buildGrid() {
    if(_list.length!=0)
    {
      List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    for (var i in _list) {
      tiles.add(new GestureDetector(
        child:Card(
          margin: EdgeInsets.all(10),
          child:ListTile(
            leading: Icon(Icons.nature_people,color: Colors.green,),
            title: Text(
              i['title'],
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            subtitle: Text(
              i['address'],
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          )
        ),
        onTap:(){
          setState(() {
            spot = i;
            Navigator.pop(context, spot);
          });
        }
      ),
      );
    }
    return ListView(children: tiles,);

    }
    else
    {
      return Padding(padding: EdgeInsets.zero);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            dataBack(context);
          },
        ),
        title: Text('景点地点选择'),
      ),
      body: Container(
        child: Column(
          children: [
            _topSearchBar(),
            Expanded(
              child: buildGrid(),
            ),
          ],
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
              decoration: InputDecoration(border: InputBorder.none,hintText: '输入心怡景点吧'),
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: _onTapSearch)
        ],
      ),
    );
  }
}