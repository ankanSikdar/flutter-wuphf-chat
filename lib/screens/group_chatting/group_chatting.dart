import 'package:flutter/material.dart';

class GroupChattingScreenArgs {
  final String groupId;

  GroupChattingScreenArgs({
    @required this.groupId,
  });
}

class GroupChattingScreen extends StatelessWidget {
  static const String routeName = '/group-chatting-screen';

  static Route route({@required GroupChattingScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => GroupChattingScreen(groupId: args.groupId),
    );
  }

  final String groupId;

  const GroupChattingScreen({Key key, @required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(groupId)),
    );
  }
}
