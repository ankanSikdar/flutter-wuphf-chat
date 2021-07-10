import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wuphf_chat/config/configs.dart';

import 'package:wuphf_chat/models/user_model.dart';
import 'package:wuphf_chat/repositories/user/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<List<User>> getAllUsers() async {
    final usersSnap = await _firebaseFirestore.collection(Paths.users).get();
    final List<User> usersList =
        usersSnap.docs.map((doc) => User.fromDocument(doc)).toList();
    return usersList;
  }

  @override
  Future<User> getUserWithId({String userId}) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser({User user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toDocument());
  }
}
