import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';

abstract class BaseGroupRepository {
  Stream<List<Group>> getGroupsList();

  Future<String> createGroup({
    @required List<String> participants,
    @required String groupName,
    @required String groupImageUrl,
  });

  Future<void> sendMessage({
    @required String groupId,
    @required String text,
    File image,
  });

  Stream<List<Message>> getGroupMessagesList({@required String groupId});

  Stream<Group> getGroupDetailsStream({@required String groupId});
}
