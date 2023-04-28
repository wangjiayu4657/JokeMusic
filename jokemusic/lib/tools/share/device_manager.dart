import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceManager {
  static String? _uk;
  static String? _app;
  static IosDeviceInfo? iosDevice;
  static AndroidDeviceInfo? androidDevice;

  static deviceInfo() async {
    DeviceInfoPlugin device = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await device.androidInfo;
      // debugPrint('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
      androidDevice =  androidInfo;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await device.iosInfo;
      // debugPrint("iosInfo == $iosInfo");
      // debugPrint('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
      iosDevice = iosInfo;
    }
  }

  static String get uk {
    if(Platform.isAndroid) {
      return androidDevice?.serialNumber ?? "";
    } else if(Platform.isIOS) {
      return iosDevice?.identifierForVendor ?? "";
    }
    return "";
  }

  static String get app {
    if(Platform.isAndroid) {
      String version = androidDevice?.version.release ?? "";
      return "1.0.0;1;$version";
    } else if(Platform.isIOS) {
      String version = iosDevice?.systemVersion ?? "";
      return "1.0.0;1;$version";
    }
    return "";
  }

  static String get device {
    if(Platform.isAndroid) {
      String model = androidDevice?.model ?? "";
      String name = androidDevice?.device ?? "";
      return "$model;$name";
    } else if(Platform.isIOS) {
      String model = iosDevice?.model ?? "";
      String name = iosDevice?.name ?? "";
      return "$model;$name";
    }
    return "";
  }
}