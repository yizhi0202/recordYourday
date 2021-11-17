import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_item/multi_select_item.dart';

class myFavoritePage extends StatefulWidget {
  @override
  _myFavoritePageState createState() => _myFavoritePageState();
}
//Navigator.pushNamed(context, '/myPaceNoteDetail')
class _myFavoritePageState extends State<myFavoritePage> {
  List<Widget> myFavorPaceNoteList = [];
  List<Widget> myFavorSpotList = [];
  MultiSelectController myFavorPaceNotesController = MultiSelectController();
  MultiSelectController myFavorSpotsController = MultiSelectController();
  Widget getMyFavorPaceNote({String title = '',int voteNum = 0,String nickName = '匿名用户',String photo = 'https://www.itying.com/images/flutter/4.png', })
  {
    return Card(
      child:  ListView(
        shrinkWrap: true,
        children: [
          Container(height: 190,width: 340,child: Image.network(photo,fit: BoxFit.cover,),),
      Row(mainAxisSize: MainAxisSize.min,children: [
          Text(title,overflow: TextOverflow.ellipsis,),
          // SizedBox(width: 160,),
        Text( ' |'+nickName,overflow: TextOverflow.ellipsis),
        ],),
          //Container(width: 380,child:  ListTile(leading: Container(height: 180,child: Image.network(photo),),title: Text(title,overflow: TextOverflow.ellipsis,),subtitle:Text(nickName)),),
          ButtonBar(children: [IconButton(onPressed: (){print('跳转到详情页');}, icon: FaIcon(FontAwesomeIcons.hiking)),GestureDetector(child: Text('路书详情页'),onTap: (){}),SizedBox(width: 20,),FaIcon(FontAwesomeIcons.heart),Text(voteNum.toString())],
          )
        ],
      ),
    );
  }

  Widget getMyFavorSpot({String title = '',int voteNum = 0,String nickName = '匿名用户',String photo = 'https://www.itying.com/images/flutter/4.png', })
  {
    return Card(
      child:  ListView(
        shrinkWrap: true,
        children: [
          Container(height: 190,width: 340,child: Image.network(photo,fit: BoxFit.cover,),),
          Row(mainAxisSize: MainAxisSize.min,children: [
            Text(title,overflow: TextOverflow.ellipsis,),
            // SizedBox(width: 160,),
            Text( ' |'+nickName,overflow: TextOverflow.ellipsis),
          ],),
          //Container(width: 380,child:  ListTile(leading: Container(height: 180,child: Image.network(photo),),title: Text(title,overflow: TextOverflow.ellipsis,),subtitle:Text(nickName)),),
          ButtonBar(children: [IconButton(onPressed: (){print('跳转到详情页');}, icon: FaIcon(FontAwesomeIcons.hiking)),GestureDetector(child: Text('景点详情页'),onTap: (){}),SizedBox(width: 20,),FaIcon(FontAwesomeIcons.heart),Text(voteNum.toString())],
          )
        ],
      ),
    );
  }

  void addMyFavorPaceNote({String title = '',int voteNum = 0,String nickName = '匿名用户',String photo = 'https://www.itying.com/images/flutter/4.png', })
  {
    myFavorPaceNoteList.add(getMyFavorPaceNote(title: title,voteNum: voteNum));
    setState(() {
      myFavorPaceNotesController.set(myFavorPaceNoteList.length);
    });
  }

