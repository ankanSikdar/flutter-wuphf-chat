import 'package:flutter/foundation.dart';

abstract class BasePresenceRepository {
  updateUserPresence();
  onUserLoggedOut({@required String uid});

  onAppInBackground({@required String uid});
  onAppResumed({@required String uid});
}
