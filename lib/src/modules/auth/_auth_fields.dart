/// Field names that are used to store data
///
/// If user wants more then one instance at the same time
/// user should pass a key so data is stored in different place.
/// There is a double underscore after directus to act as a "namespace",
/// and there is a double underscore before key if key exist for the same reason.
class AuthFields {
  final String? _key;
  AuthFields([String? key]) : _key = key != null ? '__$key' : '';

  String get accessToken => 'directus__access_token$_key';
  String get refreshToken => 'directus__refresh_token$_key';
  String get accessTokenTtlInMs => 'directus__access_token_ttl_ms$_key';
  String get expiresAt => 'directus__access_token_expires_at$_key';
}
