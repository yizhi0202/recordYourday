import 'package:flutter/material.dart';
import '../../res/module/emgContact/emgContact.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

List<Widget> emgContactList = [
  emgContact(
    nickName: '苏珊',
    profilePhoto: 'https://www.itying.com/images/flutter/1.png',
    phoneNumber: 18765467890,
    email: '1927423284@qq.com',
  ),
  emgContact(
      nickName: '苏珊andognni',
      profilePhoto: 'https://www.itying.com/images/flutter/2.png',
      phoneNumber: 18765467890),
  emgContact(
    nickName: '李月',
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
  //设置一个指定时间
  var chooseTime = TimeOfDay(hour: 0, minute: 0);

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
        // SwipeAction(
        //     title: "修改",
        //     onTap: (CompletionHandler handler) async {
        //       ///false means that you just do nothing,it will close
        //       /// action buttons by default
        //       handler(false);
        //     },
        //     color: Colors.grey),
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
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('紧急联系人'),
        ),
        drawer: GFDrawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GFDrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                currentAccountPicture: GFAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      "https://www.itying.com/images/flutter/3.png"),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('nickName', style: TextStyle(fontSize: 18)),
                    Icon(
                      Icons.male,
                      color: Colors.lightBlue,
                      size: 32,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.powerOff,
                      size: 25,
                      color: Colors.red,
                    ),
                    Text('退出登录', style: TextStyle(fontSize: 18))
                  ],
                ),
              )
            ],
          ),
        ),
        body: Column(
          // height: 260,
          // width: double.infinity,
          // color: Colors.white,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GFButton(
                    size: 35.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/addEmgContact');
                    },
                    icon: Icon(
                      Icons.add_call,
                      color: Colors.white,
                    ),
                    color: Colors.red,
                    text: '新建紧急联系人',
                    shape: GFButtonShape.pills,
                  ),
                ),
                //
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GFButton(
                    size: 35.0,
                    onPressed: () {
                      showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          }).then((value) {if(value == null) return; setState(() {
                            chooseTime = value;
                            print('the chooseTime is'+chooseTime.hour.toString());
                          });});
                    },
                    icon: Icon(
                      Icons.add_alert_rounded,
                      color: Colors.white,
                    ),
                    shape: GFButtonShape.pills,
                    color: Colors.yellow,
                    text: '设置报警时间',
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (c, index) {
                return _item(index);
              },
              itemCount: emgContactList.length,
            ),
          ],
        ));
  }
}
