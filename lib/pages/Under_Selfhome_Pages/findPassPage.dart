import 'package:flutter/material.dart';
import '../../res/module/loginFun/vertificationBox.dart';

class findPassPage extends StatefulWidget {
  findPassPage({ Key? key }) : super(key: key);

  @override
  _findPassPageState createState() => _findPassPageState();
}

class _findPassPageState extends State<findPassPage> {
  TextEditingController phoneController = TextEditingController();
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
                    controller: phoneController,
                    decoration: InputDecoration(
                        labelText: '请输入邮箱',
                        labelStyle: TextStyle(fontSize: 16.0)),
                  ),
                ),
                MyBody(
                    phone: phoneController,
                    codeController: vertificationCodeController),
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
                      var code =  int.parse(phoneController.text.substring(0,6));
                      code *= code;
                      String result = code.toString().substring(0,6);
                      if(vertificationCodeController.text == result) 
                      {
                        String userID = phoneController.text;
                        Navigator.pushNamed(context, '/editPass', arguments:{'userID':userID});
                      }
                      
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
