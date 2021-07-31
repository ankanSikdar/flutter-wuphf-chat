import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:rxdart/rxdart.dart';
import 'package:wuphf_chat/models/group_model.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/groups/base_groups_repository.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

class GroupsRepository extends BaseGroupRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

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
      throw ('GET GROUP LIST ERROR: ${e.message}');
    }
  }

  @override
  Future<String> createGroup({
    List<String> participants,
    String groupName,
    String groupImageUrl,
  }) async {
    participants.add(_firebaseAuth.currentUser.uid);
    try {
      final createdGroup =
          await _firebaseFirestore.collection('groupsDb').add({});

      await _firebaseFirestore.collection('groupsDb').doc(createdGroup.id).set({
        'groupId': createdGroup.id,
        'groupName': groupName,
        'groupImage': groupImageUrl,
        'participants': participants,
        'id': 'dummyMessageId',
        'imageUrl': '',
        'sentAt': FieldValue.serverTimestamp(),
        'sentBy': _firebaseAuth.currentUser.uid,
        'text': 'Group was created...'
      });

      participants.forEach((userId) async {
        await _firebaseFirestore
            .collection('groups')
            .doc(userId)
            .collection('userGroups')
            .doc(createdGroup.id)
            .set({});
      });

      return createdGroup.id;
    } catch (e) {
      throw ('CREATE GROUP ERROR: ${e.message}');
    }
  }
}
