import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tiktok_open_sdk_auth_platform_interface.dart';

/// An implementation of [TiktokOpenSdkAuthPlatform] that uses method channels.
class MethodChannelTiktokOpenSdkAuth extends TiktokOpenSdkAuthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiktok_open_sdk_auth');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
