// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:sp_util/sp_util.dart';

// class Storage<T> {
//    static Type typeOf<T>() => T;
//
//    ///存值
//    static save<T>(String key, T value) async {
//      final prefs = await SharedPreferences.getInstance();
//      if (value is String) {
//        prefs.setString(key, value);
//      } else if(value is bool) {
//        prefs.setBool(key, value);
//      } else if(value is int) {
//        prefs.setInt(key, value);
//      } else if(value is double) {
//        prefs.setDouble(key, value);
//      } else if(value is List<String>) {
//        prefs.setStringList(key, value);
//      }
//    }
//
//    ///取值
//    static Future fetch<T>(String key) async {
//      final prefs = await SharedPreferences.getInstance();
//      var type = typeOf<T>();
//      if (type == String) {
//        return prefs.getString(key) ?? "";
//      } else if(type == bool) {
//        return prefs.getBool(key) ?? false;
//      } else if(type == int) {
//        return prefs.getInt(key) ?? 0;
//      } else if(type == double) {
//        return prefs.getDouble(key) ?? 0.0;
//      } else if(type == List<String>) {
//        return prefs.getStringList(key) ?? <String>[];
//      }
//    }
//
//    ///更新
//    static update<T>(String key, T value) {
//      save(key, value);
//    }
//
//    ///删除
//    static remove(String key) async {
//      final prefs = await SharedPreferences.getInstance();
//      prefs.remove(key);
//    }
//
//    ///get string value
//    static Future<String> fetchString(String key) async {
//      return await fetch<String>(key);
//    }
//
//    ///get bool value
//    static Future<bool> fetchBool(String key) async {
//      return await fetch<bool>(key);
//    }
//
//    ///get int value
//    static Future<int> fetchInt(String key) async {
//      return await fetch<int>(key);
//    }
//
//    ///get double value
//    static Future<double> fetchDouble(String key) async{
//      return await fetch<double>(key);
//    }
//
//    ///get List<String> value
//    static Future<List<String>> fetchList(String key) async {
//      return await fetch<List<String>>(key);
//    }
// }

class Storage {
  static Type typeOf<T>() => T;

  ///存值
  static save<T>(String key, T value) async {
    if (value is String) {
      SpUtil.putString(key, value);
    } else if(value is bool) {
      SpUtil.putBool(key, value);
    } else if(value is int) {
      SpUtil.putInt(key, value);
    } else if(value is double) {
      SpUtil.putDouble(key, value);
    } else if(value is List<String>) {
      SpUtil.putStringList(key, value);
    } else if(value is List<Object>) {
      SpUtil.putObjectList(key, value);
    } else if(value is Object) {
      SpUtil.putObject(key, value);
    }
  }

  ///取值
  static Future fetch<T>(String key) async {
    var type = typeOf<T>();
    if (type == String) {
      return SpUtil.getString(key);
    } else if(type == bool) {
      return SpUtil.getBool(key);
    } else if(type == int) {
      return SpUtil.getInt(key);
    } else if(type == double) {
      return SpUtil.getDouble(key);
    } else if(type == List<String>) {
      return SpUtil.getStringList(key);
    } else if(type == List<Map>) {
      return SpUtil.getObjectList(key);
    } else if (type == Object) {
      return SpUtil.getObject(key);
    }
  }

  ///更新
  static update<T>(String key, T value) {
    save(key, value);
  }

  ///删除
  static remove(String key) async {
    SpUtil.remove(key);
  }

  ///清空
  static clear() => SpUtil.clear();

  ///get string value
  static Future<String> fetchString(String key) async {
    return await fetch<String>(key);
  }

  ///get bool value
  static Future<bool> fetchBool(String key) async {
    return await fetch<bool>(key);
  }

  ///get int value
  static Future<int> fetchInt(String key) async {
    return await fetch<int>(key);
  }

  ///get double value
  static Future<double> fetchDouble(String key) async{
    return await fetch<double>(key);
  }

  ///get List<String> value
  static Future<List<String>> fetchStringList(String key) async {
    return await fetch<List<String>>(key);
  }

  ///get List<Object> value
  static Future<List<Object>> fetchObjectList(String key) async {
    return await fetch<List<Object>>(key);
  }

  ///get List<T> value
  static List<T>? fetchObjList<T>(String key, T Function(Map v) f) {
    return SpUtil.getObjList(key, f);
  }

}