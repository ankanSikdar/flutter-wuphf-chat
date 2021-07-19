import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/config/configs.dart';

import 'package:wuphf_chat/models/user_model.dart';
import 'package:wuphf_chat/repositories/user/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<User>> getAllUsers() {
    try {
      return _firebaseFirestore
          .collection(Paths.users)
          .orderBy('displayName')
          .snapshots()
          .map((snapShot) =>
              snapShot.docs.map((doc) => User.fromDocument(doc)).toList());
    } catch (e) {
      throw Exception('GET USERS ERROR: ${e.message}');
    }
  }

  @override
  Future<User> getUserWithId({@required String userId}) async {
    try {
      final doc =
          await _firebaseFirestore.collection(Paths.users).doc(userId).get();
      return doc.exists ? User.fromDocument(doc) : User.empty;
    } catch (e) {
      throw Exception('GET USER ERROR: ${e.message}');
    }
  }

  @override
  Future<void> updateUser({@required User user}) async {
    try {
      await _firebaseFirestore
          .collection(Paths.users)
          .doc(user.id)
          .update(user.toDocument());
    } catch (e) {
      throw Exception('UPDATE USER ERROR: ${e.message}');
    }
  }
}
