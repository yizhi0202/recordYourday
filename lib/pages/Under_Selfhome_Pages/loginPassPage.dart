import 'package:flutter/material.dart';
// import '../../routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:dio/dio.dart';

// void QueryMobileLocation(String phonenumber) async {
//   Apifm.init("bd1a95e20f10394f7ea5fd7ec06cfaa5 ");
//   var res = await Apifm.queryMobileLocation(phonenumber);
//   print(res);
// }

class loginPassPage extends StatelessWidget {
  TextEditingController userID =
      TextEditingController(); //get the input of phonenumber
  TextEditingController pass =
      TextEditingController(); //get the input of password

  //the function of login
  void prepareForLogin(String userID, String pass, context) async {
    // 初始化
    CloudBaseCore core = CloudBaseCore.init({
      'env': 'hello-cloudbase-7gk3odah3c13f4d1',
      'appAccess': {'key': 'f9fadd353a3e75450ba4080b75789ebd', 'version': '1'}
    });

    //初始化数据库
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('Users');
    var _ = db.command;
    var res = await collection
        .where(_.and([
          {userID: _.eq(userID)},
          {pass: _.eq(pass)}
        ]))
        .get();
    print(res);
    if (res.data == null) {
      showToast(context, "name or password is wrong!");
    } else {
      print('login success!');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userID", userID);
      Navigator.pushNamed(context, '/', arguments: {"userID": userID});
    }
  }

  // void callLoginPass(String ph, String pa, context) async {
  //   try {
  //     //call the cloud function
  //     var response = await Dio().post(
  //         'https://hello-cloudbase-7gk3odah3c13f4d1.service.tcloudbase.com/loginPass',
  //         data: {'userID': ph, 'pass': pa});
  //     print(response);
  //     var result = response.toString();
  //     if (result == 'true') Navigator.pushNamed(context, '/');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void callLoginCode(String userID, context) async {
    try {
      //call the cloud function
      var response = await Dio().post(
          'https://hello-cloudbase-7gk3odah3c13f4d1.service.tcloudbase.com/sendEmail',
          data: {'userID': userID});
      print(response);
      var result = response.toString();
      if (result != 'false') Navigator.pushNamed(context, '/');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  height: 80,
                ),
                SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: TextField(
                    controller: userID,
                    decoration: InputDecoration(labelText: '请输入手机号'),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(labelText: '请输入密码'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/findPass');
                  },
                  child: Text(
                    '忘记密码？',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
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
                      prepareForLogin(userID.text, pass.text, context);
                      // callLoginCode(userID.text, context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  child: TextButton(
                    child: Text('注册',
                        style: TextStyle(fontSize: 20, color: Colors.black12)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginCode');
                  },
                  child: Text(
                    '手机验证码登录',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Language : ',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'English',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
