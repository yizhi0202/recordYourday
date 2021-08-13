import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:getwidget/getwidget.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';

List<String> photos = [
  'https://www.itying.com/images/flutter/1.png',
  'https://www.itying.com/images/flutter/2.png',
  'https://www.itying.com/images/flutter/3.png',
  'https://www.itying.com/images/flutter/4.png'
];

class scenicSpotDetailPage extends StatefulWidget {
  Map arguments;
  scenicSpotDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _scenicSpotDetailPageState createState() => _scenicSpotDetailPageState();
}

class _scenicSpotDetailPageState extends State<scenicSpotDetailPage> {
  List<Asset> resultList = <Asset>[];
  Widget getPhoto(index) {
    return Image.network(
      photos[index],
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: 270,
              width: 480,
              child: GFCarousel(
                autoPlay: true,
                viewportFraction: 0.8,
                pagination: true,
                passiveIndicator: Colors.grey,
                activeIndicator: Colors.white,
                items: photos.map(
                  (url) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(url, fit: BoxFit.cover),
                      ),
                    );
                  },
                ).toList(),
                onPageChanged: (index) {
                  setState(() {
                    index;
                  });
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  if (widget.arguments['userID'] != null)
                    print('there are arguments,${widget.arguments['userID']}');
                  else
                    print('no arguments');
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 32,
                )),
          ],
        ),
        Container(
          height: 60,
          width: 480,
          child: ListTile(
              title: Text('景点名称${widget.arguments['scenicSpotName']}'),
              subtitle: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: FaIcon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 18,
                      color: Colors.yellow,
                    ),
                  ),
                  Text(
                    '景点位置${widget.arguments['scenicSpotLocation']}',
                  )
                ],
              ),
              trailing: Stack(
                children: [
                  Padding(
                      child: Icon(
                        Icons.circle,
                        size: 42,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.only(top: 8, right: 0)),
                  Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        )),
                  ),
                ],
              )),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 240,
            child: SingleChildScrollView(
              child: Text(
                '简介${widget.arguments['introduction'] * 10}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            '全部评论({26})',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          child: ListTile(
              horizontalTitleGap: 8.0,
              leading: ClipOval(
                child: Image.network(
                  'https://www.itying.com/images/flutter/1.png',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(
                  left: 0,
                ),
                child: Row(
                  children: [
                    TextButton(
                      child: Text('此人昵称'),
                      onPressed: () {},
                    ),
                    Text(
                      '2021-8-12 14:34',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(
                  left: 7,
                ),
                child: Text(
                  '评论，不错的',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          height: 100,
        ),
        Padding(
          padding: EdgeInsets.only(left: 210, right: 32),
          child: TextButton(
              onPressed: () {
                print('查看更多的评论');
              },
              child: Text(
                '查看更多 >',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              )),
        ),
        Row(
          children: [
            Expanded(
              child: ButtonBar(
                children: [Icon(Icons.comment), Text('24')],
              ),
              flex: 1,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print('点赞数增加');
                },
                child: ButtonBar(
                  children: [FaIcon(FontAwesomeIcons.heart), Text('36')],
                ),
              ),
              flex: 1,
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: 16,
                )),
            Expanded(
              child: Container(
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: TextField(
                      onTap: () {},
                      decoration: InputDecoration(
                        labelText: '评论显真情...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            /// 里面的数值尽可能大才是左右半圆形，否则就是普通的圆角形
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  )),
              flex: 2,
            ),
          ],
        )
      ],
    ));
  }
}

//  Card(
//             child: Row(
//               children: [
//                 ClipOval(
//                   child: Image.network(
//                     'https://www.itying.com/images/flutter/1.png',
//                     fit: BoxFit.cover,
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [],
//                     ),
//                     Expanded(
//                       child: Text(
//                         ' 评论，不错的' * 10,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),