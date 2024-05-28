import 'package:device_info_plus/device_info_plus.dart';
import '../login.dart';
import '../../main.dart';
import 'dart:io';

class DeviceIdCheck {
  static Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // Unique ID on Android
      // Unique ID on iOS
    } else {
      deviceId = 'Unknown platform';
    }

    return deviceId;
  }
}