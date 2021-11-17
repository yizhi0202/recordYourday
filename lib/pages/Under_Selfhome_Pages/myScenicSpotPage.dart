import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_item/multi_select_item.dart';

class myScenicSpotPage extends StatefulWidget {
  @override
  _myScenicSpotPageState createState() => _myScenicSpotPageState();
}

class _myScenicSpotPageState extends State<myScenicSpotPage> {
  List<Widget> myScenicSpotList = [];
  MultiSelectController controller = MultiSelectController();
  Widget getMyScenicSpot({String title = '',int voteNum = 0})
  {
    return Card(
      child: ListTile(leading: Icon(Icons.nature_people,color: Colors.green,),title: Text(title,),trailing: Row(mainAxisSize:MainAxisSize.min ,children: [IconButton(onPressed: (){
        Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
          'userID': '1897654',
          'scenicSpotName': '荔波',
          'scenicSpotLocation': '贵州',
          'photoNum':
          0, //this varible is to record the number of photo been uploaded by user
          'introduction':
          '荔波一生必去的地方，荔波是中共一大代表邓恩铭烈士的故乡，境内生态良好，气候宜人，拥有国家5A级樟江风景名胜区、国家级茂兰自然保护区、水春河漂流、黄江河国家级湿地公园、瑶山古寨景区、四季花海和寨票、水浦、大土民宿等景区景点。'
        });
      }, icon: FaIcon(FontAwesomeIcons.hiking)),GestureDetector(child: Text('景点详情'),onTap: (){ Navigator.pushNamed(context, '/scenicSpotDetail', arguments: {
        'userID': '1897654',
        'scenicSpotName': '荔波',
        'scenicSpotLocation': '贵州',
        'photoNum':
        0, //this varible is to record the number of photo been uploaded by user
        'introduction':
        '荔波一生必去的地方，荔波是中共一大代表邓恩铭烈士的故乡，境内生态良好，气候宜人，拥有国家5A级樟江风景名胜区、国家级茂兰自然保护区、水春河漂流、黄江河国家级湿地公园、瑶山古寨景区、四季花海和寨票、水浦、大土民宿等景区景点。'
      });},),FaIcon(FontAwesomeIcons.heart),Text(voteNum.toString())],)),
    );
  }

  void addScenicSpot(String title, int voteNum)
  {
    myScenicSpotList.add(getMyScenicSpot(title: title,voteNum: voteNum));
    setState(() {
      controller.set(myScenicSpotList.length);
    });
  }
  void deleteScenicSpot() {
    var list = controller.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b));
    list.forEach((element) {
      myScenicSpotList.removeAt(element);
    });

    setState(() {
      controller.set(myScenicSpotList.length);
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
    addScenicSpot('初始标题',10);
    controller.disableEditingWhenNoneSelected = false;
    controller.set(myScenicSpotList.length);
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
        title: Text('我的景点'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body: ListView(
        children: [
          Row(
              children:[IconButton(
                icon: FaIcon(FontAwesomeIcons.checkSquare),
                onPressed: selectAll,
              ),Text('全选'),
                IconButton(
                  icon: Icon(Icons.delete,),
                  onPressed: deleteScenicSpot,
                ),Text('删除')]
          ),
          IconButton(onPressed: (){
            addScenicSpot('景点标题', 89);
          }, icon: Icon(Icons.add)),
          ListView.builder(shrinkWrap:true,itemCount:myScenicSpotList.length,itemBuilder: (context,index){
            return InkWell(
              onTap: (){},
              child: MultiSelectItem(isSelecting: controller.isSelecting, onSelected: (){setState(() {
                controller.toggle(index);
              });},child: Container(
                color: controller.isSelected(index)
                    ? Colors.yellowAccent:Colors.transparent,
                height:75,
                margin: EdgeInsets.only(left:10,right:10,top:10),
                child:myScenicSpotList[index],
              ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
