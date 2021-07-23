import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:wuphf_chat/repositories/presence/base_presence_repository.dart';

class PresenceRepository extends BasePresenceRepository {
  final DatabaseReference _databaseReference = FirebaseDatabase(
          databaseURL: 'https://wuphf-chat-flutter-presence.firebaseio.com/')
      .reference();

  final firebase_auth.FirebaseAuth _firebaseAuth;

  PresenceRepository() : _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  //* Old Solution
  // updateUserPresence() async {
  //   final uid = _firebaseAuth.currentUser.uid;

  //   Map<String, dynamic> presenceStatusTrue = {
  //     'presence': true,
  //   };
  //   await _databaseReference
  //       .child(uid)
  //       .update(presenceStatusTrue)
  //       .whenComplete(() => print('Updated your status'))
  //       .catchError((e) => print('Error: $e'));

  //   Map<String, dynamic> presenceStatusFalse = {
  //     'presence': false,
  //   };

  //   _databaseReference.child(uid).onDisconnect().update(presenceStatusFalse);
  // }

  //* Solution From Firebase Docs
  @override
  updateUserPresence() async {
    final uid = _firebaseAuth.currentUser.uid;

    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
    };

    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
    };

    // Create a reference to the special '.info/connected' path in
    // Realtime Database. This path returns `true` when connected
    // and `false` when disconnected.
    _databaseReference.child('.info/connected').onValue.listen((event) {
      // If we're not currently connected, don't do anything.
      if (event.snapshot.value == false) {
        return;
      }

      // If we are currently connected, then use the 'onDisconnect()'
      // method to add a set which will only trigger once this
      // client has disconnected by closing the app,
      // losing internet, or any other means.
      _databaseReference.child(uid).onDisconnect().set(presenceStatusFalse).then(
          // The promise returned from .onDisconnect().set() will
          // resolve as soon as the server acknowledges the onDisconnect()
          // request, NOT once we've actually disconnected:
          // https://firebase.google.com/docs/reference/js/firebase.database.OnDisconnect

          // We can now safely set ourselves as 'online' knowing that the
          // server will mark us as offline once we lose connection.
          (value) => _databaseReference.child(uid).set(presenceStatusTrue));
    });
  }
}
