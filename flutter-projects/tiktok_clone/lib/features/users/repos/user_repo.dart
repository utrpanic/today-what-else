import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }

  Future<UserProfileModel?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final json = doc.data();
    if (json == null) return null;
    return UserProfileModel.fromJson(id: uid, json: json);
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child('avatars/$fileName');
    await fileRef.putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers() async {
    return _db.collection('users').get();
  }
}

final userRepo = Provider((ref) => UserRepository());
