import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:wuphf_chat/repositories/storage/base_storage_repository.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({
    FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Future<String> uploadImage(
      {@required String url, @required File file}) async {
    try {
      final downloadUrl = await _firebaseStorage
          .ref(url)
          .putFile(file)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return downloadUrl;
    } catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<String> uploadProfileImage(
      {@required String userId, @required File file}) async {
    final url = 'images/profilePictures/$userId.jpg';

    try {
      final downloadUrl = await uploadImage(url: url, file: file);

      return downloadUrl;
    } catch (e) {
      throw Exception('PROFILE IMAGE UPLOAD ERROR: ${e.message}');
    }
  }
}
