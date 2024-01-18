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
