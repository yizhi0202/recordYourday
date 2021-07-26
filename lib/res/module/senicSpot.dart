import 'package:flutter/material.dart';
import 'auditState.dart';
import 'designCourseAppTheme.dart';

class scenicSpot extends StatefulWidget {
  int scenicSpotID = 0; //to find the senicspots of the paceNote
  int userID = 0; //to find the avatar and the nickname of the user
  DateTime? publishTime = DateTime.now();
  String? title;
  String? location;
  String? introduction;
  Myaudit audit = Myaudit.unknown;
  List<String>? photo;
  int voteNum = 0; //记录投票数量
  String? profilePhoto; //the avatar of uploader
  String? nickName;
  scenicSpot(
      {Key? key,
      required this.scenicSpotID,
      required this.userID,
      this.publishTime,
      this.title = '难忘景点',
      this.location = '中国',
      this.introduction = '',
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      child: SizedBox(
          width: 280,
          child: Stack(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 48,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48 + 24.0,
                          ),
                          Expanded(
                              child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(
                                    '景点内容',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.darkerText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.network(
                                'https://www.itying.com/images/flutter/1.png')),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