  void addMyFavorSpot({String title = '',int voteNum = 0,String nickName = '匿名用户',String photo = 'https://www.itying.com/images/flutter/4.png', })
  {
    myFavorSpotList.add(getMyFavorSpot(title: title,voteNum: voteNum));
    setState(() {
      myFavorSpotsController.set(myFavorSpotList.length);
    });
  }
  void deleteMyFavorPaceNote() {
    var list = myFavorPaceNotesController.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b));
    list.forEach((element) {
      myFavorPaceNoteList.removeAt(element);
    });

    setState(() {
      myFavorPaceNotesController.set(myFavorPaceNoteList.length);
    });
  }
  void deleteMyFavorSpot() {
    var list = myFavorSpotsController.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b));
    list.forEach((element) {
      myFavorSpotList.removeAt(element);
    });

    setState(() {
      myFavorSpotsController.set(myFavorSpotList.length);
    });
  }

  void selectAllFavorPaceNote() {
    setState(() {
      myFavorPaceNotesController.toggleAll();
    });
  }
  void selectAllFavorSpot() {
    setState(() {
      myFavorSpotsController.toggleAll();
    });
  }


  @override
  void initState() {
    super.initState();
    addMyFavorSpot(title: '路书标题',voteNum: 0);
    addMyFavorPaceNote(title: '路书标题',voteNum: 0);
    myFavorPaceNotesController.disableEditingWhenNoneSelected = false;
    myFavorPaceNotesController.set(myFavorPaceNoteList.length);

    myFavorSpotsController.disableEditingWhenNoneSelected = false;
    myFavorSpotsController.set(myFavorSpotList.length);
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
      body:  ListView(
        children: [
              ExpansionTile(leading:Icon(Icons.menu_book,color: Colors.yellow,),title: Text('收藏的路书'),children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                    children:[IconButton(
                      icon: FaIcon(FontAwesomeIcons.checkSquare),
                      onPressed: selectAllFavorPaceNote,
                    ),Text('全选'),
                      IconButton(
                        icon: Icon(Icons.delete,),
                        onPressed: deleteMyFavorPaceNote,
                      ),Text('删除')]
                ),
                IconButton(onPressed: (){
                  addMyFavorPaceNote(title:'路书标题', voteNum: 13);
                }, icon: Icon(Icons.add)),
                ListView.builder(shrinkWrap:true,itemCount:myFavorPaceNoteList.length,itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){},
                    child: MultiSelectItem(isSelecting: myFavorPaceNotesController.isSelecting, onSelected: (){setState(() {
                      myFavorPaceNotesController.toggle(index);
                    });},child: Container(
                      color: myFavorPaceNotesController.isSelected(index)
                          ? Colors.yellowAccent:Colors.transparent,
                      height:280,
                      margin: EdgeInsets.only(left:10,right:10,top:10),
                      child:myFavorPaceNoteList[index],
                    ),
                    ),
                  );
                }),
              ],),
          ExpansionTile(leading:Icon(Icons.nature_people,color:Colors.green,),title: Text('收藏的景点'),children: [
            Row(
                mainAxisSize: MainAxisSize.min,
                children:[IconButton(
                  icon: FaIcon(FontAwesomeIcons.checkSquare),
                  onPressed: selectAllFavorSpot,
                ),Text('全选'),
                  IconButton(
                    icon: Icon(Icons.delete,),
                    onPressed: deleteMyFavorSpot,
                  ),Text('删除')]
            ),
            IconButton(onPressed: (){
              addMyFavorSpot(title:'路书标题', voteNum: 13);
            }, icon: Icon(Icons.add)),
            ListView.builder(shrinkWrap:true,itemCount:myFavorSpotList.length,itemBuilder: (context,index){
              return InkWell(
                onTap: (){},
                child: MultiSelectItem(isSelecting: myFavorSpotsController.isSelecting, onSelected: (){setState(() {
                  myFavorSpotsController.toggle(index);
                });},child: Container(
                  color: myFavorSpotsController.isSelected(index)
                      ? Colors.yellowAccent:Colors.transparent,
                  height:280,
                  margin: EdgeInsets.only(left:10,right:10,top:10),
                  child:myFavorSpotList[index],
                ),
                ),
              );
            }),
          ],)

        ],
      )
      // body: ListView(
      //   children: [
      //     ExpansionTile(leading:Icon(Icons.menu_book),title: Text('收藏的路书'),children: [
      //       ListView.builder(shrinkWrap:true,itemCount:myFavorPaceNoteList.length,itemBuilder: (context,index){
      //         return InkWell(
      //           onTap: (){},
      //           child: MultiSelectItem(isSelecting: myFavorPaceNotesController.isSelecting, onSelected: (){setState(() {
      //             myFavorPaceNotesController.toggle(index);
      //           });},child: Container(
      //             color: myFavorPaceNotesController.isSelected(index)
      //                 ? Colors.yellowAccent:Colors.transparent,
      //             height:75,
      //             margin: EdgeInsets.only(left:10,right:10,top:10),
      //             child:myFavorPaceNoteList[index],
      //           ),
      //           ),
      //         );
      //       }),
      //     ]
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //     children:[IconButton(
            //       icon: FaIcon(FontAwesomeIcons.checkSquare),
            //       onPressed: selectAllFavorPaceNote,
            //     ),Text('全选'),
            //       IconButton(
            //         icon: Icon(Icons.delete,),
            //         onPressed: deleteMyFavorPaceNote,
            //       ),Text('删除')]
            // ),
            // IconButton(onPressed: (){
            //   addMyFavorPaceNote(title:'路书标题', voteNum: 13);
            // }, icon: Icon(Icons.add)),
            // ListView.builder(shrinkWrap:true,itemCount:myFavorPaceNoteList.length,itemBuilder: (context,index){
            //   return InkWell(
            //     onTap: (){},
            //     child: MultiSelectItem(isSelecting: myFavorPaceNotesController.isSelecting, onSelected: (){setState(() {
            //       myFavorPaceNotesController.toggle(index);
            //     });},child: Container(
            //       color: myFavorPaceNotesController.isSelected(index)
            //           ? Colors.yellowAccent:Colors.transparent,
            //       height:75,
            //       margin: EdgeInsets.only(left:10,right:10,top:10),
            //       child:myFavorPaceNoteList[index],
            //     ),
            //     ),
            //   );
            // }),
          // ),
          // ExpansionTile(title: Text('收藏的景点'),leading: Icon(Icons.nature_people),children: [
          //   // Row(
          //   //     children:[IconButton(
          //   //       icon: FaIcon(FontAwesomeIcons.checkSquare),
          //   //       onPressed: selectAllFavorPaceNote,
          //   //     ),Text('全选'),
          //   //       IconButton(
          //   //         icon: Icon(Icons.delete,),
          //   //         onPressed: deleteMyFavorPaceNote,
          //   //       ),Text('删除')]
          //   // ),
          //   IconButton(onPressed: (){
          //     addMyFavorPaceNote(title:'路书标题', voteNum: 13);
          //   }, icon: Icon(Icons.add)),
          //   ListView.builder(shrinkWrap:true,itemCount:myFavorPaceNoteList.length,itemBuilder: (context,index){
          //     return InkWell(
          //       onTap: (){},
          //       child: MultiSelectItem(isSelecting: myFavorPaceNotesController.isSelecting, onSelected: (){setState(() {
          //         myFavorPaceNotesController.toggle(index);
          //       });},child: Container(
          //         color: myFavorPaceNotesController.isSelected(index)
          //             ? Colors.yellowAccent:Colors.transparent,
          //         height:75,
          //         margin: EdgeInsets.only(left:10,right:10,top:10),
          //         child:myFavorPaceNoteList[index],
          //       ),
          //       ),
          //     );
          //   }),
          // ],),
          // ],)
      );
  }
}
