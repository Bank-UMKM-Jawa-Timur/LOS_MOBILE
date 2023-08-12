import 'package:flutter/foundation.dart';

const deviceAndroid = TargetPlatform.android;
const deviceIos = TargetPlatform.iOS;

cekDevicePlatform(isAndroid, isIos) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    isAndroid;
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    isIos;
  }
}
