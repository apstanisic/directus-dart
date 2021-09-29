class DirectusUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? location;
  String? title;
  String? description;
  List<String>? tags;

  /// Either [String] or [DirectusFile].
  Object? avatar;
  String? language;
  String? theme;
  String? status;

  /// Role is either [String] or [DirectusRole].
  Object? role;

  /// Additional fields
  Map<String, Object?>? additionally;

  DirectusUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.location,
    this.title,
    this.description,
    this.tags,
    this.avatar,
    this.language,
    this.theme,
    this.status,
    this.role,
    this.additionally,
  });

  /// Used for code generation
  factory DirectusUser.fromJson(Map<String, Object?> json) {
    final data = json;
    return DirectusUser(
      id: data['id'] as String?,
      firstName: data['first_name'] as String?,
      lastName: data['last_name'] as String?,
      email: data['email'] as String?,
      password: data['password'] as String?,
      location: data['location'] as String?,
      title: data['title'] as String?,
      description: data['description'] as String?,
      tags: (data['tags'] as List<Object?>?)?.map((e) => e as String).toList(),
      avatar: data['avatar'],
      language: data['language'] as String?,
      theme: data['theme'] as String?,
      status: data['status'] as String?,
      role: data['role'],
      additionally: data
        ..remove('id')
        ..remove('first_name')
        ..remove('last_name')
        ..remove('email')
        ..remove('password')
        ..remove('location')
        ..remove('title')
        ..remove('description')
        ..remove('tags')
        ..remove('avatar')
        ..remove('language')
        ..remove('theme')
        ..remove('status')
        ..remove('role'),
    );
  }

  /// Used for code generation
  Map<String, Object?> toJson() {
    final val = <String, Object?>{};
    void writeNotNull(String key, Object? value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('id', id);
    writeNotNull('first_name', firstName);
    writeNotNull('last_name', lastName);
    writeNotNull('email', email);
    writeNotNull('password', password);
    writeNotNull('location', location);
    writeNotNull('title', title);
    writeNotNull('description', description);
    writeNotNull('tags', tags);
    writeNotNull('avatar', avatar);
    writeNotNull('language', language);
    writeNotNull('theme', theme);
    writeNotNull('status', status);
    writeNotNull('role', role);
    return val;
  }

  @override
  String toString() => 'DirectusUser('
      'id: $id, '
      'firstName: $firstName, '
      'lastName: $lastName, '
      'email: $email, '
      'password: $password, '
      'location: $location, '
      'title: $title, '
      'description: $description, '
      'tags: $tags, '
      'avatar: $avatar, '
      'language: $language, '
      'theme: $theme, '
      'status: $status, '
      'role: $role, '
      'additionally: $additionally,)';
}
