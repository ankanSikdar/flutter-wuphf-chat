import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/config/configs.dart';

import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository({
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
      // Adding displayName to FirebaseAuth User
      await user.updateDisplayName(displayName);

      //* Storing the user information in Cloud Firestore
      await _firebaseFirestore.collection(Paths.users).doc(user.uid).set({
        'email': email,
        'displayName': displayName,
        'bio': '',
        'profileImageUrl':
            'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg',
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

  // Updating user email
  @override
  Future<void> updateEmail({@required String email}) async {
    try {
      await _firebaseAuth.currentUser.updateEmail(email);
    } catch (e) {
      throw Exception('EMAIL UPDATE ERROR: ${e.message}');
    }
  }

  // Updating user displayName
  @override
  Future<void> updateDisplayName({@required String displayName}) async {
    try {
      await _firebaseAuth.currentUser.updateDisplayName(displayName);
    } catch (e) {
      throw Exception('NAME UPDATE ERROR: ${e.message}');
    }
  }

  // Sending reset password mail
  Future<void> forgotPassword({@required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('PASSWORD RESET ERROR: ${e.message}');
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
