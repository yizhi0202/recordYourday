import 'dart:ui';

import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class comment extends StatefulWidget{
  String content;
  String profile;
  String nickname;
  comment(
      {Key? key,
        required this.content,
        required this.profile,
        required this.nickname
      })
      : super(key: key
      ) ;

  @override
  _commentState createState() => _commentState();
}

class _commentState extends State<comment> {


    @override
    Widget build(BuildContext context) {

    return  Container(
          child: ListTile(
              horizontalTitleGap: 8.0,
              leading: ClipOval(
                child: Image.network(
                  widget.profile,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              title: Padding( 
                padding: EdgeInsets.only(
                  left: 0,
                ),
                child: Row(
                  children: [
                    TextButton(
                      child: Text(widget.nickname),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(
                  left: 7,
                ),
                child: Text(
                  widget.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        );
    }

}