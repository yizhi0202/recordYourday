import 'package:flutter/material.dart';
import '../pages/Under_Selfhome_Pages/findPassPage.dart';
import '../pages/Under_Selfhome_Pages/loginPassPage.dart';
import '../pages/tabs/scenicSpotPage.dart';
import '../pages/tabs/paceNotePage.dart';
import '../pages/tabs/emgContactPage.dart';
import '../pages/tab.dart';
import '../pages/tabs/search.dart';
import '../pages/Under_Selfhome_Pages/loginCodePage.dart';
import '../pages/Under_Selfhome_Pages/signUpPage.dart';
import '../pages/Under_Selfhome_Pages/editPassPage.dart';

//配置路由,定义 Map 类型的 routes,Key 为 String 类型，Value 为 Function 类型
final Map<String, Function> routes = {
  '/': (context) => tab(),
  '/scenicSpot': (context) => scenicSpotPage(),
  '/paceNote': (context) => paceNotePage(),
  '/emgContact': (context) => emgContactPage(),
  '/search': (context) => searchPage(),
  '/loginPass': (context) => loginPassPage(),
  '/loginCode': (context) => loginCodePage(),
  '/signUp': (context) => signUpPage(),
  '/editPass': (context) => editPassPage(),
  '/findPass': (context) => findPassPage(),
};

var onGenerateRoute = (RouteSettings settings) {
//String? 表示 name 为可空类型
  final String? name = settings.name;
//Function? 表示 pageContentBuilder 为可空类型
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
