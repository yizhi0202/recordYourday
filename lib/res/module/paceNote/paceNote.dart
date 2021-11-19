import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../auditState.dart';

class paceNote extends StatefulWidget {
  String paceNoteID = ''; //to find the senicspots of the paceNote
  String userID = ""; //to find the profilePhoto and the nickname of the user
  DateTime? publishTime = DateTime.now();
  String title = '';
  String note = ''; //the feeling of the paceNote
  int score = 0; //the score of the paceNote, the autor gives
  int voteNum = 0;
  Myaudit? audit = Myaudit.unknown;
  String? photo; //this is the cover of paceNote
  String? profilePhoto;
  String? nickName;
  String scenicSpotInfo;

  paceNote({
    Key? key,
    required this.paceNoteID,
    required this.userID,
    required this.scenicSpotInfo,
    this.publishTime,
    this.title ='',
    this.note = '',
    this.score = 0,
    this.voteNum = 0,
    this.audit,
    this.photo = 'https://www.itying.com/images/flutter/2.png',
    this.profilePhoto = 'https://www.itying.com/images/flutter/4.png',
    this.nickName = '网瘾少年'
  }) : super(key: key) {
    assert(score >= 0 && score <= 100);
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
  _Vote()
  {
    voteNum ++;
  }




  @override
  _paceNoteState createState() => _paceNoteState();
}

class _paceNoteState extends State<paceNote> {
  bool favor = false;
  bool like = false;

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      child:Card(
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
          Text('${widget.title} | ${widget.note}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0, color: Colors.grey)),
          ListTile(
            leading: ClipOval(
              child: Image.network(
                '${widget.profilePhoto}',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
            title: Text(
              '${widget.nickName} up主推荐率 ${widget.score}%',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.comment,color: Colors.black,),
                  onPressed: () {},
                ),
                flex: 1,
              ),
              Expanded(
                child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.star,color: !favor? Colors.black: Colors.red,),
                  onPressed: () {
                    setState(() {
                      favor = true;
                    });
                  },
                ),
                flex: 1,
              ),
              Expanded(
                child: IconButton(
                  icon: Row(children: [
                    FaIcon(FontAwesomeIcons.heart,color: !like? Colors.black: Colors.red,),
                    Text(widget.voteNum.toString()),//这里放点赞数
                  ],),
                  onPressed: () {
                    if(!like) widget._Vote();
                    setState(() {
                      like = true;
                    });
                  },
                ),
                flex: 1,
              ),
            ],
          )
        ],
      ),
    ),
    onTap:(){
      Navigator.pushNamed(context, '/paceNoteDetail',arguments:{
          'paceNoteID': widget.paceNoteID,
          'profilePhoto': widget.profilePhoto,
          'userID':widget.userID,
          'title': widget.title,
          'nickName':widget.nickName,
          'voteNum':widget.voteNum,
          'score':widget.score,
          'photo':widget.photo,
          'note': widget.note,
          'scenicSpotInfo': widget.scenicSpotInfo
      });
    }
    ); 
      
  }
}
