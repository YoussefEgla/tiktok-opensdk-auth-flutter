import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth_platform_interface.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTiktokOpenSdkAuthPlatform
    with MockPlatformInterfaceMixin
    implements TiktokOpenSdkAuthPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TiktokOpenSdkAuthPlatform initialPlatform = TiktokOpenSdkAuthPlatform.instance;

  test('$MethodChannelTiktokOpenSdkAuth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokOpenSdkAuth>());
  });

  test('getPlatformVersion', () async {
    TiktokOpenSdkAuth tiktokOpenSdkAuthPlugin = TiktokOpenSdkAuth();
    MockTiktokOpenSdkAuthPlatform fakePlatform = MockTiktokOpenSdkAuthPlatform();
    TiktokOpenSdkAuthPlatform.instance = fakePlatform;

    expect(await tiktokOpenSdkAuthPlugin.getPlatformVersion(), '42');
  });
}
