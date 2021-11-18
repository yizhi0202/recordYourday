import 'dart:ui';

import 'package:flutter/material.dart';
import '../../res/module/loginFun/vertificationBox.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
class editPassPage extends StatefulWidget {
  Map arguments;
  editPassPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _editPassPageState createState() => _editPassPageState();
}

class _editPassPageState extends State<editPassPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController vertificationCodeController = TextEditingController();
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: '请输入新密码',
                        labelStyle: TextStyle(fontSize: 16)),
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
                    child: Text('确认',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () { 
                            print(widget.arguments);
                            CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
                            CloudBaseStorage storage = CloudBaseStorage(core);
                            CloudBaseDatabase db = CloudBaseDatabase(core);
                            db.collection("User").where({
                              "userID":widget.arguments["userID"]
                            }).update({
                              "pass":passwordController.text
                            }).then((_){
                              showToast(context, "密码已修改");
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




  