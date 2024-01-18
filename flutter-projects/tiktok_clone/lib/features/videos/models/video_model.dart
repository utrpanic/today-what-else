class VideoModel {
  VideoModel({
    this.creatorUid = '',
    required this.title,
    this.description = '',
    this.fileUrl = '',
    this.thumbnailUrl = '',
    this.createdAt = 0,
    this.likes = 0,
    this.comments = 0,
  });

  final String creatorUid;
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final int createdAt;
  final int likes;
  final int comments;
}
