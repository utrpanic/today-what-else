import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
          'videos/$uid/${DateTime.now().microsecondsSinceEpoch}',
        );
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel data) async {
    await _db.collection('videos').add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos({
    required int? lastItemCreatedAt,
  }) {
    final query = _db
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .limit(2);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> likeVideo({
    required String userId,
    required String videoId,
  }) async {
    final query = _db.collection('likes').doc('${videoId}000$userId');
    final likes = await query.get();
    if (!likes.exists) {
      await query.set(
        {
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        },
      );
    }
  }
}

final videosRepo = Provider<VideosRepository>((ref) {
  return VideosRepository();
});
