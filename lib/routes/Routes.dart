import 'package:flutter/material.dart';
import '../pages/tabs/catagory.dart';
import '../pages/tabs/home.dart';
import '../pages/tabs/setting.dart';
import '../pages/tab.dart';
import '../pages/tabs/search.dart';

//配置路由,定义 Map 类型的 routes,Key 为 String 类型，Value 为 Function 类型
final Map<String, Function> routes = {
  '/': (context) => tab(),
  '/category': (context) => categoryPage(),
  '/home': (context) => homePage(),
  '/setting': (context) => settingPage(),
  '/search': (context) => searchPage()
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
