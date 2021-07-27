import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

class GroupsScreen extends StatefulWidget {
  static const String routeName = '/groups-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => GroupsScreen(),
    );
  }

  const GroupsScreen({Key key}) : super(key: key);

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: context.read<GroupsRepository>().getGroupsList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data as List<Group>;
            return ListView.separated(
              itemBuilder: (context, index) {
                final group = list[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      group.groupImage,
                    ),
                  ),
                  title: Text(group.groupName),
                  subtitle: Text(group.lastMessage.text),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: list.length,
            );
          }
          return Center(child: LoadingIndicator());
        },
      ),
    );
  }
}
