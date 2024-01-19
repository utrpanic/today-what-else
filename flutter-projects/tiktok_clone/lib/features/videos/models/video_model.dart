class VideoModel {
  VideoModel({
    required this.creatorUid,
    required this.creatorName,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.likes,
    required this.comments,
  });

  VideoModel.fromJson(Map<String, dynamic> json)
      : this(
          creatorUid: json['creatorUid'] as String,
          creatorName: json['creatorName'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          fileUrl: json['fileUrl'] as String,
          thumbnailUrl: json['thumbnailUrl'] as String,
          createdAt: json['createdAt'] as int,
          likes: json['likes'] as int,
          comments: json['comments'] as int,
        );

  final String creatorUid;
  final String creatorName;
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final int createdAt;
  final int likes;
  final int comments;

  Map<String, dynamic> toJson() {
    return {
      'creatorUid': creatorUid,
      'creatorName': creatorName,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt,
      'likes': likes,
      'comments': comments,
    };
  }
}
