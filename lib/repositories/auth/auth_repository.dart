import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'base_auth_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = FirebaseFirestore.instance;

  //* For getting realtime updates to the user state.
  @override
  Stream<firebase_auth.User> get user => _firebaseAuth.userChanges();

  // Creating a new user with email and password
  @override
  Future<void> signUpWithEmailAndPassword({
    @required String displayName,
    @required String email,
    @required String password,
  }) async {
    try {
      final userCredentail = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Getting the created user (to get the id of the user)
      final user = userCredentail.user;

      //* Storing the user information in Cloud Firestore
      await _firebaseFirestore.collection('users').doc(user.uid).set({
        'email': email,
        'displayName': displayName,
        'bio': '',
        'profileImageUrl': '',
      });
    } catch (e) {
      throw Exception('SIGNUP ERROR: ${e.message}');
    }
  }

  // Logging in user with email and password
  @override
  Future<void> loginWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('SIGNIN ERROR: ${e.message}');
    }
  }

  // Logging out user
  @override
  Future<void> logOut() async {
    try {
      _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('LOGOUT ERROR: ${e.message}');
    }
  }
}
