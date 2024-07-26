import 'package:tiktok_open_sdk_auth/auth_models.dart';
import 'tiktok_open_sdk_auth_platform_interface.dart';

class TiktokOpenSdkAuth {
  Future<bool> init() {
    return TiktokOpenSdkAuthPlatform.instance.init();
  }

  Future<bool> authorize(AuthRequest request) {
    return TiktokOpenSdkAuthPlatform.instance.authorize(request);
  }

  Future<AuthResponse?> getAuthResponseFromIntent(String redirectUri) {
    return TiktokOpenSdkAuthPlatform.instance
        .getAuthResponseFromIntent(redirectUri);
  }
}
