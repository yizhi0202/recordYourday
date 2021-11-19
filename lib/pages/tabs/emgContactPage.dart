import 'package:flutter/material.dart';
import '../../res/module/emgContact/emgContact.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';

List<Widget> emgContactList = [
];

class emgContactPage extends StatefulWidget {
  emgContactPage({Key? key}) : super(key: key);

  @override
  _emgContactPageState createState() => _emgContactPageState();
}

class _emgContactPageState extends State<emgContactPage> {
  late SwipeActionController controller;
  List emgContactInfo =[];
  //设置一个指定时间
  var chooseTime = TimeOfDay(hour: 0, minute: 0);
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }
  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseDatabase db = CloudBaseDatabase(core);
      getid().then((value) async {
        var res = await db.collection('emgContact').where({'userID':value}).get();
        if(mounted)
        {
          setState(() {
            List<Widget> temp =[];
            emgContactInfo = res.data;
            emgContactInfo.forEach((element) {
              temp.add(emgContact(nickName: element['nickName'],email: element['email']));
            });
            emgContactList = temp;
            isLoading = false;
          });
        }
      });
    }
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
    controller = SwipeActionController();
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
            CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
            CloudBaseDatabase db = CloudBaseDatabase(core);
            Collection collection = db.collection('emgContact');
            collection.where({'email':emgContactInfo[index]['email'],'userID':emgContactInfo[index]['userID']}).remove();
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
      resizeToAvoidBottomInset: false,
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
                if(index == emgContactList.length) return _buildProgressIndicator();
                else{
                  return _item(index);
                }
              },
              itemCount: emgContactList.length+1,
              controller: _scrollController,
            ),
          ],
        ));
  }
}
