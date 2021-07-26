import 'package:flutter/material.dart';
import 'auditState.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

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
    final List<String> titles = [
      "RED",
      "YELLOW",
      "BLACK",
      "CYAN",
      "BLUE",
      "GREY",
    ];

    final List<Widget> images = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.black,
      ),
      Container(
        color: Colors.cyan,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.grey,
      ),
    ];
    return Container(
        width: 400,
        height: 800,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: VerticalCardPager(
                        titles: titles, // required
                        images: images, // required
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // optional
                        onPageChanged: (page) {
                          // optional
                        },
                        onSelectedItem: (index) {
                          // optional
                        },
                        initialPage: 0, // optional
                        align: ALIGN.CENTER // optional
                        ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
