import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:flutter/services.dart';

class addEmgContactPage extends StatelessWidget {
  addEmgContactPage({Key? key}) : super(key: key);
  TextEditingController emgNickname =TextEditingController();
  TextEditingController email = TextEditingController();
  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
          color: Colors.white24,
        ),
        centerTitle: true,
        title: Text('添加紧急联系人'),
        actions: [IconButton(onPressed: () {
          if(email.text.endsWith('@qq.com'))
            {
              if(emgNickname.text == '')
                {
                  showToast(context, '请输入紧急联系人的昵称！');
                }
              else{
                getid().then((value) async{
                  CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
                  CloudBaseDatabase db = CloudBaseDatabase(core);
                   var res = await db.collection('emgContact').where({
                     'userID':value
                   }).get();
                   bool flag = true;
                   res.data.forEach((element){
                     if(element['email'] == email.text)
                       {
                         showToast(context, '邮箱重复，请添加新的邮箱号！');
                         flag = false;
                       }
                   });
                   if(flag)
                     {
                       db.collection('emgContact').add({
                         'userID':value,
                         'email':email.text,
                         'nickName':emgNickname.text
                       }).then((_){showToast(context, '新建成功');
                       Future.delayed(Duration(milliseconds: 800)).whenComplete((){
                         Navigator.pushNamed(context,'/');
                       });
                       });
                     }


                });
              }
            }
          else{
            showToast(context, '输入的邮箱有误，请检查后重新提交（注意使用qq邮箱）！');
          }
        }, icon: Icon(Icons.save))],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('绰号'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emgNickname,
              decoration: InputDecoration(hintText: '输入他（她）的称呼吧'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('邮箱号码（目前仅限qq邮箱）'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: email,
              decoration: InputDecoration(hintText: '输入他（她）的邮箱吧'),
            ),
          ),
        ],
      ),
    );
  }
}
