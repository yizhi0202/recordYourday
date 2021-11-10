import 'package:flutter/material.dart';
import 'package:flutter_app_y/res/module/paceNote/paceNote.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class addPaceNotePage extends StatefulWidget {
  addPaceNotePage({Key? key}) : super(key: key);

  @override
  _addPaceNotePageState createState() => _addPaceNotePageState();
}

class _addPaceNotePageState extends State<addPaceNotePage> {
  TextEditingController paceNoteTitle = TextEditingController();
  TextEditingController paceNoteFeeling = TextEditingController();
  Widget GetMyCard(
      {String title = '景点标题', String location = '景点详细地址', int ordinum = 1}) {
    ordinum += 1;
    return Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: GFIconButton(
            color: Colors.yellow,
            icon: Text(
              ordinum.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {},
            shape: GFIconButtonShape.circle,
          ),
          title: Text(title),
          subtitle: Text(location),
          trailing: FaIcon(
            FontAwesomeIcons.map,
            color: Colors.lightGreen,
          ),
        ));
  }

  List<Widget> paceNoteList = [];
  void IncreaseSpot(String title, String location) {
    paceNoteList.add(GetMyCard(
        title: title, location: location, ordinum: paceNoteList.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('新建路书'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {},
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
      floatingActionButton: GFIconButton(
        color: Colors.yellow,
        iconSize: 40,
        onPressed: () {
          setState(() {
            IncreaseSpot('景点标题', '景点地点');
          });
        },
        icon: Icon(Icons.add),
        shape: GFIconButtonShape.circle,
        tooltip: '添加新段落',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // adjust the floating button location
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 30),
            height: 150,
            child: GFButton(
              onPressed: () {},
              text: '上传封面',
              shape: GFButtonShape.standard,
              color: Colors.orangeAccent,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '我是标题',
                style: TextStyle(fontSize: 16),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: paceNoteTitle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '我是感受',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: paceNoteFeeling,
            ),
          ),
          ListView.builder(
            itemCount: paceNoteList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return paceNoteList[index];
            },
          )
        ],
      ),
    );
  }
}
