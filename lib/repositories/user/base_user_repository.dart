import 'package:wuphf_chat/models/models.dart';
import 'package:flutter/foundation.dart';

abstract class BaseUserRepository {
  Future<List<User>> getAllUsers();
  Future<User> getUserWithId({@required String userId});
  Future<void> updateUser({@required User user});
}
