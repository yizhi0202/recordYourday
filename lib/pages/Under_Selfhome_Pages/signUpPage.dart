import 'package:flutter/material.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import '../../res/module/loginFun/vertificationBox.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:dio/dio.dart';

class signUpPage extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  TextEditingController vertificationCodeController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void addInfo(){
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseStorage storage = CloudBaseStorage(core);
    CloudBaseDatabase db = CloudBaseDatabase(core);
    db.collection("Users").add({
                            "userID":phoneController.text,
                            "pass":passController.text,
                            "alarmEndTime":9999999,
                          }).then((_){});
    db.collection("userInfo").add({
      'userID': phoneController.text,
      'nickName':"新用户",
      'sex':"male",
      'userType':"common",
      'profilePhoto':"https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/profilePhoto/IMG_1637400423192.png"
    }).then((_){

      print("添加新用户");});
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
                    decoration: InputDecoration(
                        labelText: '请输入邮箱',
                        labelStyle: TextStyle(fontSize: 16.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: '请输入密码',
                        labelStyle: TextStyle(fontSize: 16)),
                  ),
                ),
                MyBody(
                  phone: phoneController,
                  codeController: vertificationCodeController,
                  signup: true,
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
                    child: Text('注册',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();

                      CloudBaseDatabase db = CloudBaseDatabase(core);
                      db.collection("Users").where({
                        "userID":phoneController.text
                      }).get().then((res){
                        if(0 == res.data.length)
                        {
                          var code =  int.parse(phoneController.text.substring(0,6));
                          code *= code;
                          String result = code.toString().substring(0,6);
                          if(vertificationCodeController.text == result) 
                          {
                              addInfo();
                              showToast(context, '注册成功！');
                              Future.delayed(Duration(milliseconds: 800)).whenComplete((){
                                Navigator.pushNamed(context,'/loginPass');
                          });

                          }
                          else
                          {
                              showToast(context, "验证码错误");
                          }
                        }
                        else
                        {
                          showToast(context, "该邮箱已被注册");
                        }
                      });
                      
                      
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
