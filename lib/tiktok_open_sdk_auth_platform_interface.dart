import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tiktok_open_sdk_auth/auth_models.dart';
import 'tiktok_open_sdk_auth_method_channel.dart';

abstract class TiktokOpenSdkAuthPlatform extends PlatformInterface {
  /// Constructs a TiktokOpenSdkAuthPlatform.
  TiktokOpenSdkAuthPlatform() : super(token: _token);

  static final Object _token = Object();

  static TiktokOpenSdkAuthPlatform _instance = MethodChannelTiktokOpenSdkAuth();

  /// The default instance of [TiktokOpenSdkAuthPlatform] to use.
  ///
  /// Defaults to [MethodChannelTiktokOpenSdkAuth].
  static TiktokOpenSdkAuthPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TiktokOpenSdkAuthPlatform] when
  /// they register themselves.
  static set instance(TiktokOpenSdkAuthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<bool> authorize(AuthRequest request) {
    throw UnimplementedError('authorize() has not been implemented.');
  }

  Future<AuthResponse?> getAuthResponseFromIntent(String redirectUri) {
    throw UnimplementedError(
        'getAuthResponseFromIntent() has not been implemented.');
  }
}
