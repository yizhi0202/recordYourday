import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/map_base_page_state.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';




class myPaceNoteDetailPage extends StatefulWidget {
  @override
  _myPaceNoteDetailPageState createState() => _myPaceNoteDetailPageState();
}

class _myPaceNoteDetailPageState extends BMFBaseMapState<myPaceNoteDetailPage> {
  String imgUrl = 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png';
  List isClockInList = [false,false];


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
        Padding(padding: EdgeInsets.all(10),child: Text('路书标题'),),
        Container(height: 380,width:180,child:  BMFMapWidget(
          onBMFMapCreated: onBMFMapCreated,
          mapOptions: initMapOptions(),
        ),),
        getMyScenicSpot(0),
        getMyScenicSpot(1)
      ],));
  }
}
