import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../auditState.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

class scenicSpot extends StatefulWidget {
  int scenicSpotID = 0; //to find the senicspots of the paceNote
  int userID = 0; //to find the avatar and the nickname of the user
  DateTime? publishTime = DateTime.now();
  String? title;
  String? address;
  BMFCoordinate? position;
  String? introduction;
  String? subTitle;
  Myaudit audit = Myaudit.unknown;
  List<String>? photo;
  int voteNum = 0; //记录投票数量
  String? profilePhoto; //the avatar of uploader
  String? nickName;
  scenicSpot(
      {Key? key,
      required this.scenicSpotID,
      required this.userID,
      required this.position,
      this.publishTime,
      this.title = '难忘景点',
      this.address = '中国',
      this.introduction = '',
      this.subTitle = '',
      this.audit = Myaudit.unknown,
      this.voteNum = 0,
      required this.photo,
      this.profilePhoto = 'https://www.itying.com/images/flutter/4.png',
      this.nickName = '肥宅快乐水'})
      : super(key: key) {
    assert(photo!.length <= 9); //the number of photos must less than 9
  }
  //change the state of audit
  _SetAudit(int index) {
    if (index == 0)
      this.audit = Myaudit.unknown;
    else if (index == 1)
      this.audit = Myaudit.auditing;
    else if (index == 2)
      this.audit = Myaudit.pass;
    else
      this.audit = Myaudit.reject;
  }

  //users vote
  _Vote() {
    voteNum++;
  }

  @override
  _scenicSpotState createState() => _scenicSpotState();
}

class _scenicSpotState extends State<scenicSpot> {
  //for change heart's color
  bool favor = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('${widget.photo![0]}'), fit: BoxFit.cover)),
        margin: EdgeInsets.all(8),
        height: 240,
        width: double.infinity,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Column(
              children: <Widget>[
                Text(
                  '${widget.title}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                Expanded(
                    child: Text(
                  '${widget.introduction}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('${widget.profilePhoto}'),
                      ),
                    ),
                    Text('${widget.nickName}',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 16.0)),
                    // SizedBox(
                    //   width: 260,
                    // ),
                    //in favor of the scenicSpot
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        color: !favor ? Colors.white : Colors.red,
                      ),
                      onPressed: () {
                        widget._Vote();
                        setState(() {
                          favor = true;
                        });
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
