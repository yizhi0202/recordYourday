import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';

class myFavoritePage extends StatefulWidget {
  @override
  _myFavoritePageState createState() => _myFavoritePageState();
}
//Navigator.pushNamed(context, '/myPaceNoteDetail')
class _myFavoritePageState extends State<myFavoritePage> {
  List<Widget> myFavorPaceNoteList = []; //渲染用
  List<Widget> myFavorSpotList = [];
  List myFavorSpotInfoList = [];        //删除信息时用
  List myFavorPaceNoteInfoList = [];

  ScrollController _scrollControllerOfPaceNote = new ScrollController();
  ScrollController _scrollControllerOfSpot = new ScrollController();
  bool isLoadingOfPaceNote = false;
  bool isLoadingOfSpot = false;
  MultiSelectController myFavorPaceNotesController = MultiSelectController();
  MultiSelectController infoOfPaceNoteController = MultiSelectController();
  MultiSelectController myFavorSpotsController = MultiSelectController();
  MultiSelectController infoOfSpotController = MultiSelectController();
  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }

  void _getMoreScenicSpotData() async {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    if (!isLoadingOfSpot) {
      if(mounted)
      {
        setState(() {
          isLoadingOfSpot = true;
        });
      }
      getid().then((value) async{//获取userＩＤ
        var res =  await db.collection('myFavorScenicSpot').where({
          'userID':value
        }).get();
        myFavorSpotInfoList = res.data;
        List<Widget> temp = [];
        int len= 0;//信号量控制最后的渲染
        myFavorSpotInfoList.forEach((element) async{
          var result = await db.collection('scenicSpot').where({'_id':element['scenicSpotID']}).get();//注意 我的收藏中的景点ID是scenicSpotID,而在景点表中是_id
          if(result.data.length != 0)
            {
              temp.add(getMyFavorSpot(result.data[0]['_id'], result.data[0]['title'], result.data[0]['address'], result.data[0]['introduction'], BMFCoordinate(result.data[0]['latitude'],result.data[0]['longitude']), result.data[0]['voteNum'], result.data[0]['scenicSpotPhotoUrl']));
            }
          len++;
          if(len == myFavorSpotInfoList.length)
          {
            if(mounted)
            {
              setState(() {
                myFavorSpotList = temp;
                myFavorSpotsController.set(myFavorSpotList.length);
                isLoadingOfSpot = false;
              });
            }
          }

        });
      });
    }
  }

    void _getMorePaceNoteData() async {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    if (!isLoadingOfPaceNote) {
      if(mounted)
      {
        setState(() {
          isLoadingOfPaceNote = true;
        });
      }
      getid().then((value) async{//获取userＩＤ
        var res =  await db.collection('myFavorPaceNote').where({
          'userID':value
        }).get();
        myFavorPaceNoteInfoList = res.data;
        List<Widget> temp = [];
        int len= 0;//信号量控制最后的渲染
        myFavorPaceNoteInfoList.forEach((element) async{
          var result = await db.collection('paceNote').where({'_id':element['paceNoteID']}).get();//注意 我的收藏中的景点ID是scenicSpotID,而在景点表中是_id
          if(result.data.length != 0)
            {
              temp.add(getMyFavorPaceNote(title:result.data[0]['title'], voteNum:result.data[0]['voteNum'], photo:result.data[0]['photo'], userID:result.data[0]['userID'], note:result.data[0]['note'],scenicSpotInfo:result.data[0]['scenicSpotInfo'], paceNoteID:result.data[0]['_id'] ));
            }
          len++;
          if(len == myFavorPaceNoteInfoList.length)
          {
            if(mounted)
            {
              setState(() {
                myFavorPaceNoteList = temp;
                myFavorPaceNotesController.set(myFavorPaceNoteList.length);
                isLoadingOfPaceNote = false;
              });
            }
          }

        });
      });
    }
  }
  Future getNickName(String userID) async {
    
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    var res = await db.collection('userInfo').where({
      'userID':userID
    }).get();
    return res.data;
  }
  Widget getMyFavorPaceNote({String title = '',int voteNum = 0, String photo = 'https://www.itying.com/images/flutter/4.png', String userID = "", String note = "", String scenicSpotInfo = "", String paceNoteID = ""})
  {
    return Card(
      child: Column(
       mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 190,width: 340,child: Image.network(photo,fit: BoxFit.cover,),),
      Row(mainAxisSize: MainAxisSize.min,children: [
          Text(title,overflow: TextOverflow.ellipsis,),
          // SizedBox(width: 160,),
        ],),
          //Container(width: 380,child:  ListTile(leading: Container(height: 180,child: Image.network(photo),),title: Text(title,overflow: TextOverflow.ellipsis,),subtitle:Text(nickName)),),
          ButtonBar(
          children: [IconButton(onPressed: (){
            getNickName(userID).then((info)
            {
                Navigator.pushNamed(context, '/paceNoteDetail',arguments:{
                'paceNoteID': paceNoteID,
                'profilePhoto':info[0]['profilePhoto'],
                'userID':userID,
                'title': title,
                'nickName':info[0]['nickName'],
                'voteNum':voteNum,
                'score': 60,
                'photo':photo,
                'note': note,
                'scenicSpotInfo': scenicSpotInfo
            });
            }
          );
            
          }, 
        icon: FaIcon(FontAwesomeIcons.hiking)),
        GestureDetector(
        child: Text('路书详情页'),
        onTap: (){}),SizedBox(width: 20,),
        FaIcon(FontAwesomeIcons.heart),
        Text(voteNum.toString())],
          )
        ],
      ),
    );
  }

  Widget getMyFavorSpot(String scenicSpotID, String scenicSpotName, String scenicSpotLocation, String introduction, BMFCoordinate position, int voteNum,String photoURL)
  {
    List<String> photos = photoURL.split("###").where((s) => !s.isEmpty).toList();
    return Card(
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 190,width: 340,child: Image.network(photos[0],fit: BoxFit.cover,),),
          Row(mainAxisSize: MainAxisSize.min,children: [
            Text(scenicSpotName,overflow: TextOverflow.ellipsis,),
            // SizedBox(width: 160,),
          ],),
          //Container(width: 380,child:  ListTile(leading: Container(height: 180,child: Image.network(photo),),title: Text(title,overflow: TextOverflow.ellipsis,),subtitle:Text(nickName)),),
          ButtonBar(children: [IconButton(onPressed: (){
            Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
              'scenicSpotID':scenicSpotID,
              'scenicSpotName': scenicSpotName,
              'scenicSpotLocation': scenicSpotLocation,
              'introduction':introduction,
              'position': position,
              'voteNum': voteNum,
              'photoURL':photoURL
            });
          }, icon: FaIcon(FontAwesomeIcons.hiking)),GestureDetector(child: Text('景点详情页'),onTap: (){
            Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
              'scenicSpotID':scenicSpotID,
              'scenicSpotName': scenicSpotName,
              'scenicSpotLocation': scenicSpotLocation,
              'introduction':introduction,
              'position': position,
              'voteNum': voteNum,
              'photoURL':photoURL
            });
          }),SizedBox(width: 20,),FaIcon(FontAwesomeIcons.heart),Text(voteNum.toString())],
          )
        ],
      ),
    );
  }
  void deleteMyFavorSpot() {
    var list = myFavorSpotsController.selectedIndexes;
    var infoList = infoOfSpotController.selectedIndexes;
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    var _ = db.command;
    Collection collection = db.collection('myFavorScenicSpot');

    list.sort((b, a) =>
        a.compareTo(b));
    infoList.sort((b,a)=>a.compareTo(b));
    infoList.forEach((element) {
      collection.where({'_id':myFavorSpotInfoList[element]['scenicSpotID'],'userID':myFavorSpotInfoList[element]['userId']}).remove()
          .then((res) {
      })
          .catchError((e) {
        print(e);
      });
    });
    list.forEach((element) {
      myFavorSpotList.removeAt(element);
    });
    setState(() {
      myFavorSpotsController.set(myFavorSpotList.length);
      infoOfSpotController.set(myFavorSpotInfoList.length);
    });
  }

  void selectAllFavorSpot() {
    setState(() {
      myFavorSpotsController.toggleAll();//组件的选中
      infoOfSpotController.toggleAll();//底层数据的选中
    });
  }


  @override
  void initState() {
    this._getMoreScenicSpotData();
    this._getMorePaceNoteData();
    super.initState();
    _scrollControllerOfSpot.addListener(() {
      if (_scrollControllerOfSpot.position.pixels ==
          _scrollControllerOfSpot.position.maxScrollExtent) {
        _getMoreScenicSpotData();
      }
      
    });
    _scrollControllerOfPaceNote.addListener(() {
      if (_scrollControllerOfPaceNote.position.pixels ==
          _scrollControllerOfPaceNote.position.maxScrollExtent) {
        _getMorePaceNoteData();
      }
    });
    infoOfSpotController.disableEditingWhenNoneSelected = false;
    infoOfSpotController.set(myFavorSpotInfoList.length);
    myFavorSpotsController.disableEditingWhenNoneSelected = false;
    myFavorSpotsController.set(myFavorSpotList.length);

    infoOfPaceNoteController.disableEditingWhenNoneSelected = false;
    infoOfPaceNoteController.set(myFavorSpotInfoList.length);
    myFavorPaceNotesController.disableEditingWhenNoneSelected = false;
    myFavorPaceNotesController.set(myFavorPaceNoteList.length);
  }
  @override
  void dispose() {
    _scrollControllerOfSpot.dispose();
    _scrollControllerOfPaceNote.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicatorOfSpot() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingOfSpot ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  Widget _buildProgressIndicatorOfPaceNote() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingOfPaceNote ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void deleteMyFavorPaceNote() {
    var list = myFavorPaceNotesController.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b));
    list.forEach((element) {
      myFavorPaceNoteList.removeAt(element);
    });

    setState(() {
      myFavorPaceNotesController.set(myFavorPaceNoteList.length);
    });
  }


  void selectAllFavorPaceNote() {
    setState(() {
      myFavorPaceNotesController.toggleAll();//渲染的组件选中
      infoOfPaceNoteController.toggleAll();//底层数据的选中
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
          color: Colors.white24,
        ),
        title: Text('我的路书'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body:  ListView(
        children: [
              ExpansionTile(leading:Icon(Icons.menu_book,color: Colors.yellow,),title: Text('收藏的路书'),children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                    children:[IconButton(
                      icon: FaIcon(FontAwesomeIcons.checkSquare),
                      onPressed: selectAllFavorPaceNote,
                    ),Text('全选'),
                      IconButton(
                        icon: Icon(Icons.delete,),
                        onPressed: deleteMyFavorPaceNote,
                      ),Text('删除')]
                ),

                Container(
                  height: 680,
                  child: ListView.builder(shrinkWrap:true,itemCount:myFavorPaceNoteList.length,itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){},
                      child: MultiSelectItem(isSelecting: myFavorPaceNotesController.isSelecting, onSelected: (){setState(() {
                        myFavorPaceNotesController.toggle(index);
                      });},child: Container(
                        color: myFavorPaceNotesController.isSelected(index)
                            ? Colors.yellowAccent:Colors.transparent,
                        height:290,
                        margin: EdgeInsets.only(left:10,right:10,top:30),
                        child:myFavorPaceNoteList[index],
                      ),
                      ),
                    );
                  }),
                )
              ],),
          ExpansionTile(leading:Icon(Icons.nature_people,color:Colors.green,),title: Text('收藏的景点'),children: [
            Row(
                mainAxisSize: MainAxisSize.min,
                children:[IconButton(
                  icon: FaIcon(FontAwesomeIcons.checkSquare),
                  onPressed: selectAllFavorSpot,
                ),Text('全选'),
                  IconButton(
                    icon: Icon(Icons.delete,),
                    onPressed: deleteMyFavorSpot,
                  ),Text('删除')]
            ),

            Container(
              height: 680,
              child: ListView.builder(shrinkWrap:true,itemCount:myFavorSpotList.length,itemBuilder: (context,index){
                return InkWell(
                  onTap: (){},
                  child: MultiSelectItem(isSelecting: myFavorSpotsController.isSelecting, onSelected: (){setState(() {
                    myFavorSpotsController.toggle(index);
                  });},child: Container(
                    color: myFavorSpotsController.isSelected(index)
                        ? Colors.yellowAccent:Colors.transparent,
                    height:290,
                    margin: EdgeInsets.only(left:10,right:10,top:10),
                    child:myFavorSpotList[index],
                  ),
                  ),
                );
              }),
            )

          ],)
        ],
      )
      );
  }
}
