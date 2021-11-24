import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

class myScenicSpotPage extends StatefulWidget {
  @override
  _myScenicSpotPageState createState() => _myScenicSpotPageState();
}

class _myScenicSpotPageState extends State<myScenicSpotPage> {
  List<Widget> myScenicSpotList = [];// 用于渲染
  List myScenicSpotInfoList = [];    //用于删除数据的传递
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  int getNum = 0;  //the number to control the amount of Spots
  int preGetNum = 0;
  int maxNum = 0;
  List<Widget> temp =[];
  MultiSelectController controller = MultiSelectController();
  MultiSelectController infoController = MultiSelectController();
  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }

  void _getMoreData() async {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    if (!isLoading) {
      if(mounted)
      {
        setState(() {
          isLoading = true;
        });
      }
      getid().then((value) async{//获取userＩＤ
        var res =  await db.collection('scenicSpot').where({
          'userID':value
        }).skip(getNum).limit(15).get();
        getNum+=5;
        if(mounted)
        {
          setState(() {
            
            myScenicSpotInfoList = res.data;
            myScenicSpotInfoList.forEach((element) {
              temp.add(getMyScenicSpot(element['_id'], element['title'], element['address'], element['introduction'], BMFCoordinate(element['latitude'],element['longitude']), element['voteNum'],element['scenicSpotPhotoUrl']));
            });
            myScenicSpotList = temp;
            controller.set(myScenicSpotList.length);
            isLoading = false;
          });
        }
      });
    }
  }
  Widget getMyScenicSpot(String scenicSpotID, String scenicSpotName, String scenicSpotLocation, String introduction, BMFCoordinate position, int voteNum,String photoURL)
  {
    return Card(
      child: ListTile(leading: Icon(Icons.nature_people,color: Colors.green,),title: Text(scenicSpotName),trailing: Row(mainAxisSize:MainAxisSize.min ,children: [IconButton(onPressed: (){
        Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
          'scenicSpotID':scenicSpotID,
          'scenicSpotName': scenicSpotName,
          'scenicSpotLocation': scenicSpotLocation,
          'introduction':introduction,
          'position': position,
          'voteNum': voteNum,
          'photoURL':photoURL
        });
      }, icon: FaIcon(FontAwesomeIcons.hiking)),GestureDetector(child: Text('景点详情'),onTap: (){
        Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
          'scenicSpotID':scenicSpotID,
          'scenicSpotName': scenicSpotName,
          'scenicSpotLocation': scenicSpotLocation,
          'introduction':introduction,
          'position': position,
          'voteNum': voteNum,
          'photoURL':photoURL
        });
      },),FaIcon(FontAwesomeIcons.heart),Text(voteNum.toString())],)),
    );
  }

  void deleteScenicSpot() {
    var list = controller.selectedIndexes;
    var infoList = controller.selectedIndexes;
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    var _ = db.command;
    Collection collection = db.collection('scenicSpot');

    list.sort((b, a) =>
        a.compareTo(b));
    infoList.sort((b,a)=>a.compareTo(b));
    infoList.forEach((element) {
      collection.where({'_id':myScenicSpotInfoList[element]['_id']}).remove()
          .then((res) {
      })
          .catchError((e) {
          print(e);
      });
    });
    list.forEach((element) {
      myScenicSpotList.removeAt(element);
    });
    setState(() {
      controller.set(myScenicSpotList.length);
      infoController.set(myScenicSpotInfoList.length);
    });
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
      infoController.toggleAll();
    });
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
    infoController.disableEditingWhenNoneSelected = false;
    infoController.set(myScenicSpotInfoList.length);
    controller.disableEditingWhenNoneSelected = false;
    controller.set(myScenicSpotList.length);
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
        title: Text('我的景点'),
      ),
      body: ListView(
        children: [
          Row(
              children:[IconButton(
                icon: FaIcon(FontAwesomeIcons.checkSquare),
                onPressed: selectAll,
              ),Text('全选'),
                IconButton(
                  icon: Icon(Icons.delete,),
                  onPressed: deleteScenicSpot,
                ),Text('删除')]
          ),
          Container(
            height: 680,
            child: ListView.builder(shrinkWrap:true,itemCount:myScenicSpotList.length+1,controller: _scrollController,itemBuilder: (context,index){
             if(index == myScenicSpotList.length) return _buildProgressIndicator();
             else return InkWell(
               onTap: (){},
               child: MultiSelectItem(isSelecting: controller.isSelecting, onSelected: (){setState(() {
                 controller.toggle(index);
               });},child: Container(
                 color: controller.isSelected(index)
                     ? Colors.yellowAccent:Colors.transparent,
                 height:75,
                 margin: EdgeInsets.only(left:10,right:10,top:10),
                 child:myScenicSpotList[index],
               ),
               ),
             );
            }),
          )
        ],
      ),
    );
  }
}
