import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:getwidget/getwidget.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';

List<String> newPhotos = [
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
  'https://www.itying.com/images/flutter/1.png', //will be override later ,so it doesn't matter
];

class scenicSpotDetailPage extends StatefulWidget {
  Map arguments;
  scenicSpotDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _scenicSpotDetailPageState createState() => _scenicSpotDetailPageState();
}

class _scenicSpotDetailPageState extends State<scenicSpotDetailPage> {
  bool keyboard = false; //键盘的弹起、收回状态
  TextEditingController editingController =
      new TextEditingController(); //输入框的编辑
  //get the photoUrl of uploading by userID
  void getPhotoList(String userID) async {
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('scenicSpotPhoto');
    var _ = db.command;
  }

  @override
  Widget build(BuildContext context) {
    newPhotos = widget.arguments["photoURL"].split("###").where((s) => !s.isEmpty).toList();
    print(newPhotos);
    print(newPhotos.length);
    
    double height =
        MediaQuery.of(context).padding.bottom; // 这个很简单，就是获取高度，获取的底部安全区域的高度
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: 270,
              width: 480,
              child: GFCarousel(
                autoPlay: true,
                viewportFraction: 0.8,
                pagination: true,
                passiveIndicator: Colors.grey,
                activeIndicator: Colors.white,
                items: newPhotos.map(
                  (url) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(url, fit: BoxFit.cover),
                      ),
                    );
                  },
                ).toList(),
                onPageChanged: (index) {
                  setState(() {
                    index;
                  });
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  if (widget.arguments['userID'] != null)
                    print('there are arguments,${widget.arguments['userID']}');
                  else
                    print('no arguments');
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 32,
                )),
          ],
        ),
        Container(
          height: 60,
          width: 480,
          child: ListTile(
              title: Text('景点名称${widget.arguments['scenicSpotName']}'),
              subtitle: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: FaIcon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 18,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                      child: 
                  Text(
                    '景点位置${widget.arguments['scenicSpotLocation']}',
                    maxLines: 20,
                  )
                  )
                ],
              ),
              trailing: Stack(
                children: [
                  Padding(
                      child: Icon(
                        Icons.circle,
                        size: 42,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.only(top: 8, right: 0)),
                  Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        )),
                  ),
                ],
              )),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 240,
            child: SingleChildScrollView(
              child: Text(
                '简介${widget.arguments['introduction'] * 10}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            '查看全部评论({})',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        
        Padding(
          padding: EdgeInsets.only(left: 210, right: 32),
          child:Text(
                '',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              )
        ),
        Row(
          children: [
            Expanded(
              child: ButtonBar(
                children: [Icon(Icons.comment), Text('24')],
              ),
              flex: 1,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  getPhotoList('18670343782');
                  print('点赞数增加');
                },
                child: ButtonBar(
                  children: [FaIcon(FontAwesomeIcons.heart), Text('${widget.arguments['voteNum']}')],
                ),
              ),
              flex: 1,
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: 16,
                )),
            // Container(
            //   child: AnimatedPadding(
            //     //可以添加一个动画效果
            //     padding: MediaQuery.of(context).viewInsets, //边距（必要）
            //     duration: const Duration(milliseconds: 100), //动画时常 （必要）
            //     child: Container(
            //       color: Colors.white, //评论位置颜色
            //       padding: new EdgeInsets.only(
            //           bottom: keyboard
            //               ? 0
            //               : height), //距离底部边界距离，这个是为了适配全面屏的，keyboard，bool类型，代表键盘的弹起和收回。true谈起，false收回，这个值怎么获取下面会有提到。
            //       child: Container(
            //         height: keyboard ? 60 : 30, //设置输入框谈起和收回时的高度
            //         width: double.infinity, //设置宽度
            //         child: Flex(
            //           //控件横向排版弹性布局
            //           direction: Axis.horizontal,
            //           crossAxisAlignment: CrossAxisAlignment.end, //剧右边显示
            //           children: <Widget>[
            //             Expanded(
            //               flex: 1,
            //               child: Container(
            //                 height: double.infinity,
            //                 margin: new EdgeInsets.all(10),
            //                 child: TextField(
            //                   maxLines: 50, //最大行数
            //                   controller:
            //                       editingController, //绑定TextEditController更好操作
            //                   style: TextStyle(
            //                     //设置字体、颜色
            //                     fontSize: 16,
            //                     color: Colors.black,
            //                   ),
            //                   autocorrect: true,
            //                   decoration: InputDecoration(
            //                     //设置提示内容，字体颜色、大小等
            //                     border: InputBorder.none,
            //                     hintText: "请发表你的评论",
            //                     hintStyle: TextStyle(
            //                       fontSize: 16,
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                   onChanged: (text) {
            //                     // 获取时时输入框的内容
            //                   },
            //                 ),
            //                 decoration: BoxDecoration(
            //                     //设置边框、圆角效果
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.circular(5),
            //                     border: new Border.all(
            //                         width: 0.5, color: Colors.grey)),
            //               ),
            //             ),
            //             Offstage(
            //               offstage: !keyboard, //键盘弹起，发布按钮显示、反之隐藏
            //               child: GestureDetector(
            //                 onTap: () {
            //                   // 点击发布按钮判断输入框内容是否为空，并提示用户
            //                   if (editingController.text.isEmpty) {
            //                     showToast(context, "请填写评论信息");
            //                     return;
            //                   }
            //                   editingController.text = ""; //不为空，点击发布后，清空内容
            //                   FocusScope.of(context)
            //                       .requestFocus(FocusNode()); //关闭键盘
            //                 },
            //                 child: Container(
            //                   // 设置点击按钮样式
            //                   height: 30,
            //                   alignment: Alignment.center,
            //                   padding: new EdgeInsets.fromLTRB(10, 0, 10, 0),
            //                   margin:
            //                       new EdgeInsets.only(bottom: 14, right: 10),
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.all(
            //                         Radius.circular(8.0),
            //                       ),
            //                       color: Colors.grey),
            //                   child: Text(
            //                     "发布",
            //                     style: TextStyle(
            //                         color: Colors.white, fontSize: 14),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Expanded(
              child: Container(
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: TextField(
                      onTap: () {},
                      decoration: InputDecoration(
                        labelText: '评论显真情...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            /// 里面的数值尽可能大才是左右半圆形，否则就是普通的圆角形
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  )),
              flex: 2,
            ),
          ],
        )
      ],
    ));
  }
}

//  Card(
//             child: Row(
//               children: [
//                 ClipOval(
//                   child: Image.network(
//                     'https://www.itying.com/images/flutter/1.png',
//                     fit: BoxFit.cover,
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [],
//                     ),
//                     Expanded(
//                       child: Text(
//                         ' 评论，不错的' * 10,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),