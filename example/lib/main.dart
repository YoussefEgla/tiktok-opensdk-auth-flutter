import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tiktok_open_sdk_auth/auth_models.dart';
import 'package:tiktok_open_sdk_auth/tiktok_open_sdk_auth.dart';

const String tiktokClientIdName = 'TIKTOK_CLIENT_ID';
const String tiktokRedirectUriName = 'TIKTOK_REDIRECT_URI';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  if (!dotenv.isEveryDefined([tiktokClientIdName, tiktokRedirectUriName])) {
    throw Exception(
        'Please provide $tiktokClientIdName and $tiktokRedirectUriName in .env file');
  }

  runApp(const MyApp());

  return;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _tiktokInitialized = false;
  final _tiktokOpenSdkAuthPlugin = TiktokOpenSdkAuth();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initTiktokAuth() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final bool result = await _tiktokOpenSdkAuthPlugin.init();
      setState(() {
        _tiktokInitialized = result;
      });
    } on PlatformException {
      _tiktokInitialized = false;
    }

    if (!mounted) return;
  }

  Future<void> loginWithTiktok() async {
    final AuthRequest request = AuthRequest(
        authMethod: AuthMethod.chromeTab,
        clientKey: dotenv.env[tiktokClientIdName]!,
        redirectUri: dotenv.env[tiktokRedirectUriName]!);

    await _tiktokOpenSdkAuthPlugin.authorize(request);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tiktok Open SDK Auth Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Tiktok Auth Client Initialized: $_tiktokInitialized\n'),
              ElevatedButton(
                onPressed: () {
                  initTiktokAuth();
                },
                child: const Text('Initialize Tiktok Client'),
              ),
              ElevatedButton(
                onPressed: () {
                  loginWithTiktok();
                },
                child: const Text('Login with Tiktok'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
