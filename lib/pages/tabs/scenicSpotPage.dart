import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/scenicSpot/scenicSpot.dart';

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
          backgroundColor: Colors.lightGreen,
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
                  'userID': '1897654',
                  'scenicSpotName': '荔波',
                  'scenicSpotLocation': '贵州',
                  'introduction':
                      '荔波一生必去的地方，荔波是中共一大代表邓恩铭烈士的故乡，境内生态良好，气候宜人，拥有国家5A级樟江风景名胜区、国家级茂兰自然保护区、水春河漂流、黄江河国家级湿地公园、瑶山古寨景区、四季花海和寨票、水浦、大土民宿等景区景点。'
                });
              },
              child: scenicSpot(
                scenicSpotID: 1,
                userID: 2,
                photo: myphoto,
                introduction:
                    '如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，必经十方生死!如有一味绝境，',
              ),
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
