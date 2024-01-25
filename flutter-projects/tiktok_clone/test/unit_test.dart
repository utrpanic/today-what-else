// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

void main() {
  group('VideoModel Test', () {
    test('Constructor', () {
      final video = VideoModel(
        id: 'id',
        creatorUid: 'creatorUid',
        creatorName: 'creatorName',
        title: 'title',
        description: 'description',
        fileUrl: 'fileUrl',
        thumbnailUrl: 'thumbnailUrl',
        createdAt: 1,
        likes: 1,
        comments: 1,
      );
      expect(video.id, 'id');
    });

    test('.fromJson Constructor', () {
      final video = VideoModel.fromJson(
        id: 'videoId',
        json: {
          'id': 'id',
          'creatorUid': 'creatorUid',
          'creatorName': 'creatorName',
          'title': 'title',
          'description': 'description',
          'fileUrl': 'fileUrl',
          'thumbnailUrl': 'thumbnailUrl',
          'createdAt': 1,
          'likes': 1,
          'comments': 1,
        },
      );
      expect(video.title, 'title');
      expect(video.comments, 1);
    });

    test('.toJson Method', () {
      final video = VideoModel(
        id: 'id',
        creatorUid: 'creatorUid',
        creatorName: 'creatorName',
        title: 'title',
        description: 'description',
        fileUrl: 'fileUrl',
        thumbnailUrl: 'thumbnailUrl',
        createdAt: 1,
        likes: 1,
        comments: 1,
      );
      final json = video.toJson();
      expect(json['id'], 'id');
      expect(json['creatorUid'], 'creatorUid');
      expect(json['creatorName'], 'creatorName');
      expect(json['title'], 'title');
      expect(json['description'], 'description');
      expect(json['fileUrl'], 'fileUrl');
      expect(json['thumbnailUrl'], 'thumbnailUrl');
      expect(json['createdAt'], 1);
      expect(json['likes'], 1);
      expect(json['comments'], 1);
    });
  });
}
