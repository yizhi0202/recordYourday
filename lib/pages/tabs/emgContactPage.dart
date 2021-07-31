import 'package:flutter/material.dart';
import '../../res/module/emgContact.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

List<Widget> emgContactList = [
  emgContact(
      name: '苏珊',
      profilePhoto: 'https://www.itying.com/images/flutter/1.png',
      phoneNumber: 18765467890),
  emgContact(
      name: '苏珊andognni',
      profilePhoto: 'https://www.itying.com/images/flutter/2.png',
      phoneNumber: 18765467890),
  emgContact(
    name: '李月',
    profilePhoto: 'https://www.itying.com/images/flutter/4.png',
    phoneNumber: 19876543432,
  ),
];

class emgContactPage extends StatefulWidget {
  emgContactPage({Key? key}) : super(key: key);

  @override
  _emgContactPageState createState() => _emgContactPageState();
}

class _emgContactPageState extends State<emgContactPage> {
  late SwipeActionController controller;

  @override
  void initState() {
    super.initState();
    controller = SwipeActionController();
  }

  Widget _item(int index) {
    return SwipeActionCell(
      key: ValueKey(emgContactList[index]),
      performsFirstActionWithFullSwipe: true,
      trailingActions: <SwipeAction>[
        SwipeAction(
          ///
          ///This attr should be passed to first action
          ///
          nestedAction: SwipeNestedAction(title: "确认删除"),
          title: "删除",
          onTap: (CompletionHandler handler) async {
            await handler(true);
            emgContactList.removeAt(index);
            setState(() {});
          },
          color: Colors.red,
        ),
        SwipeAction(
            title: "修改",
            onTap: (CompletionHandler handler) async {
              ///false means that you just do nothing,it will close
              /// action buttons by default
              handler(false);
            },
            color: Colors.grey),
      ],
      child: Container(
        height: 90,
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: emgContactList[index],
          ),
          Divider(color: Colors.redAccent)
        ]),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: emgContactList[index],
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (c, index) {
          return _item(index);
        },
        itemCount: emgContactList.length,
      ),
    );

    // return ListView(
    //   children: <Widget>[
    //     Row(
    //       children: <Widget>[
    //         SizedBox(
    //           width: 8,
    //         ),
    //         GFButton(
    //           onPressed: () {},
    //           text: "新建紧急联系人",
    //           textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
    //           icon: Icon(
    //             Icons.add_call,
    //             color: Colors.white,
    //           ),
    //           color: Colors.redAccent,
    //           shape: GFButtonShape.pills,
    //         ),
    //         SizedBox(
    //           width: 160.0,
    //         ),
    //         GFButton(
    //           onPressed: () {},
    //           text: "设置报警时间",
    //           textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
    //           icon: Icon(
    //             Icons.add_alert_rounded,
    //             color: Colors.white,
    //           ),
    //           shape: GFButtonShape.pills,
    //           color: Colors.yellow,
    //         ),
    //       ],
    //     ),
    //     Divider(
    //       color: Colors.red,
    //       indent: 8.0,
    //       endIndent: 8.0,
    //     ),
    //     emgContact(
    //         name: '苏珊',
    //         profilePhoto: 'https://www.itying.com/images/flutter/1.png',
    //         phoneNumber: 18765467890),
    //     Divider(
    //       color: Colors.red,
    //       indent: 8.0,
    //       endIndent: 8.0,
    //     ),
    //     emgContact(
    //         name: '苏珊andognni',
    //         profilePhoto: 'https://www.itying.com/images/flutter/2.png',
    //         phoneNumber: 18765467890),
    //     Divider(
    //       color: Colors.red,
    //       indent: 8.0,
    //       endIndent: 8.0,
    //     ),
    //     emgContact(
    //       name: '李月',
    //       profilePhoto: 'https://www.itying.com/images/flutter/4.png',
    //       phoneNumber: 19876543432,
    //     ),
    //     Divider(
    //       color: Colors.red,
    //       indent: 8.0,
    //       endIndent: 8.0,
    //     ),
    //   ],
    // );
  }
}
