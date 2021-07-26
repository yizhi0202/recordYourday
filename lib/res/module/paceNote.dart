import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// the audit's state of paceNote

enum Myaudit { unknown, auditing, pass, reject }

class paceNote extends StatefulWidget {
  int paceNoteID = 0; //to find the senicspots of the paceNote
  int userID = 0; //to find the avatar and the nickname of the user
  DateTime? publishTime = DateTime.now();
  String? title = '';
  String? note = ''; //the feeling of the paceNote
  int? score = 0; //the score of the paceNote, the autor gives
  Myaudit? audit = Myaudit.unknown;
  String? photo; //this is the cover of paceNote
  String? avatar;
  String? nickName;

  paceNote({
    Key? key,
    required this.paceNoteID,
    required this.userID,
    this.publishTime,
    this.title,
    this.note,
    this.score = 0,
    this.audit,
    this.photo = 'https://www.itying.com/images/flutter/2.png',
    this.avatar = 'https://www.itying.com/images/flutter/4.png',
    this.nickName = '网瘾少年',
  }) : super(key: key) {
    assert(score! >= 0 && score! <= 100);
  }
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

  @override
  _paceNoteState createState() => _paceNoteState();
}

class _paceNoteState extends State<paceNote> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shadowColor: Colors.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.zero,
            bottomRight: Radius.circular(50.0)),
      ),
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
              aspectRatio: 3 / 1,
              child: Image.network(
                '${widget.photo}',
                fit: BoxFit.cover,
              )),
          Text(
            '${widget.title} | ${widget.note}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          ListTile(
            leading: ClipOval(
              child: Image.network(
                '${widget.avatar}',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
            title: Text('${widget.nickName} up主推荐率 ${widget.score}%'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
                flex: 1,
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.star_rate),
                  onPressed: () {},
                ),
                flex: 1,
              ),
              Expanded(
                child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.heart),
                  onPressed: () {},
                ),
                flex: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
// class paceNote extends StatelessWidget {
//   int paceNoteID = 0;
//   int userID = 0;
//   DateTime publishTime = DateTime.now();
//   String title = '';
//   String note = ''; //the feeling of the paceNote
//   int score = 0; //the score of the paceNote, the autor gives
//   Myaudit audit = Myaudit.unknown;
//   String photo = '/images/forest.jpg';
//   paceNote({
//     Key? key,
//     @required paceNoteID,
//     @required userID,
//     publishTime,
//     title,
//     note,
//     score,
//     audit,
//     photo,
//     image,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: null,
//     );
//   }
// }
