import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/map_base_page_state.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';


class myPaceNoteDetailPage extends StatefulWidget {
  @override
  _myPaceNoteDetailPageState createState() => _myPaceNoteDetailPageState();
}

class _myPaceNoteDetailPageState extends BMFBaseMapState<myPaceNoteDetailPage> {
  String imgUrl = 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png';
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
              Text('开始旅途')
            ],
          ),
        ),
      ],
      ),body:ListView(
      children: [
        Padding(padding: EdgeInsets.all(10),child: Container(height: 180,child: Image.network(imgUrl),)),
        Padding(padding: EdgeInsets.all(10),child: Text('路书标题'),),
        //Container(height: 380,width:280,child: generateMap()),
      ],
    ),
    );
  }
}
