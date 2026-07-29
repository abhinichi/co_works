/// Domain entity representing an authenticated session.
///
/// Entities are plain Dart objects that model business concepts. They live in
/// the domain layer, contain no JSON/serialization logic, and are what use
/// cases and the UI work with. The data layer converts DTOs/models into these.
class AuthToken {
  const AuthToken({required this.accessToken, this.refreshToken});

  final String accessToken;
  final String? refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthToken &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken;

  @override
  int get hashCode => Object.hash(accessToken, refreshToken);
}
