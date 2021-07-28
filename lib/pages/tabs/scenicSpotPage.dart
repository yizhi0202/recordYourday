import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/senicSpot.dart';

class scenicSpotPage extends StatefulWidget {
  scenicSpotPage({Key? key}) : super(key: key);

  @override
  _scenicSpotPageState createState() => _scenicSpotPageState();
}

class _scenicSpotPageState extends State<scenicSpotPage> {
  List<String> myphoto = ['https://www.itying.com/images/flutter/1.png'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        scenicSpot(scenicSpotID: 1, userID: 2, photo: myphoto),
        scenicSpot(scenicSpotID: 1, userID: 2, photo: myphoto),
        scenicSpot(scenicSpotID: 1, userID: 2, photo: myphoto)
      ],
    );
  }
}
