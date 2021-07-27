import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:rxdart/rxdart.dart';
import 'package:wuphf_chat/models/group_model.dart';
import 'package:wuphf_chat/repositories/groups/base_groups_repository.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

class GroupsRepository extends BaseGroupRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final UserRepository _userRepository = UserRepository();
  final StorageRepository _storageRepository = StorageRepository();

  GroupsRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<String>> _getUserGroupsIds() {
    return _firebaseFirestore
        .collection('groups')
        .doc(_firebaseAuth.currentUser.uid)
        .collection('userGroups')
        .snapshots()
        .map((event) => event.docs.map((doc) => doc.id).toList());
  }

  Stream<List<Group>> _getAllGroups() {
    return _firebaseFirestore.collection('groupsDb').snapshots().map(
        (event) => event.docs.map((doc) => Group.fromMap(doc.data())).toList());
  }

  @override
  Stream<List<Group>> getGroupsList() {
    try {
      return Rx.combineLatest2<List<String>, List<Group>, List<Group>>(
          _getUserGroupsIds(),
          _getAllGroups(),
          (groupIdsList, groupsList) => groupIdsList.map((groupId) {
                print('GroupId: $groupId');

                final group = groupsList
                    .firstWhere((element) => element.groupId == groupId);

                print('GroupId: ${group.groupName}');
                print('GroupId: ${group.lastMessage}');
                print('GroupId: ${group.participants}');

                return group;
              }).toList());
    } catch (e) {
      print('Check ERROR: ${e.message}');
    }
  }
}
