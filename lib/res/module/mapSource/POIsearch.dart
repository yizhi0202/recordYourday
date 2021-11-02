import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/map_appbar.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/map_base_page_state.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/constants.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/search_btn.dart';

import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/input_box.dart';

/// POI城市内检索
class ShowPOICitySearchPage extends StatefulWidget {
  @override
  _ShowPOICitySearchPageState createState() => _ShowPOICitySearchPageState();
}

class _ShowPOICitySearchPageState
    extends BMFBaseMapState<ShowPOICitySearchPage> {
  final _cityController = TextEditingController(text: "南京"); //暂未使用
  final _keywordController =
      TextEditingController(text: "输入心怡景点吧"); //检索用户输入的景点位置

  /// 自定义检索参数
  BMFPoiCitySearchOption? _citySearchOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: [
          _topSearchBar(),
          Expanded(
            child: generateMap(),
          ),
        ],
      ),
    );
  }

  /// 搜索
  void _onTapSearch() async {
    //收起键盘
    FocusScope.of(context).requestFocus(FocusNode());

    /// 检索参数
    BMFPoiCitySearchOption citySearchOption = BMFPoiCitySearchOption(
        city: _cityController.text,
        keyword: _keywordController.text,
        scope: BMFPoiSearchScopeType.DETAIL_INFORMATION);

    if (_citySearchOption != null) {
      citySearchOption.tags = _citySearchOption?.tags;
      citySearchOption.pageIndex = _citySearchOption?.pageIndex;
      citySearchOption.pageSize = _citySearchOption?.pageSize;
      citySearchOption.scope = _citySearchOption?.scope;
      citySearchOption.isCityLimit = _citySearchOption?.isCityLimit;
      citySearchOption.filter = _citySearchOption?.filter;
    }

    /// 检索对象
    BMFPoiCitySearch citySearch = BMFPoiCitySearch();

    /// 检索回调
    citySearch.onGetPoiCitySearchResult(callback: _onGetPoiCitySearchResult);

    /// 发起检索
    bool result = await citySearch.poiCitySearch(citySearchOption);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索回调
  Future _onGetPoiCitySearchResult(
      BMFPoiSearchResult result, BMFSearchErrorCode errorCode) async {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      showToast(context, error);
      print(error);
      return;
    }

    List<Map> points = [];
    //便利拼接信息
    for (var item in result.poiInfoList) {
      points.add({
        'title': await item.name,
        'address': await item.address,
        'position': await item.pt,
      });
    }
    //弹出底部对话框并等待选择
    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return points.length > 0
              ? ListView.builder(
                  itemCount: points.length,
                  itemBuilder: (BuildContext itemContext, int i) {
                    return ListTile(
                      title: Text(points[i]['title']),
                      subtitle: Text(points[i]['address']),
                      onTap: () {
                        Navigator.pop(context, points[i]);
                      },
                    );
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(40),
                  child: Text('暂无数据'));
        });

    /// 添加poi marker
    if (option != null) {
      BMFMarker marker = BMFMarker(
        position: option['position'],
        title: option['title'],
        subtitle: option['address'],
        icon: "images/pin_red.png",
      );
      List<BMFMarker> markers = [];
      markers.add(marker);
      //删除原来地图上搜索出来的点
      myMapController.cleanAllMarkers();
      //将搜索出来的点显示在界面上
      myMapController.addMarkers(markers);
      //将地图中心点移动到选择的点
      myMapController.setCenterCoordinate(markers.first.position, true);
    }
  }

  ///final search bar
  Widget _topSearchBar() {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 46,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width - 20 - 80,
            child: TextField(
              controller: _keywordController,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: _onTapSearch)
        ],
      ),
    );
  }
}
