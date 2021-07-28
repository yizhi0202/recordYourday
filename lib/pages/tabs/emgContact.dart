import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class emgContactPage extends StatefulWidget {
  emgContactPage({Key? key}) : super(key: key);

  @override
  _emgContactPageState createState() => _emgContactPageState();
}

class _emgContactPageState extends State<emgContactPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              height: 200,
              width: 400,
              color: Colors.cyanAccent,
              child: Text('Front'),
            ),
            back: Container(
              color: Colors.deepOrange,
              height: 200,
              width: 400,
              child: Text('Back'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              height: 200,
              width: 400,
              color: Colors.cyan,
              child: Text('Front'),
            ),
            back: Container(
              color: Colors.green,
              height: 200,
              width: 400,
              child: Text('Back'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              height: 200,
              width: 400,
              color: Colors.red,
              child: Text('Front'),
            ),
            back: Container(
              color: Colors.lightBlue,
              height: 200,
              width: 400,
              child: Text('Back'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              height: 200,
              width: 400,
              color: Colors.red,
              child: Text('Front'),
            ),
            back: Container(
              color: Colors.lightBlue,
              height: 200,
              width: 400,
              child: Text('Back'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              height: 200,
              width: 400,
              color: Colors.red,
              child: Text('Front'),
            ),
            back: Container(
              color: Colors.lightBlue,
              height: 200,
              width: 400,
              child: Text('Back'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              height: 200,
              width: 400,
              color: Colors.red,
              child: Text('Front'),
            ),
            back: Container(
              color: Colors.lightBlue,
              height: 200,
              width: 400,
              child: Text('Back'),
            ),
          ),
        ),
      ],
    );
  }
}
