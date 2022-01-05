import 'package:cloudbase_core/cloudbase_core.dart';
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
import 'package:cloudbase_database/cloudbase_database.dart';
class commentsPage extends StatefulWidget {
  Map arguments;
  commentsPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _commentsPageState createState() => _commentsPageState();
}

class _commentsPageState extends State<commentsPage> {
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  List commentList = [];
  TextEditingController contentController = TextEditingController();

  Future getid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }
  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
      CloudBaseDatabase db = CloudBaseDatabase(core);


      if(widget.arguments['paceNoteID'] =='')
        {
          var res = await db.collection('comments').where({'objectID':widget.arguments['scenicSpotID']}).get();
          if(res.data.length == 0)
            {
              showToast(context,'该景点还没有发表评论，抢沙发吧！');
              setState(() {
                isLoading = false;
              });
            }
          else{
            List temp = [];
            int len = 0;
            res.data.forEach((element) async{
              var result  = await db.collection('userInfo').where({'userID':element['userID']}).get();
              temp.add(comment(content: element['content'], profilePhoto: result.data[0]['profilePhoto'], nickname: result.data[0]['nickName']));
              len++;
              if(len == res.data.length)
              {
                if(mounted)
                {
                  setState(() {
                    isLoading = false;
                    commentList = temp;
                  });
                }
              }
            });
          }
        }
      else{
        var res = await db.collection('comments').where({'objectID':widget.arguments['paceNoteID']}).get();
        if(res.data.length == 0)
          {
            showToast(context,'该路书还没有发表评论，抢沙发吧！');
            setState(() {
              isLoading = false;
            });
          }
        else{
          List temp = [];
          int len = 0;
          res.data.forEach((element) async{
            var result  = await db.collection('userInfo').where({'userID':element['userID']}).get();
            temp.add(comment(content: element['content'], profilePhoto: result.data[0]['profilePhoto'], nickname: result.data[0]['nickName']));
            len++;
            if(len == res.data.length)
            {
              if(mounted)
              {
                setState(() {
                  isLoading = false;
                  commentList = temp;
                });
              }
            }
          });
        }
      }
    }
  }
  @override
  void initState() {
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  Widget _buildList() {
    return ListView.builder(
//+1 for progressbar
      itemCount: commentList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == commentList.length) {
          return _buildProgressIndicator();
        } else {
          return commentList[index];
        }
      },
      controller: _scrollController,
    );
  }

  Container bottomNewCommentButton(){
    return Container(
      child: GFButton(
        child: Text("发表评论", style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
            controller: contentController,
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
             CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
             CloudBaseDatabase db = CloudBaseDatabase(core);
             if(widget.arguments['paceNoteID']== '')
               {
                 db.collection('comments').add({
                   'objectID':widget.arguments['scenicSpotID'],
                   'userID':value,
                   'content':contentController.text
                 });
                 showToast(context, '发表成功');
                 _getMoreData();
               }
             else{
               db.collection('comments').add({
                 'objectID':widget.arguments['paceNoteID'],
                 'userID':value,
                 'content':contentController.text
               });
               showToast(context, '发表成功');
               _getMoreData();

             }
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
      resizeToAvoidBottomInset: false,
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
      body:Container(height: 380,child: _buildList(),),
      bottomNavigationBar: BottomAppBar(
        child: bottomNewCommentButton(),
      ),
    );
  }
}