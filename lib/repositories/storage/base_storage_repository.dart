import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class BaseStorageRepository {
  Future<String> uploadImage({@required String url, @required File file});

  Future<String> uploadProfileImage(
      {@required String userId, @required File file});

  Future<String> uploadMessageImage({@required File file});

  Future<String> uploadGroupImage({@required File file});
}
