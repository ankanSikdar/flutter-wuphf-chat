import 'package:wuphf_chat/models/models.dart';

abstract class BaseGroupRepository {
  Stream<List<Group>> getGroupsList();
}
