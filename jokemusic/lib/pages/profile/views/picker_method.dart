import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';

// Future<AssetEntity?> _pickFromCamera(BuildContext context) {
//   return CameraPicker.pickFromCamera(
//     context,
//     pickerConfig: const CameraPickerConfig(enableRecording: true),
//   );
// }

class PickerMethod {
  const PickerMethod({
    required this.icon,
    required this.name,
    required this.description,
    required this.method,
    this.onLongPress
  });

  final String icon;
  final String name;
  final String description;
  final GestureLongPressCallback? onLongPress;
  /// 定义如何使用选择器的核心函数。
  final Future<List<AssetEntity>?> Function(
    BuildContext context,
    List<AssetEntity> selectedAssets,
  ) method;

  ///选择图片
  factory PickerMethod.image({int maxCount = 9}) {
    return PickerMethod(
      icon: "🖼️",
      name: "image picker",
      description: "Only pick image from device",
      method: (BuildContext context, List<AssetEntity> assets) {
        return AssetPicker.pickAssets(context,
          pickerConfig: AssetPickerConfig(
            maxAssets: maxCount,
            selectedAssets: assets,
            requestType: RequestType.image
          )
        );
      }
    );
  }

  ///选择视频
  factory PickerMethod.video(int maxCount) {
    return PickerMethod(
      icon: '🎞',
      name: 'video picker',
      description: 'Only pick video from device.',
      method: (BuildContext context, List<AssetEntity> assets) {
        return AssetPicker.pickAssets(context,
          pickerConfig: AssetPickerConfig(
            maxAssets: maxCount,
            selectedAssets: assets,
            requestType: RequestType.video,
          ),
        );
      },
    );
  }
}