import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:injectable/injectable.dart';
import 'package:nonce/nonce.dart';
import 'package:pot_g/app/modules/auth/data/data_sources/remote/oauth_api.dart';
import 'package:pot_g/app/modules/auth/data/models/token_request_with_code_model.dart';
import 'package:pot_g/app/modules/auth/domain/entity/token_entity.dart';
import 'package:pot_g/app/modules/auth/domain/exceptions/invalid_authorization_code_exception.dart';
import 'package:pot_g/app/modules/auth/domain/exceptions/invalid_authorization_state_exception.dart';
import 'package:pot_g/app/modules/auth/domain/repositories/oauth_repository.dart';
import 'package:pot_g/app/values/config.dart';

@Injectable(as: OAuthRepository)
class WebAuth2OauthRepository implements OAuthRepository {
  final String clientId = Config.idpClientId;
  final OAuthApi _api;
  bool recentLogout = false;

  WebAuth2OauthRepository(this._api);

  @override
  Future<TokenEntity> getToken() async {
    final state = Nonce.secure().toString();
    final codeVerifier = Nonce.secure().toString();
    final codeChallenge = base64Url
        .encode(sha256.convert(utf8.encode(codeVerifier)).bytes)
        .replaceAll('=', '');

    final scopes = ['profile', 'email', 'offline_access'];
    final prompt = recentLogout ? 'login' : 'consent';
    final authorizeUri = Uri.parse('https://idp.gistory.me/authorize').replace(
      queryParameters: {
        'client_id': clientId,
        'redirect_uri': Config.idpRedirectUri,
        'scope': scopes.join(' '),
        'response_type': 'code',
        'state': state,
        'code_challenge': codeChallenge,
        'code_challenge_method': 'S256',
        'prompt': prompt,
      },
    );

    final result = await FlutterWebAuth2.authenticate(
      url: authorizeUri.toString(),
      callbackUrlScheme: Config.idpRedirectScheme,
    );
    final uri = Uri.parse(result);

    final receivedState = uri.queryParameters['state'];
    if (receivedState != state) throw InvalidAuthorizationStateException();

    final authCode = uri.queryParameters['code'];
    if (authCode == null) throw InvalidAuthorizationCodeException();

    final res = await _api.getTokenFromCode(
      TokenRequestWithCodeModel(
        code: authCode,
        codeVerifier: codeVerifier,
        clientId: clientId,
      ),
    );

    setRecentLogout(false);

    return TokenEntity(
      accessToken: res.accessToken,
      refreshToken: res.refreshToken,
    );
  }

  @override
  Future<void> setRecentLogout([bool value = true]) async {
    recentLogout = value;
  }
}
