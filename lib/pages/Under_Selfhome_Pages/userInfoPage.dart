import 'package:flutter/material.dart';
import '../../res/module/user/user.dart';

class userInfoPage extends StatelessWidget with user {
  userInfoPage({Key? key}) : super(key: key);

  @override
  initUser(
      {required int userID,
      required String userPass,
      userSex mySex = userSex.male,
      userType myType = userType.traveler,
      String profilePhoto = 'https://www.itying.com/images/flutter/1.png',
      String nickname = ''}) {
    // TODO: implement initUser
    return super.initUser(
        userID: userID,
        userPass: userPass,
        nickname: nickname,
        mySex: mySex,
        myType: myType,
        profilePhoto: profilePhoto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            height: 100,
            width: 280,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ClipOval(
                child: Image.network(
                  '${getProfilePhoto}',
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 20),
                    child: Text(
                      '${getNickName}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  (getUserSex == userSex.male)
                      ? Icon(
                          Icons.male,
                          color: Colors.lightBlue,
                        )
                      : Icon(
                          Icons.female,
                          color: Colors.pink,
                        )
                ],
              )
            ]),
          ),
          Divider(
              color:
                  getUserSex == userSex.male ? Colors.lightBlue : Colors.pink,
              indent: 8.0,
              endIndent: 8.0),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              print('tap my paceNote');
            },
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book,
                  color: Colors.yellow,
                  size: 32.0,
                ),
                Text(
                  '我的路书',
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.nature_people,
                  color: Colors.lightGreen,
                  size: 32,
                ),
                Text(
                  '我的景点',
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 32,
                ),
                Text(
                  '我的收藏',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.lightBlue,
                  size: 32,
                ),
                Text(
                  '个人资料',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_rounded,
                  color: Colors.yellow,
                  size: 32,
                ),
                Text(
                  '修改密码',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.yellow,
                  size: 32,
                ),
                Text('退出登录', style: TextStyle(fontSize: 18))
              ],
            ),
          )
        ],
      ),
    );
  }
}
