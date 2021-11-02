import 'package:flutter/material.dart';
import 'routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;
import 'dart:io' show Platform;

// void main() {

//   runApp(MyApp());
// }
void main() {
  runApp(MyApp());
  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        'DCIw3ppztGNMQt2HqEFFKuE5nfY6NBBs', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    // Android 目前不支持接口设置Apikey,
    // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loginPass',
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
