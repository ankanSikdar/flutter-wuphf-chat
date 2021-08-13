import 'package:wuphf_chat/models/models.dart';
import 'package:flutter/foundation.dart';

abstract class BaseUserRepository {
  Stream<List<User>> getAllUsers();
  Future<User> getUserWithId({@required String userId});
  Stream<User> getUserStream({@required String userId});
  Future<void> updateUser({@required User user});
  Future<void> updateUserToken(
      {@required String userId, @required String token});
}
