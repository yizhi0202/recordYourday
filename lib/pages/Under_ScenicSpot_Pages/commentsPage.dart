import 'package:flutter/material.dart';
import 'package:flutter_app_y/pages/Under_ScenicSpot_Pages/comment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:getwidget/getwidget.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
class commentsPage extends StatefulWidget {
  Map arguments;
  commentsPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _commentsPageState createState() => _commentsPageState();
}

class _commentsPageState extends State<commentsPage> {

  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }

  Container bottomNewCommentButton(){
    return Container(
      child: GFButton(
        child: Text("Publish", style: TextStyle(fontSize: 20.0, color: Colors.white)),
        color: Colors.blueAccent,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return new AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    child: textField(),
                    padding: EdgeInsets.all(7),
                  ),
                );
              }
          );
        },
      ),
      height: 50,
    );
  }
  Row textField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: new TextField(
            decoration: InputDecoration(
              hintText: '发表友善评论吧',
              border: null,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
            keyboardType: TextInputType.text,
            maxLength: 250,
            maxLines: 10,
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            Navigator.of(context).pop();
           getid().then((value) {
             print('登录的用户ID是'+value);
           });

          },
        )
      ],
    );
  }




  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: Text('评论'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
          color: Colors.white24,
        ),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: ButtonBar(
              children: [
                FaIcon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.yellow,
                ),
                Text('发表')
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          comment(content: '什么是快乐星球', profilePhoto: 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/scenicSpotPhoto/IMG_1629034744754.png', nickname: '集美们'),
          comment(content: '什么是快乐星球', profilePhoto: 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/scenicSpotPhoto/IMG_1629034744754.png', nickname: '集美们'),comment(content: '什么是快乐星球', profilePhoto: 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/scenicSpotPhoto/IMG_1629034744754.png', nickname: '集美们'),comment(content: '什么是快乐星球', profilePhoto: 'https://6865-hello-cloudbase-7gk3odah3c13f4d1-1306308742.tcb.qcloud.la/image/scenicSpotPhoto/IMG_1629034744754.png', nickname: '集美们'),],
      ),
      bottomNavigationBar: BottomAppBar(
        child: bottomNewCommentButton(),
      ),
    );
  }
}