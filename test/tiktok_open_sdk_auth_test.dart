import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_open_sdk_auth/auth_models.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth_platform_interface.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTiktokOpenSdkAuthPlatform
    with MockPlatformInterfaceMixin
    implements TiktokOpenSdkAuthPlatform {
  @override
  Future<bool> init() {
    return Future.value(true);
  }

  @override
  Future<bool> authorize(AuthRequest request) {
    return Future.value(true);
  }

  @override
  Future<AuthResponse?> getAuthResponseFromIntent(String redirectUri) {
    return Future.value(null);
  }
}

void main() {
  final TiktokOpenSdkAuthPlatform initialPlatform =
      TiktokOpenSdkAuthPlatform.instance;

  test('$MethodChannelTiktokOpenSdkAuth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokOpenSdkAuth>());
  });

  test('Can be set to a different platform', () {
    final MockTiktokOpenSdkAuthPlatform mock = MockTiktokOpenSdkAuthPlatform();
    TiktokOpenSdkAuthPlatform.instance = mock;
    expect(TiktokOpenSdkAuthPlatform.instance, mock);
  });

  test('init() should return true', () async {
    final MockTiktokOpenSdkAuthPlatform mock = MockTiktokOpenSdkAuthPlatform();
    TiktokOpenSdkAuthPlatform.instance = mock;
    expect(await TiktokOpenSdkAuth().init(), true);
  });

  test('authorize() should return true', () async {
    final MockTiktokOpenSdkAuthPlatform mock = MockTiktokOpenSdkAuthPlatform();
    TiktokOpenSdkAuthPlatform.instance = mock;
    final AuthRequest request = AuthRequest(
      authMethod: AuthMethod.chromeTab,
      clientKey: 'clientKey',
      scope: 'scope',
      redirectUri: 'redirectUri',
    );
    expect(await TiktokOpenSdkAuth().authorize(request), true);
  });

  test('getAuthResponseFromIntent() should return null', () async {
    final MockTiktokOpenSdkAuthPlatform mock = MockTiktokOpenSdkAuthPlatform();
    TiktokOpenSdkAuthPlatform.instance = mock;
    expect(await TiktokOpenSdkAuth().getAuthResponseFromIntent('redirectUri'),
        null);
  });

  tearDown(() {
    TiktokOpenSdkAuthPlatform.instance = initialPlatform;
  });
}
