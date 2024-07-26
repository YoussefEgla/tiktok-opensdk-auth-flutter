enum AuthMethod {
  chromeTab,
  tiktokApp,
}

class AuthRequest {
  final AuthMethod authMethod;
  final String clientKey;
  final String redirectUri;
  String? scope;

  AuthRequest({
    required this.authMethod,
    required this.clientKey,
    required this.redirectUri,
    this.scope,
  }) {
    scope ??= 'user.info.basic';
  }

  Map<String, dynamic> toMap() {
    return {
      'authMethod': authMethod.index,
      'clientKey': clientKey,
      'scope': scope,
      'redirectUri': redirectUri
    };
  }
}

class AuthResponse {
  final int type;
  final int errorCode;
  final String? errorMsg;
  final String authCode;
  final String? state;
  final String grantedPermissions;
  final String? authError;
  final String? authErrorDescription;

  AuthResponse({
    required this.type,
    required this.errorCode,
    this.errorMsg,
    required this.authCode,
    this.state,
    required this.grantedPermissions,
    this.authError,
    this.authErrorDescription,
  });

  factory AuthResponse.fromMap(Map map) {
    return AuthResponse(
      type: map['type'],
      errorCode: map['errorCode'],
      errorMsg: map['errorMsg'],
      authCode: map['authCode'],
      state: map['state'],
      grantedPermissions: map['grantedPermissions'],
      authError: map['authError'],
      authErrorDescription: map['authErrorDescription'],
    );
  }
}
