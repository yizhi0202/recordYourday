import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/senicSpot.dart';

class categoryPage extends StatefulWidget {
  categoryPage({Key? key}) : super(key: key);

  @override
  _categoryPageState createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
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
