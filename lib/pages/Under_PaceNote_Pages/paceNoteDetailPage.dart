import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class paceNoteDetailPage extends StatefulWidget {
  const paceNoteDetailPage({Key? key}) : super(key: key);

  @override
  _paceNoteDetailPageState createState() => _paceNoteDetailPageState();
}

class _paceNoteDetailPageState extends State<paceNoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      primary: false,
      body: ListView(
        children: [
          Container(
              height: 260,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png',
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
            child: Text(
              'the title of pacenote',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  'https://www.itying.com/images/flutter/1.png',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              title: Text('此人昵称'),
              trailing: Text('发布时间xxx-xx-xx'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 240,
              child: SingleChildScrollView(
                child: Text(
                  '{路书感受}' * 100,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
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
          )
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

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
