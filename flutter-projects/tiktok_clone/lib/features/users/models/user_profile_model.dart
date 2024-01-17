class UserProfileModel {
  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
  });

  UserProfileModel.empty()
      : this(
          uid: '',
          email: '',
          name: '',
          bio: '',
          link: '',
        );

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : this(
          uid: json['uid'] as String,
          email: json['email'] as String,
          name: json['name'] as String,
          bio: json['bio'] as String,
          link: json['link'] as String,
        );

  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;

  Map<String, String> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'link': link,
    };
  }
}
