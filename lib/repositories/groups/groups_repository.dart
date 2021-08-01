import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wuphf_chat/models/group_model.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/groups/base_groups_repository.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

class GroupsRepository extends BaseGroupRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
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
          _getUserGroupsIds(), _getAllGroups(), (groupIdsList, groupsList) {
        final userGroups = groupIdsList
            .map((groupId) =>
                groupsList.firstWhere((element) => element.groupId == groupId))
            .toList();

        mergeSort(userGroups, compare: (a, b) {
          if (a.lastMessage.sentAt.isAfter(b.lastMessage.sentAt)) {
            return -1;
          } else {
            return 1;
          }
        });

        return userGroups;
      });
    } catch (e) {
      throw ('GET GROUP LIST ERROR: ${e.message}');
    }
  }

  @override
  Future<String> createGroup({
    @required List<String> participants,
    @required String groupName,
    @required String groupImageUrl,
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

  @override
  Future<void> sendMessage(
      {@required String groupId, @required String text, File image}) async {
    try {
      String imageUrl = '';
      if (image != null) {
        imageUrl = await _storageRepository.uploadMessageImage(file: image);
      }

      final messageDocRef = await _firebaseFirestore
          .collection('groupsDb')
          .doc(groupId)
          .collection('groupMessages')
          .add({
        'imageUrl': imageUrl,
        'text': text,
        'sentAt': FieldValue.serverTimestamp(),
        'sentBy': _firebaseAuth.currentUser.uid,
      });

      final lastMessageDocSnap = await messageDocRef.get();
      final lastMessage = Message.fromDocument(lastMessageDocSnap);

      await _firebaseFirestore
          .collection('groupsDb')
          .doc(groupId)
          .update(lastMessage.toDocument());
    } catch (e) {
      throw ('SEND MESSAGE ERROR: ${e.message}');
    }
  }
}
