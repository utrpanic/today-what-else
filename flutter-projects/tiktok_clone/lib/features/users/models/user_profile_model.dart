class UserProfileModel {
  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.hasAvatar,
  });

  UserProfileModel.empty()
      : this(
          uid: '',
          email: '',
          name: '',
          bio: '',
          link: '',
          hasAvatar: false,
        );

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : this(
          uid: json['uid'] as String,
          email: json['email'] as String,
          name: json['name'] as String,
          bio: json['bio'] as String,
          link: json['link'] as String,
          hasAvatar: json['hasAvatar'] as bool,
        );

  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final bool hasAvatar;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'link': link,
      'hasAvatar': hasAvatar,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
