import 'package:shared_preferences/shared_preferences.dart';

class Storage<T> {
   static Type typeOf<T>() => T;

   ///存值
   static save<T>(String key, T value) async {
     final prefs = await SharedPreferences.getInstance();
     if (value is String) {
       prefs.setString(key, value);
     } else if(value is bool) {
       prefs.setBool(key, value);
     } else if(value is int) {
       prefs.setInt(key, value);
     } else if(value is double) {
       prefs.setDouble(key, value);
     } else if(value is List<String>) {
       prefs.setStringList(key, value);
     }
   }

   ///取值
   static Future fetch<T>(String key) async {
     final prefs = await SharedPreferences.getInstance();
     var type = typeOf<T>();
     if (type == String) {
       return prefs.getString(key) ?? "";
     } else if(type == bool) {
       return prefs.getBool(key) ?? false;
     } else if(type == int) {
       return prefs.getInt(key) ?? 0;
     } else if(type == double) {
       return prefs.getDouble(key) ?? 0.0;
     } else if(type == List<String>) {
       return prefs.getStringList(key) ?? <String>[];
     }
   }

   ///更新
   static update<T>(String key, T value) {
     save(key, value);
   }

   ///删除
   static remove(String key) async {
     final prefs = await SharedPreferences.getInstance();
     prefs.remove(key);
   }

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
   static Future<List<String>> fetchList(String key) async {
     return await fetch<List<String>>(key);
   }
}