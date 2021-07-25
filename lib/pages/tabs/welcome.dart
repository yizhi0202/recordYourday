import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                Container(
                  margin: EdgeInsets.only(top: 32, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: 250,
                  child: FlatButton(
                    child: Text('登录',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 16),
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    border: Border.all(color: Colors.green),
                    // shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  child: FlatButton(
                    child: Text('注册',
                        style: TextStyle(fontSize: 20, color: Colors.black12)),
                    onPressed: () {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Language : ',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        'English',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
