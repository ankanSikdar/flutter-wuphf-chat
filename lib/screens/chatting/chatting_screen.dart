import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:wuphf_chat/models/models.dart';

class ChattingScreenArgs {
  final User user;
  final DocumentReference messagesDbRef;

  ChattingScreenArgs({
    @required this.user,
    this.messagesDbRef,
  });
}

class ChattingScreen extends StatelessWidget {
  static const String routeName = '/chatting-screen';

  static Route route({@required ChattingScreenArgs args}) {
    print('MessageDbRef: ${args.messagesDbRef}');
    print('User: ${args.user.displayName}');
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChattingScreen(),
    );
  }

  const ChattingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
