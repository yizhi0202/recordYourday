import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/map_base_page_state.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:dio/dio.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMFPoint;






class myPaceNoteDetailPage extends StatefulWidget {
  Map arguments;
  myPaceNoteDetailPage({Key? key, required this.arguments}) : super(key: key);
  @override
  _myPaceNoteDetailPageState createState() => _myPaceNoteDetailPageState();
}

class _myPaceNoteDetailPageState extends BMFBaseMapState<myPaceNoteDetailPage> {
  String imgUrl = 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png';
  List isClockInList = [false,false];
  List<Widget> spotList = [];
  void clockIn(BMFMarker marker)
  {
    //先判断经纬度是否符合再改变颜色
    myMapController.removeMarker(marker);
    marker.icon = 'images/animation_green.png';
    myMapController.addMarker(marker);
  }

  LocationFlutterPlugin baibuGps(){
  //创建一个定位对象，后续操作时使用
  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

// 设置安卓定位参数(按官方文档复制过来就可以了)
  BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
  androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
  androidOption.setIsNeedAltitude(false); // 设置是否需要返回海拔高度信息
  androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
  androidOption.setIsNeedLocationPoiList(false); // 设置是否需要返回周边poi信息
  androidOption.setIsNeedNewVersionRgc(false); // 设置是否需要返回最新版本rgc信息
  androidOption.setIsNeedLocationDescribe(false); // 设置是否需要返回位置描述
  androidOption.setOpenGps(false); // 设置是否需要使用gps
  androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
  androidOption.setScanspan(0); // 设置发起定位请求时间间隔
  Map androidMap = androidOption.getMap();

//ios定位参数设置(用不上也要设置,按默认就可以了)
  BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
  Map iosdMap = iosOption.getMap();

  _locationPlugin.requestPermission(); //请求定位权限
  _locationPlugin.prepareLoc(androidMap,iosdMap); //ios和安卓定位设置

  _locationPlugin.startLocation(); //开始定位
  return _locationPlugin;
  //  获取定位结果
  //_locationPlugin.stopLocation();//停止定位（这里暂时不用）
}
  Widget getMyScenicSpot(String info, int index)
  {
    List infoList = info.split("&&&").where((s) => !s.isEmpty).toList();
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
                LocationFlutterPlugin _locationPlugin = baibuGps();
                var gps=_locationPlugin.onResultCallback();
                gps.listen((event) {
                  double Lo = event['longitude'] as double;
                  double La = event['latitude'] as double;
                  print('address is'+event['address'].toString());
                  print('lo is '+Lo.toString());
                  print('la is '+La.toString());
                  print('info lo' + infoList[5]);
                  print('info la' + infoList[4]);
                  print('userID in arguments '+widget.arguments['info']['userID']);
                   _locationPlugin.stopLocation();
                  if( (double.parse(infoList[4])-La).abs()<0.01 && (double.parse(infoList[5])-Lo).abs()<0.01)
                  {
                    print('userID in arguments '+widget.arguments['info']['userID']);
                    Dio().post(
                    'https://hello-cloudbase-7gk3odah3c13f4d1.service.tcloudbase.com/clockIn',
                    data: {'userID': widget.arguments['info']['userID']}).then((value) {
                    });
                    if(mounted)
                      {
                        setState(() {
                          isClockInList[index] = true;
                          // /// 创建BMFMarker
                          // BMFMarker marker = BMFMarker(
                          //     position: BMFCoordinate(double.parse(infoList[4]), double.parse(infoList[5])),
                          //     title: 'flutterMaker',
                          //     identifier: 'flutter_marker',
                          //     icon: 'images/animation_red.png');
                          // clockIn(marker);
                        });
                      }
                  }
                  return ;
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
          title: Text(infoList[1]),
          children: [
            Text(infoList[2]),
            Text(infoList[3]),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 270,
                width: 480,
                child: Image.network(
                  infoList[0],
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
    Map paceNote = widget.arguments['info'];
    List info = paceNote['scenicSpotInfo'].split("###").where((s) => !s.isEmpty).toList();
    List<Widget> spots = [];
    int len = 0;
    for(var i in info)
    {
      spots.add(getMyScenicSpot(i, len));
      len++;
    }
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
        Padding(padding: EdgeInsets.all(10),child: Container(height: 220,child: Image.network(paceNote['photo']),)),
        Padding(padding: EdgeInsets.all(10),child: Row(mainAxisSize: MainAxisSize.min,children: [Text('路书标题'),GestureDetector(onTap: (){
          freshMap();
        },child: ButtonBar(children: [Text('显示地点图标'),FaIcon(FontAwesomeIcons.syncAlt)],),)],),),
        Container(height: 380,width:180,child:  BMFMapWidget(
          onBMFMapCreated: onBMFMapCreated,
          mapOptions: initMapOptions(),
        ),),
        ListView(shrinkWrap: true,
        children: spots,)
      ],));
  }
}
