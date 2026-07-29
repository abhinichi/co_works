/// Domain entity for a user shown in the users list.
///
/// Named `AppUser` to keep it distinct from auth concepts. Like all entities it
/// is framework-free and serialization-free.
class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatarUrl;

  String get fullName => '$firstName $lastName';
}
