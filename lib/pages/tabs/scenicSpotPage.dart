import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/scenicSpot.dart';

class scenicSpotPage extends StatefulWidget {
  scenicSpotPage({Key? key}) : super(key: key);

  @override
  _scenicSpotPageState createState() => _scenicSpotPageState();
}

class _scenicSpotPageState extends State<scenicSpotPage> {
  List<String> myphoto = [
    'https://www.itying.com/images/flutter/1.png',
    'https://www.itying.com/images/flutter/3.png',
    'https://www.itying.com/images/flutter/2.png',
    'https://www.itying.com/images/flutter/4.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: Text('景点'),
          leading: IconButton(
            //drawer
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: ListView(
          children: [
            scenicSpot(
              scenicSpotID: 1,
              userID: 2,
              photo: myphoto,
              introduction:
                  '如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，',
            ),
            Divider(
              color: Colors.green,
              indent: 8.0,
              endIndent: 8.0,
            ),
            scenicSpot(
              scenicSpotID: 1,
              userID: 2,
              photo: myphoto,
              introduction: '如有一味绝境，必经十方生死!',
            ),
            Divider(
              color: Colors.green,
              indent: 8.0,
              endIndent: 8.0,
            ),
            scenicSpot(
              scenicSpotID: 1,
              userID: 2,
              photo: myphoto,
              introduction: '如有一味绝境，必经十方生死!',
            ),
            Divider(
              color: Colors.green,
              indent: 8.0,
              endIndent: 8.0,
            ),
            scenicSpot(
              scenicSpotID: 1,
              userID: 2,
              photo: myphoto,
              introduction: '如有一味绝境，必经十方生死!',
            ),
            Divider(
              color: Colors.green,
              indent: 8.0,
              endIndent: 8.0,
            ),
            scenicSpot(
              scenicSpotID: 1,
              userID: 2,
              photo: myphoto,
              introduction: '如有一味绝境，必经十方生死!',
            ),
            Divider(
              color: Colors.green,
              indent: 8.0,
              endIndent: 8.0,
            ),
            scenicSpot(
              scenicSpotID: 1,
              userID: 2,
              photo: myphoto,
              introduction:
                  '如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!',
            ),
            Divider(
              color: Colors.green,
              indent: 8.0,
              endIndent: 8.0,
            ),
            scenicSpot(
              scenicSpotID: 1,
              userID: 2,
              photo: myphoto,
              introduction: '如有一味绝境，必经十方生死!',
            ),
          ],
        ));
  }
}
