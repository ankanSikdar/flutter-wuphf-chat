import 'package:flutter/foundation.dart';

abstract class BasePresenceRepository {
  updateUserPresence({@required String uid});
  onUserLoggedOut({@required String uid});

  onAppInBackground({@required String uid});
  onAppResumed({@required String uid});
}
