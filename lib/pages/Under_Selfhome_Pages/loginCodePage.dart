import 'package:flutter/material.dart';
import '../../res/module/loginFun/vertificationBox.dart';
import '../../res/module/loginFun/asr_manager.dart';

class loginCodePage extends StatelessWidget {
  final vertificationCodeController = TextEditingController();
  final phoneController = TextEditingController();
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
                MyBody(
                  phoneNumber: phoneController.text,
                  mcontroller: vertificationCodeController,
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
                      login(context);
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

  login(BuildContext context) {
    Map ages = {};
    ages['phone'] = phoneController.text;
    ages['code'] = vertificationCodeController.text;
    ArsManager.correct(ages).then((result) {
      int code = result["code"];
      String message = result["message"];
      if (message == "提交验证码正确") {
        Navigator.pushNamed(context, '/');
      } else {
        print(message);
      }
    });
  }
}
