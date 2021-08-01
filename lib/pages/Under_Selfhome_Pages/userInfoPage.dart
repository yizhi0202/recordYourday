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
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage('${getProfilePhoto}')),
            title: Text('${getNickName}'),
            subtitle: (getUserSex == userSex.male)
                ? Icon(Icons.male)
                : Icon(Icons.female),
          ),
          ButtonBar(
            children: [
              Icon(
                Icons.menu_book,
                color: Colors.yellow,
              ),
              Text('我的路书')
            ],
          ),
          ButtonBar(
            children: [
              Icon(
                Icons.nature_people,
                color: Colors.lightGreen,
              ),
              Text('我的景点')
            ],
          ),
          ButtonBar(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text('我的收藏')
            ],
          ),
          ButtonBar(
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.lightBlue,
              ),
              Text('个人资料')
            ],
          ),
          ButtonBar(
            children: [
              Icon(
                Icons.lock_rounded,
                color: Colors.yellow,
              ),
              Text('修改密码')
            ],
          ),
          ButtonBar(
            children: [
              Icon(
                Icons.logout_outlined,
                color: Colors.yellow,
              ),
              Text('退出登录')
            ],
          ),
        ],
      ),
    );
  }
}
