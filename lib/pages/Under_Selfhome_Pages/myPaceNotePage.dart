import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_item/multi_select_item.dart';

class myPaceNotePage extends StatefulWidget {
  @override
  _myPaceNotePageState createState() => _myPaceNotePageState();
}
//Navigator.pushNamed(context, '/myPaceNoteDetail')
class _myPaceNotePageState extends State<myPaceNotePage> {
  List<Widget> myPaceNoteList = [];
  MultiSelectController controller = MultiSelectController();
  Widget getMyPaceNote({String title = '',int voteNum = 0})
  {
    return Card(
      child: ListTile(leading: Icon(Icons.menu_book,color: Colors.yellow,),title: Text(title,),trailing: Row(mainAxisSize:MainAxisSize.min ,children: [IconButton(onPressed: (){
        Navigator.pushNamed(context, '/myPaceNoteDetail');
      }, icon: FaIcon(FontAwesomeIcons.hiking)),GestureDetector(child: Text('路书详情'),onTap: (){ Navigator.pushNamed(context, '/myPaceNoteDetail');},),FaIcon(FontAwesomeIcons.heart),Text(voteNum.toString())],)),
    );
  }

  void addPaceNote(String title, int voteNum)
  {
    myPaceNoteList.add(getMyPaceNote(title: title,voteNum: voteNum));
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
    addPaceNote('初始标题',10);
    controller.disableEditingWhenNoneSelected = false;
    controller.set(myPaceNoteList.length);
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
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
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
          IconButton(onPressed: (){
            addPaceNote('路书标题', 89);
          }, icon: Icon(Icons.add)),
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
