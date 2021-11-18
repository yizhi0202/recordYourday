import 'dart:async';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyBody extends StatefulWidget {
  TextEditingController codeController = TextEditingController();
  String phone = '';
  MyBody({required this.codeController, required this.phone});
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  bool isButtonEnable = true; //按钮状态 是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 60; //初始倒计时时间
  Timer timer =
      Timer.periodic(Duration(seconds: 1), (Timer timer) {}); //倒计时的计时器

  void _buttonClickListen() {
    setState(() {
      if (isButtonEnable) {
        //当按钮可点击时
        isButtonEnable = false; //按钮状态标记
        _initTimer();

        return null; //返回null按钮禁止点击
      } else {
        //当按钮不可点击时
//  debugPrint('false');
        return null; //返回null按钮禁止点击
      }
    });
  }
  void getHttp() async {
    try {
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseStorage storage = CloudBaseStorage(core);
      CloudBaseDatabase db = CloudBaseDatabase(core);
      print(widget.phone);
      db.collection('Users').where({
        'userID': widget.phone,
      }).get().then((res){
        if(res.data.length == 0)
        {
          showToast(context, "没有此用户");
        }
        else
        {
           Dio().post(
          'https://hello-cloudbase-7gk3odah3c13f4d1.service.tcloudbase.com/sendEmail',
          data: {'phone': widget.phone}).then((value) {
          });
        }
      });
     
    } catch (e) {
      print(e);
    }
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送($count)'; //更新文本内容
        }
      });
    });
  }

  @override
  void dispose() {
    //销毁计时器
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
//  mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     crossAxisAlignment: CrossAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextFormField(
                      maxLines: 1,
                      onSaved: (value) {},
                      controller: widget.codeController,
                      textAlign: TextAlign.left,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6)
                      ],
                      decoration: InputDecoration(
                          hintText: ('请输入验证码'),
                          contentPadding: EdgeInsets.only(top: -5, bottom: 0),
                          hintStyle: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 16,
                          ),
                          alignLabelWithHint: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0x19000000)))
                          //border: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  child: FlatButton(
                    disabledColor: Colors.grey.withOpacity(0.1), //按钮禁用时的颜色
                    disabledTextColor: Colors.white, //按钮禁用时的文本颜色
                    textColor: isButtonEnable
                        ? Colors.white
                        : Colors.black.withOpacity(0.2), //文本颜色
                    color: isButtonEnable
                        ? Color(0xff44c5fe)
                        : Colors.grey.withOpacity(0.1), //按钮的颜色
                    splashColor: isButtonEnable
                        ? Colors.white.withOpacity(0.1)
                        : Colors.transparent,
                    shape: StadiumBorder(side: BorderSide.none),
                    onPressed: () {
                      //http 发送信息
                      getHttp();
                      setState(() {
                        _buttonClickListen();
                      });
                    },
//      child: Text('重新发送 (${secondSy})'),
                    child: Text(
                      '$buttonText',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
