import 'package:flutter/material.dart';

import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';

class MyCloudBaseDataBase {
  CloudBaseCore getCloudBaseCore() {
    CloudBaseCore core = CloudBaseCore.init({
      'env': 'hello-cloudbase-7gk3odah3c13f4d1',
      'appAccess': {'key': 'f9fadd353a3e75450ba4080b75789ebd', 'version': '1'}
    });
    return core;
  }
}
