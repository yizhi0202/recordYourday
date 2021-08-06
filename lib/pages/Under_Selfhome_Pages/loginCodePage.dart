import 'package:flutter/material.dart';
import '../../res/module/loginFun/vertificationBox.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:apifm/apifm.dart' as Apifm;
import 'package:dio/dio.dart';

class loginCodePage extends StatefulWidget {
  loginCodePage({Key? key}) : super(key: key);

  @override
  _loginCodePageState createState() => _loginCodePageState();
}

class _loginCodePageState extends State<loginCodePage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController vertificationCodeController = TextEditingController();

  // String debugLable = 'Unknown'; /*错误信息*/
  // final JPush jpush = new JPush(); /* 初始化极光插件*/
  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState(); /*极光插件平台初始化*/
  // }

  // Future<void> initPlatformState() async {
  //   String platformVersion = '';

  //   try {
  //     /*监听响应方法的编写*/
  //     jpush.addEventHandler(
  //         onReceiveNotification: (Map<String, dynamic> message) async {
  //       print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
  //       setState(() {
  //         debugLable = "接收到推送: $message";
  //       });
  //     });
  //   } on PlatformException {
  //     platformVersion = '平台版本获取失败，请检查！';
  //   }

  //   if (!mounted) {
  //     return;
  //   }

  //   setState(() {
  //     debugLable = platformVersion;
  //   });
  // }
  void getHttp() async {
    try {
      var response = await Dio().get(
          'https://hello-cloudbase-7gk3odah3c13f4d1.service.tcloudbase.com/hello');
      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Hello, backpacker!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  '终于等到你',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: '请输入手机号',
                        labelStyle: TextStyle(fontSize: 16.0)),
                  ),
                ),
                //this is vertification code widget
                MyBody(
                  phone: phoneController.text,
                  codeController: vertificationCodeController,
                ),
                SizedBox(height: 32),
                Container(
                  margin: EdgeInsets.only(top: 32, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: 250,
                  child: TextButton(
                    child: Text('登录',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      getHttp();
                      // /*三秒后出发本地推送*/
                      // var fireDate = DateTime.fromMillisecondsSinceEpoch(
                      //     DateTime.now().millisecondsSinceEpoch + 3000);
                      // var localNotification = LocalNotification(
                      //   id: 234,
                      //   title: '我是推送测试标题',
                      //   buildId: 1,
                      //   content: '看到了说明已经成功了',
                      //   fireTime: fireDate,
                      //   subtitle: '一个测试',
                      // );

                      // jpush
                      //     .sendLocalNotification(localNotification)
                      //     .then((res) {
                      //   setState(() {
                      //     debugLable = res;
                      //   });
                      // });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
// class loginCodePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //       icon: Icon(Icons.arrow_back),
    //     ),
    //   ),
    //   backgroundColor: Colors.white,
    //   body: Stack(
    //     children: <Widget>[
    //       Align(
    //         alignment: Alignment.topCenter,
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Text(
    //               'Hello, backpacker!',
    //               style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    //             ),
    //             Text(
    //               '终于等到你',
    //               style: TextStyle(fontSize: 20),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(left: 32, right: 32),
    //               child: TextField(
    //                 keyboardType: TextInputType.number,
    //                 decoration: InputDecoration(
    //                     labelText: '请输入手机号',
    //                     labelStyle: TextStyle(fontSize: 16.0)),
    //               ),
    //             ),
    //             MyBody(),
    //             SizedBox(height: 32),
    //             Container(
    //               margin: EdgeInsets.only(top: 32, bottom: 16),
    //               decoration: BoxDecoration(
    //                 color: Colors.orange,
    //                 shape: BoxShape.rectangle,
    //                 borderRadius: BorderRadius.all(Radius.circular(10)),
    //               ),
    //               width: 250,
    //               child: TextButton(
    //                 child: Text('登录',
    //                     style: TextStyle(fontSize: 20, color: Colors.white)),
    //                 onPressed: () {},
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
//   }
// }
