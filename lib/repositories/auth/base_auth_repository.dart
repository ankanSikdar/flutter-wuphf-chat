import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';

//* For abstracting the underlying implementation of how a user is authenticated as well as how a user is fetched.
abstract class BaseAuthRepository {
  Stream<firebase_auth.User> get user;

  Future<void> signUpWithEmailAndPassword({
    @required String displayName,
    @required String email,
    @required String password,
  });

  Future<void> loginWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  Future<void> updateEmail({@required String email});

  Future<void> updateDisplayName({@required String displayName});

  Future<void> forgotPassword({@required String email});

  Future<void> logOut();
}
