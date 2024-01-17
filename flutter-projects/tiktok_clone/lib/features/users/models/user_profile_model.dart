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
