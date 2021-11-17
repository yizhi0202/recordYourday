import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:getwidget/getwidget.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
class commentsPage extends StatefulWidget {
  Map arguments;
  commentsPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _commentsPageState createState() => _commentsPageState();
}

class _commentsPageState extends State<commentsPage> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
          primary: true,
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          title: Text('评论')
        ),
      body: buildGrid()
    );
  }
}