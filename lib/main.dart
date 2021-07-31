import 'package:flutter/material.dart';
import 'routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
      ),
    );
  }
}

// class HomeContent extends StatelessWidget {
//   //自定义方法
//   List<Widget> _getdata() {
//     var tempList = listData.map((value) {
//       return Container(
//         child: Column(
//           children: <Widget>[
//             Image.network(value['imageUrl']),
//             SizedBox(height: 12),
//             Text(value['title'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                 )),
//             Text(
//               value['author'],
//             )
//           ],
//         ),
//         decoration: BoxDecoration(
//             border: Border.all(
//                 color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
//       );
//     });
//     return tempList.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisSpacing: 20.0,
//       mainAxisSpacing: 20.0,
//       padding: EdgeInsets.all(10),
//       crossAxisCount: 2,
//       children: this._getdata(),
//     );
//   }
// }
