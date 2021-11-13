import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class emgContact extends StatelessWidget {
  final String nickName;
  final int phoneNumber;
  final String email;
  final String profilePhoto;
  final String comment;

  emgContact(
      {Key? key,
      this.nickName = '',
      this.profilePhoto = 'https://www.itying.com/images/flutter/3.png',
      this.comment = '',
      this.email = '1927423294@qq.com',
      this.phoneNumber = 19999999999})
      : super(key: key) {
    assert(phoneNumber >= 10000000000 && phoneNumber <= 19999999999);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 120,
        child: GFListTile(
          avatar: GFAvatar(
            backgroundImage: NetworkImage('$profilePhoto'),
            size: 40.0,
          ),
          titleText: '$nickName',
          subTitleText: '$email',
        ));
  }
}
