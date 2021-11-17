import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/map_base_page_state.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMFPoint;




class myPaceNoteDetailPage extends StatefulWidget {
  @override
  _myPaceNoteDetailPageState createState() => _myPaceNoteDetailPageState();
}

class _myPaceNoteDetailPageState extends BMFBaseMapState<myPaceNoteDetailPage> {
  String imgUrl = 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png';
  List isClockInList = [false,false];
  void clockIn(BMFMarker marker)
  {
    //先判断经纬度是否符合再改变颜色
    myMapController.removeMarker(marker);
    marker.icon = 'images/animation_green.png';
    myMapController.addMarker(marker);
  }


  Widget getMyScenicSpot(int index)
  {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: ExpansionTile(
          iconColor: Colors.yellowAccent,
          collapsedIconColor: Colors.black,
          expandedAlignment: Alignment.topLeft,
          textColor: Colors.black,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          trailing: Container(width: 160,child: Row(mainAxisSize: MainAxisSize.min,children: [
            GestureDetector(
              onTap: (){
                setState(() {
                    isClockInList[index] = true;

                    /// 创建BMFMarker
                    BMFMarker marker = BMFMarker(
                        position: BMFCoordinate(39.928617, 116.40329),
                        title: 'flutterMaker',
                        identifier: 'flutter_marker',
                        icon: 'images/animation_red.png');
                    clockIn(marker);

                });
              },
              child: ButtonBar(
                children: [
                  FaIcon(FontAwesomeIcons.mapMarkedAlt,color:(!isClockInList[index])?Colors.grey:Colors.greenAccent,),
                  Text('打卡',style: TextStyle(color: Colors.black),),
                ],
              ),
            ),
            ButtonBar(children: [
              FaIcon(FontAwesomeIcons.expand,),
              Text('展开')
            ],),
          ],)),
          childrenPadding: EdgeInsets.all(10),
          leading: GFIconButton(
            color: Colors.yellow,
            icon: Text(
              '序',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {},
            shape: GFIconButtonShape.circle,
          ),
          title: Text('第一段景点'),
          children: [
            Text('第一个景点对应的内容与图片'),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 270,
                width: 480,
                child: Image.network(
                  'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  freshMap()
  {
    /// 创建BMFMarker
    BMFMarker marker = BMFMarker(
        position: BMFCoordinate(39.928617, 116.40329),
        title: 'flutterMaker',
        identifier: 'flutter_marker',
        icon: 'images/animation_red.png');
    List<BMFMarker> markers = [];
    markers.add(marker);
    //删除原来地图上搜索出来的点
    myMapController.cleanAllMarkers();
    //将搜索出来的点显示在界面上
    myMapController.addMarkers(markers);
    //将地图中心点移动到选择的点
    myMapController.setCenterCoordinate(markers.first.position, true);


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(centerTitle: true,title: Text('我的路书'),leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
          color: Colors.white24,
        ),actions: [
          GestureDetector(
            onTap: () {

            },
            child: ButtonBar(
              children: [
                FaIcon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.yellow,
                ),
                Text('发表')
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
                
            },
            child: ButtonBar(
              children: [
                FaIcon(
                  FontAwesomeIcons.walking,
                  color: Colors.yellow,
                ),
                Text('开始旅途')
              ],
            ),
          ),
        ],
        ),body:ListView(
      children: [
        Padding(padding: EdgeInsets.all(10),child: Container(height: 220,child: Image.network(imgUrl),)),
        Padding(padding: EdgeInsets.all(10),child: Row(mainAxisSize: MainAxisSize.min,children: [Text('路书标题'),GestureDetector(onTap: (){
          freshMap();
        },child: ButtonBar(children: [Text('显示地点图标'),FaIcon(FontAwesomeIcons.syncAlt)],),)],),),
        Container(height: 380,width:180,child:  BMFMapWidget(
          onBMFMapCreated: onBMFMapCreated,
          mapOptions: initMapOptions(),
        ),),
        getMyScenicSpot(0),
        getMyScenicSpot(1)
      ],));
  }
}
