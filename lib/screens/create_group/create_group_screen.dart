import 'package:flutter/material.dart';
import 'package:wuphf_chat/models/models.dart';

class CreateGroupScreenArgs {
  final List<User> participants;

  CreateGroupScreenArgs({@required this.participants});
}

class CreateGroupScreen extends StatefulWidget {
  static const String routeName = '/create-group-screen';

  static Route route({@required CreateGroupScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CreateGroupScreen(participants: args.participants),
    );
  }

  final List<User> participants;

  const CreateGroupScreen({Key key, @required this.participants})
      : super(key: key);

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final user = widget.participants[index];
          return ListTile(
            title: Text(user.displayName),
            subtitle: Text(user.id),
          );
        },
        itemCount: widget.participants.length,
      ),
    );
  }
}
