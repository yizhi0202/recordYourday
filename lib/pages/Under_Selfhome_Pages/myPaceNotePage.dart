import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_item/multi_select_item.dart';

import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
class myPaceNotePage extends StatefulWidget {
  @override
  _myPaceNotePageState createState() => _myPaceNotePageState();
}
//Navigator.pushNamed(context, '/myPaceNoteDetail')
class _myPaceNotePageState extends State<myPaceNotePage> {
  List<Widget> myPaceNoteList = [];
  List for_removing = [];
  MultiSelectController controller = MultiSelectController();
  Widget getMyPaceNote({String title = '',int voteNum = 0, Map info =const {}})
  {
    return Card(
      child: ListTile(leading: Icon(Icons.menu_book,color: Colors.yellow,),title: Text(title,),trailing: Row(mainAxisSize:MainAxisSize.min ,children: [IconButton(onPressed: (){
        Navigator.pushNamed(context, '/myPaceNoteDetail',arguments:{'info':info});
      }, icon: FaIcon(FontAwesomeIcons.hiking)),GestureDetector(child: Text('路书详情'),onTap: (){ Navigator.pushNamed(context, '/myPaceNoteDetail',arguments:{'info':info});},),FaIcon(FontAwesomeIcons.heart),Text(voteNum.toString())],)),
    );
  }
  Future getid() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("userID");
  }

  void addPaceNote(String title, int voteNum, Map info)
  {
    myPaceNoteList.add(getMyPaceNote(title: title,voteNum: voteNum, info:info));
    setState(() {
      controller.set(myPaceNoteList.length);
    });
  }
  void deletePaceNote() {
    var list = controller.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b));
    list.forEach((element) {
      myPaceNoteList.removeAt(element);
    });
    
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    for(int i in list)
    {
      db.collection('paceNote').where(
        for_removing[i]
      ).remove();
      for_removing.removeAt(i);
    }
    setState(() {
      controller.set(myPaceNoteList.length);
    });
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
    });
  }


  @override
  void initState() {
    super.initState();
    controller.disableEditingWhenNoneSelected = false;
    controller.set(myPaceNoteList.length);
    CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
    CloudBaseDatabase db = CloudBaseDatabase(core);
    getid().then((userID){
        db.collection('paceNote').where({
      'userID': userID
        }).get().then((res){
          for_removing = res.data;
          for(var i in res.data)
          {
            addPaceNote(i['title'],i['voteNum'],i);
          }
        });
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.arrowCircleLeft),
          color: Colors.white24,
        ),
        title: Text('我的路书'),

      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children:[IconButton(
              icon: FaIcon(FontAwesomeIcons.checkSquare),
              onPressed: selectAll,
            ),Text('全选'),
              IconButton(
                icon: Icon(Icons.delete,),
                onPressed: deletePaceNote,
              ),Text('删除')]
          ),
        
         Container(height: 680,child:  ListView.builder(shrinkWrap:true,itemCount:myPaceNoteList.length,itemBuilder: (context,index){
           return MultiSelectItem(isSelecting: controller.isSelecting, onSelected: (){setState(() {
             controller.toggle(index);
           });},child: Container(
             color: controller.isSelected(index)
                 ? Colors.yellowAccent:Colors.transparent,
             height:75,
             margin: EdgeInsets.only(left:10,right:10,top:10),
             child:myPaceNoteList[index],
           ),
           );

         }),),
        ],
      ),
    );
  }
}
