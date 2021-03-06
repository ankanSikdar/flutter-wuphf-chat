import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/repositories/presence/base_presence_repository.dart';

class PresenceRepository extends BasePresenceRepository {
  final DatabaseReference _databaseReference = FirebaseDatabase(
          databaseURL: 'https://wuphf-chat-flutter-presence.firebaseio.com/')
      .reference();

  StreamSubscription<Event> _rtdbConnection;

  PresenceRepository();

  @override
  updateUserPresence({@required String uid}) async {
    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
    };

    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
    };

    // Create a reference to the special '.info/connected' path in
    // Realtime Database. This path returns `true` when connected
    // and `false` when disconnected.

    // On Android, the Realtime Database disconnects from the backend after
    // 60 seconds of inactivity. Inactivity means no open listeners or pending
    // operations. To keep the connection open, so we add a value event listener
    // to a path besides .info/connected.
    _databaseReference
        .child('${DateTime.now().millisecondsSinceEpoch}')
        .keepSynced(true);

    await _rtdbConnection?.cancel();

    _rtdbConnection =
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

  @override
  onAppInBackground({@required String uid}) async {
    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
    };

    await _databaseReference.child(uid).update(presenceStatusFalse);
  }

  @override
  onAppResumed({@required String uid}) async {
    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
    };

    await _databaseReference.child(uid).update(presenceStatusTrue);
  }

  @override
  onUserLoggedOut({@required String uid}) async {
    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
    };

    await _databaseReference.child(uid).update(presenceStatusFalse);
    await _rtdbConnection?.cancel();
  }
}
