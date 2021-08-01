import 'package:flutter/material.dart';

class selfHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.itying.com/images/flutter/4.png')),
            title: Text('安妮'),
          )
        ],
      ),
    );
  }
}
