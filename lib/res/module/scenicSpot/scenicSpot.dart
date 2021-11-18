import 'dart:ui';

import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../auditState.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

class scenicSpot extends StatefulWidget {
  String scenicSpotID ; //to find the senicspots of the paceNote
  String userID ; //to find the profilePhoto and the nickName of the user
  DateTime? publishTime = DateTime.now();
  String? title;
  String? address;
  BMFCoordinate? position;
  String? introduction;
  String? subTitle;
  Myaudit audit = Myaudit.unknown;
  int voteNum = 0; //记录投票数量
  String profilePhoto;
  String nickName;//the profilePhoto of uploader
  String photoUrl;
  scenicSpot(
      {Key? key,
      required this.scenicSpotID,
      required this.userID,
      required this.position,
      required this.photoUrl,
      this.publishTime,
      this.title = '难忘景点',
      this.address = '中国',
      this.introduction = '',
      this.subTitle = '',
      this.audit = Myaudit.unknown,
      this.voteNum = 0,
        this.nickName = '匿名用户',
        this.profilePhoto = ''
      })
      : super(key: key) ;
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
  bool like = false;
  bool favor = false;
  @override
  Widget build(BuildContext context) {
    String cover = "";
    cover = widget.photoUrl.split("###")[0];

    if(cover.length == 0)
    {
      cover = 'https://www.itying.com/images/flutter/4.png';
    }
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    
    CloudBaseDatabase db = CloudBaseDatabase(core);


    // db.collection('userInfo').where({
    //       "userID":widget.userID
    //   }).get().then((res){
    //     print('res.data0的类型是');
    //     print(res.data[0]);
    //
    //     nickName = (res.data[0]["nickName"] ==null)? '匿名用户':res.data[0]["nickName"];
    //     profilePhoto = res.data[0]["profilePhoto"];
    //     print('profilePhoto的内容'+profilePhoto);
    //   });
    return
      GestureDetector(
              onTap: () {
                print('scenicSpot 页内的scenicSpotID is '+widget.scenicSpotID);
                Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
                  'scenicSpotID':widget.scenicSpotID,
                  'scenicSpotName': widget.title,
                  'scenicSpotLocation': widget.address,
                  'introduction':
                      widget.introduction,
                  'position':widget.position,
                  'voteNum':widget.voteNum,
                  'photoURL':widget.photoUrl
                });
              },
      child :Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('$cover'), fit: BoxFit.cover)),
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
                        backgroundImage: NetworkImage(widget.profilePhoto),
                      ),
                    ),
                    Text(widget.nickName,
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
                      icon:Row(children: [
                        FaIcon(FontAwesomeIcons.heart,color: !like? Colors.black: Colors.red,),
                        Text(widget.voteNum.toString()),//这里放点赞数
                      ],),
                      onPressed: () {
                        if(!like) widget._Vote();
                        setState(() {
                          like = true;
                        });
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
