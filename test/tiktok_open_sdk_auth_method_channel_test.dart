import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTiktokOpenSdkAuth platform = MethodChannelTiktokOpenSdkAuth();
  const MethodChannel channel = MethodChannel('tiktok_open_sdk_auth');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.init(), true);
  });

  test('getAuthResponseFromIntent', () async {
    expect(await platform.getAuthResponseFromIntent('redirectUri'), null);
  });
}
