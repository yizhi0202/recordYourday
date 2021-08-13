import 'package:flutter/material.dart';
import 'package:fancy_bar/fancy_bar.dart';
import 'tabs/scenicSpotPage.dart';
import 'tabs/emgContactPage.dart';
import 'tabs/paceNotePage.dart';
import 'tabs/selfHomePage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class tab extends StatefulWidget {
  tab({Key? key}) : super(key: key);

  @override
  _tabState createState() => _tabState();
}

class _tabState extends State<tab> {
  int _currentIndex = 0;
  Color selectColor = Colors.yellow;
  List _pageList = [
    paceNotePage(),
    scenicSpotPage(),
    paceNotePage(),
    emgContactPage(),
    selfHomePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: this._pageList[this._currentIndex],
        floatingActionButton: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 22),
          child: SpeedDial(
            tooltip: '新建景点或者路书',
            childrenButtonSize: 60,
            direction: SpeedDialDirection.Up,
            overlayColor: Colors.grey,
            backgroundColor: Colors.yellow,
            child: Icon(
              Icons.add,
              color: Colors.white70,
              size: 60,
            ),
            children: [
              SpeedDialChild(
                  child: Icon(Icons.nature_people),
                  backgroundColor: Colors.green,
                  label: '新建景点',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => print('SECOND CHILD')),
              SpeedDialChild(
                child: Icon(Icons.menu_book),
                backgroundColor: Colors.yellow,
                label: '新建路书',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('FIRST CHILD'),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: FancyBottomBar(
          type: FancyType.FancyV2, // Fancy Bar Type
          items: [
            FancyItem(
                textColor: Colors.yellow,
                title: '路书',
                icon: Icon(
                  Icons.menu_book,
                  color: Colors.grey,
                )),
            FancyItem(
                textColor: Colors.green,
                title: '景点',
                icon: Icon(
                  Icons.nature_people,
                  color: Colors.grey,
                )),
            FancyItem(
                textColor: Colors.yellow, title: '加号', icon: Icon(Icons.face)),
            FancyItem(
                textColor: Colors.red,
                title: '紧急联系人',
                icon: Icon(
                  Icons.people,
                  color: Colors.grey,
                )),
            FancyItem(
              textColor: Colors.lightBlue,
              title: '我的',
              icon: Icon(
                Icons.account_circle,
                color: Colors.grey,
              ),
            ),
          ],
          onItemSelected: (index) {
            setState(() {
              if (index != 2) this._currentIndex = index;
            });
          },
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: this._currentIndex,
        //   onTap: (int index) {
        //     setState(() {
        //       this._currentIndex = index;
        //     });
        //   },
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: "首页",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.cabin),
        //       label: "分类",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.sailing),
        //       label: "设置",
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

// class HomeContent extends StatefulWidget {
//   HomeContent({Key key}) : super(key: key);
//   int countNum = 1;

//   @override
//   _HomeContentState createState() => _HomeContentState();
// }

// class _HomeContentState extends State<HomeContent> {
//   int countNum = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(height: 200),
//         Chip(
//           label: Text('$countNum'),
//         ),
//         SizedBox(height: 20),
//         RaisedButton(
//           child: Text("按钮"),
//           onPressed: () {
//             setState(() {
//               this.countNum++;
//             });
//           },
//         )
//       ],
//     );
//   }
// }
