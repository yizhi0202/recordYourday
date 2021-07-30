import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class emgContact extends StatelessWidget {
  final String name;
  final int phoneNumber;
  final String profilePhoto;
  final String comment;

  emgContact(
      {Key? key,
      this.name = '',
      this.profilePhoto = 'https://www.itying.com/images/flutter/3.png',
      this.comment = '',
      this.phoneNumber = 0})
      : super(key: key) {
    assert(phoneNumber >= 10000000000 && phoneNumber <= 19999999999);
  }

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: GFAvatar(
        backgroundImage: NetworkImage('${profilePhoto}'),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      titleText: '${name}',
      subTitleText: '${phoneNumber}',
    );
  }
}
