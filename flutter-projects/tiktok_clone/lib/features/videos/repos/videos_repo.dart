import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
          'videos/$uid/${DateTime.now().microsecondsSinceEpoch}',
        );
    return fileRef.putFile(video);
  }

  // create a video document
}

final videosRepo = Provider<VideosRepository>((ref) {
  return VideosRepository();
});
