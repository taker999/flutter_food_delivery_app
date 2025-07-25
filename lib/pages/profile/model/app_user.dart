class AppUser {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }

}
