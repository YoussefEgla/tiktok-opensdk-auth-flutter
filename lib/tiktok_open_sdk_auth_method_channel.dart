import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_open_sdk_auth/auth_models.dart';

import 'tiktok_open_sdk_auth_platform_interface.dart';

/// An implementation of [TiktokOpenSdkAuthPlatform] that uses method channels.
class MethodChannelTiktokOpenSdkAuth extends TiktokOpenSdkAuthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiktok_open_sdk_auth');

  @override
  Future<bool> init() async {
    final result = await methodChannel.invokeMethod<bool>('init');
    return result ?? false;
  }

  @override
  Future<bool> authorize(AuthRequest request) async {
    final result =
        await methodChannel.invokeMethod<bool>('authorize', request.toMap());
    return result ?? false;
  }

  @override
  Future<AuthResponse?> getAuthResponseFromIntent(String redirectUri) async {
    final result =
        await methodChannel.invokeMethod<Map>('getAuthResponseFromIntent', {
      'redirectUri': redirectUri,
    });

    return result == null ? null : AuthResponse.fromMap(result);
  }
}
