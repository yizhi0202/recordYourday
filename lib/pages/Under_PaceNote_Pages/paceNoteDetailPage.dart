import 'package:flutter/material.dart';
import 'package:flutter_app_y/pages/Under_ScenicSpot_Pages/comment.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:flutter_app_y/res/module/paceNote/paceNote.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_y/res/module/likeAndFavor/likeAndFavorFunction.dart';

class paceNoteDetailPage extends StatefulWidget {
  Map arguments;
  paceNoteDetailPage({Key? key, required this.arguments}) : super(key: key);


  @override
  _paceNoteDetailPageState createState() => _paceNoteDetailPageState();
}

class _paceNoteDetailPageState extends State<paceNoteDetailPage> {
  bool favor = false;
  bool isLoading  = false;
  List commentList = [];
  ScrollController _scrollController  =ScrollController();
  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }
  _getMoreData() async
  {
    if(!isLoading)
    {
      setState(() {
        isLoading = true;
      });
    }
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    var res = await db.collection('comments').where({'objectID':widget.arguments['paceNoteID']}).limit(3).get();
    if(res.data.length == 0)
    {
      showToast(context, '此路书还没有发表评论，抢沙发吧!');
      setState(() {
        isLoading = false;
      });
    }
    else{
      List temp = [];
      int len = 0;
      res.data.forEach((element) async{
        var result  = await db.collection('userInfo').where({'userID':element['userID']}).get();
        temp.add(comment(content: element['content'], profilePhoto: result.data[0]['profilePhoto'], nickname: result.data[0]['nickName']));
        len++;
        if(len == res.data.length)
        {
          if(mounted)
          {
            setState(() {
              isLoading = false;
              commentList = temp;
            });
          }
        }
      });
    }
  }

  @override
  void initState() {
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
  Widget _buildList() {
    return ListView.builder(
//+1 for progressbar
      itemCount: commentList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == commentList.length) {
          return _buildProgressIndicator();
        } else {
          return commentList[index];
        }
      },
      controller: _scrollController,
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    List info = widget.arguments['scenicSpotInfo'].split("###").where((s) => !s.isEmpty).toList();
    List<Widget> spots = [];
    for(var i in info)
    {
      List spot = i.split("&&&").where((s) => !s.isEmpty).toList();
      spots.add(
        Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: ExpansionTile(
                expandedAlignment: Alignment.topLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: EdgeInsets.all(10),
                leading: GFIconButton(
                  color: Colors.yellow,
                  icon: Text(
                    (spots.length+1).toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {},
                  shape: GFIconButtonShape.circle,
                ),
                title: Text(spot[1]),
                children: [
                  Text(spot[2]),
                  Text(spot[3]),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 270,
                      width: 480,
                      child: Image.network(
                        spot[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: false,
      body: ListView(
        children: [
          Container(
              height: 260,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.arguments['photo'],
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
                      color: Colors.white24,
                    ),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.all(10),
            //
            child: ListTile(
              title: Text(widget.arguments['title']),
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
                            favorObject('myFavorPaceNote', value, widget.arguments['paceNoteID'],context);
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
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  widget.arguments['profilePhoto'],
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              title: Text(widget.arguments['nickName']),
              trailing: Text("发布时间"+DateTime.now().toString()),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 180,
              child: SingleChildScrollView(
                child: Text(
                  widget.arguments['note'],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Container(height: 380,child: ListView(
            children: spots,
            shrinkWrap: true,
          ),),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/comments',arguments: {'paceNoteID':widget.arguments['paceNoteID'],'scenicSpotID':''});
            },
            child:Padding(padding: EdgeInsets.all(10),child:
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
          Container(height: 180,child:
          _buildList(),)
        ],
      ),
    );
    // return Container(
    //     decoration: BoxDecoration(
    //         image: DecorationImage(
    //       image: NetworkImage(
    //           'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
    //       fit: BoxFit.cover,
    //     )),
    //     child: Scaffold(
    //         backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
    //         appBar: AppBar(
    //           backgroundColor: Colors.transparent, //把appbar的背景色改成透明
    //           elevation: 0, //appbar的阴影
    //         ),
    //         body: Center(
    //           child: Text('Hello World'),
    //         )));

    // body: ListView(
    //   children: [
    //     Container(
    //       height: 260,
    //       child: Image.network(
    //         'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png',
    //         fit: BoxFit.cover,
    //       ),
    //     )
    //   ],
    // ),
  }
}