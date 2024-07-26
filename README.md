# Tiktok Open SDK Auth | Flutter

This is a flutter plugin for Tiktok Open SDK Auth. It is a wrapper around Tiktok Open SDK Auth for Android and iOS utilizing platform channels.

For more information about Tiktok Open SDK Auth, please refer to the official documentation: [Tiktok Open SDK Auth](https://developers.tiktok.com/doc/quickstart)

## Getting Started

- create `.env` file in the `example` project
- grap the Client Key from Tiktok developer portal and add it to the `.env` file `TIKTOK_CLIENT_KEY=<YOUR_CLIENT_KEY>`
- add `TIKTOK_REDIRECT_URI` to the `.env` file `TIKTOK_REDIRECT_URI=<YOUR_REDIRECT_URI>` (currently a placeholder the example app does not have a deep link setup; feel free to contribute)
- run the example app

## Usage

```dart
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth.dart';

// Initialize TiktokOpenSdkAuth
final TiktokOpenSdkAuth _tiktokOpenSdkAuth = TiktokOpenSdkAuth();
final bool isInitialized = await _tiktokOpenSdkAuth.init();

// Login with Tiktok
final AuthRequest request = AuthRequest(
    authMethod: AuthMethod.chromeTab // or AuthMethod.tiktokApp. For more information, please refer to the official documentation
    clientKey: 'YOUR_CLIENT_KEY',
    redirectUri: 'YOUR_REDIRECT_URI',
);

final bool isSuccess = await _tiktokOpenSdkAuth.authorize(request);

// Get the response payload
final AuthResponse response = await _tiktokOpenSdkAuth.getAuthResponseFromIntent(redirectUri: 'YOUR_REDIRECT_URI'); // Intent is supplied internally by the plugin
```
