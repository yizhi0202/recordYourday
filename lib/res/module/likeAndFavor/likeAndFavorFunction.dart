import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_y/res/module/dataBase/getCloudBaseCore.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:flutter_app_y/res/module/baiduMapmodule/alert_dialog_utils.dart';


Future setVoteNum(String recordName, String objectID) async{
  CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
  CloudBaseDatabase db = CloudBaseDatabase(core);
  var _ = db.command;
  db.collection(recordName).where({
    '_id': objectID
  }).update({
    'voteNum': _.inc(1)
  }).then((res) {
  });
}

 Future favorObject(String storeFavorRecordName, String userID, String objectID, BuildContext context) async
{
  CloudBaseCore core = MyCloudBaseDataBase().getCloudBaseCore();
  CloudBaseDatabase db = CloudBaseDatabase(core);
  String IDname ='';
  if('myFavorScenicSpot' == storeFavorRecordName)
    {
      IDname = 'scenicSpotID';
    }
  else if('myFavorPaceNote' == storeFavorRecordName)
    {
      IDname = 'paceNoteID';
    }
  // ignore: unnecessary_statements
  else
    {
      showToast(context, '输入的存储集合名有误!');
      return;
    }
  var _ = db.command;
  db.collection(storeFavorRecordName).where({
    'userID':userID,
    IDname:objectID
  }).get().then((value) {
    if(value.data.length == 0)
      {
        showToast(context, '收藏成功!');
        db.collection(storeFavorRecordName).add({
          'userID':userID,
          IDname:objectID
        });

      }
    else{
      showToast(context, '已经收藏过!');
    }
  });
}

