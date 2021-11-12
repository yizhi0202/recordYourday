import 'package:flutter/material.dart';

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
            child: Image.network(
              'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/paceNotePhoto/IMG_1636716605212.png',
              fit: BoxFit.cover,
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
