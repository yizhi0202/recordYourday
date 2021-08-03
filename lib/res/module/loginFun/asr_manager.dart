import 'dart:async';
import 'package:flutter/services.dart';

class ArsManager {
  static const MethodChannel _channel = const MethodChannel('asr_plugin');

  static Future<String> telephone(String phone) async {
    return await _channel.invokeMethod('telephone', phone);
  }

  static Future<dynamic> correct(Map map) async {
    return await _channel.invokeMethod('correct', map);
  }
}
