import 'package:twitter_login/schemes/request_header.dart';
import 'package:twitter_login/src/utils.dart';

/// The access token for Twitter API.
class AccessToken {
  /// The access token for using the Twitter APIs
  final String _authToken;

  /// The access token secret for using the Twitter APIs
  final String _authTokenSecret;

  String get authToken => _authToken;
  String get authTokenSecret => _authTokenSecret;

  AccessToken._(Map<String, dynamic> params)
      : this._authToken = params['oauth_token'],
        this._authTokenSecret = params['oauth_token_secret'];

  static Future<AccessToken> getAccessToken(
    String apiKey,
    String apiSecretKey,
    Map<String, String> queries,
  ) async {
    final authParams = RequestHeader.accessTokenHeaderParams(
      apiKey,
      queries['oauth_token'],
      queries['oauth_verifier'],
    );
    final params = await send(
      ACCESS_TOKEN_URI,
      authParams,
      apiKey,
      apiSecretKey,
    );
    final accessToken = AccessToken._(params);
    return accessToken;
  }
}
