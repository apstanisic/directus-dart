import 'package:directus_core/src/modules/auth/_auth_fields.dart';
import 'package:test/test.dart';

void main() {
  test('Auth fields have default value', () async {
    final fields = AuthFields();
    expect(fields.accessToken, 'directus__access_token');
    expect(fields.refreshToken, 'directus__refresh_token');
    expect(fields.accessTokenTtlInMs, 'directus__access_token_ttl_ms');
    expect(fields.expiresAt, 'directus__access_token_expires_at');
  });

  test('Auth fields add key to names', () async {
    final fields = AuthFields('test');
    expect(fields.accessToken, 'directus__access_token__test');
    expect(fields.refreshToken, 'directus__refresh_token__test');
    expect(fields.accessTokenTtlInMs, 'directus__access_token_ttl_ms__test');
    expect(fields.expiresAt, 'directus__access_token_expires_at__test');
  });
}
