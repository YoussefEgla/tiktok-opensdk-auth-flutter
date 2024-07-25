
import 'tiktok_open_sdk_auth_platform_interface.dart';

class TiktokOpenSdkAuth {
  Future<String?> getPlatformVersion() {
    return TiktokOpenSdkAuthPlatform.instance.getPlatformVersion();
  }
}
