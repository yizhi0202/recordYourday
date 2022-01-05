import 'package:flutter/material.dart';
import 'package:flutter_app_y/pages/Under_PaceNote_Pages/searchScenicSpot.dart';
import 'package:flutter_app_y/pages/Under_ScenicSpot_Pages/commentsPage.dart';
import 'package:flutter_app_y/pages/Under_Selfhome_Pages/myFavoritePage.dart';
import 'package:flutter_app_y/pages/Under_Selfhome_Pages/myPaceNoteDetailPage.dart';
import 'package:flutter_app_y/pages/Under_Selfhome_Pages/myPaceNotePage.dart';
import 'package:flutter_app_y/pages/Under_Selfhome_Pages/myScenicSpotPage.dart';
import '../pages/Under_Selfhome_Pages/findPassPage.dart';
import '../pages/Under_Selfhome_Pages/loginPassPage.dart';
import '../pages/Under_Selfhome_Pages/editUserInfoPage.dart';
import '../pages/tabs/scenicSpotPage.dart';
import '../pages/tabs/paceNotePage.dart';
import '../pages/tabs/emgContactPage.dart';
import '../pages/tab.dart';
import '../pages/tabs/search.dart';
import '../pages/Under_Selfhome_Pages/loginCodePage.dart';
import '../pages/Under_Selfhome_Pages/signUpPage.dart';
import '../pages/Under_Selfhome_Pages/editPassPage.dart';
import '../pages/Under_ScenicSpot_Pages/scenicSpotDetailPage.dart';
import '../pages/Under_ScenicSpot_Pages/addScenicSpotPage.dart';
import '../pages/Under_PaceNote_Pages/addPaceNotePage.dart';
import '../pages/Under_PaceNote_Pages/paceNoteDetailPage.dart';
import '../pages/Under_EmgContact_Pages/addEmgContactPage.dart';
import '../res/module/mapSource/POIsearch.dart';

//配置路由,定义 Map 类型的 routes,Key 为 String 类型，Value 为 Function 类型
final Map<String, Function> routes = {
  '/tab': (context, {arguments}) => tab(arguments: arguments),
  '/scenicSpot': (context, {arguments}) => scenicSpotPage(),
  '/paceNote': (context, {arguments}) => paceNotePage(),
  '/emgContact': (context, {arguments}) => emgContactPage(),
  '/search': (context, {arguments}) => searchPage(arguments: arguments),
  '/loginPass': (context, {arguments}) => loginPassPage(),
  '/loginCode': (context, {arguments}) => loginCodePage(),
  '/signUp': (context, {arguments}) => signUpPage(),
  '/editPass': (context, {arguments}) => editPassPage(arguments: arguments),
  '/findPass': (context, {arguments}) => findPassPage(),
  '/editUserInfo':(context,{arguments})=>editUserInfoPage(),
  '/scenicSpotDetail': (context, {arguments}) => scenicSpotDetailPage(
        arguments: arguments,
      ),
  '/addScenicSpot': (context, {arguments}) => addScenicSpotPage(arguments: arguments),
  '/addPaceNote': (context, {arguments}) => addPaceNotePage(arguments: arguments),
  '/ShowPOICitySearchPage': (context, {arguments}) => ShowPOICitySearchPage(),
  '/paceNoteDetail': (context, {arguments}) => paceNoteDetailPage(arguments: arguments),
  '/myPaceNote':(context,{arguments})=>myPaceNotePage(),
  '/myPaceNoteDetail':(context,{arguments})=>myPaceNoteDetailPage(arguments:arguments),
  '/myScenicSpot':(context,{arguments})=>myScenicSpotPage(),
  '/myFavorite':(context,{arguments})=>myFavoritePage(),
  '/addEmgContact': (context, {arguments}) => addEmgContactPage(),
  '/comments':(context,{arguments})=>commentsPage(arguments: arguments),
  '/searchScenicSpot':(context,{arguments})=>searchScenicSpotPage()
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
