import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/group_chatting/group_chatting.dart';
import 'package:wuphf_chat/screens/groups/bloc/groups_bloc.dart';
import 'package:wuphf_chat/helper/time_helper.dart';
import 'package:wuphf_chat/screens/screens.dart';

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
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  String createLastMessage({@required Message message, @required bool addYou}) {
    String text = '';
    if (addYou) {
      text = 'You: ';
    }
    if (message.imageUrl != null && message.imageUrl.trim().isNotEmpty) {
      text = text + '📷 ' + message.text;
      return text;
    }
    return text + message.text;
  }

  void _search(String name) {
    context.read<GroupsBloc>().add(SearchGroups(name: name));
  }

  void _stopSearch() {
    context.read<GroupsBloc>().add(StopSearch());
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GroupsBloc, GroupsState>(
        builder: (context, state) {
          if (state.status == GroupsStatus.loaded ||
              state.status == GroupsStatus.searching) {
            List<Group> groups = state.status == GroupsStatus.searching
                ? state.searchList
                : state.groupsList;

            return CustomScrollView(
              slivers: [
                SearchSliverAppBar(
                  title: 'Groups',
                  textEditingController: _textEditingController,
                  suffixActive: state.status == GroupsStatus.searching,
                  search: _search,
                  stopSearch: _stopSearch,
                  searchTitle: 'groups',
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
                  sliver: state.groupsList.length == 0
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text('No Groups To Show'),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final group = groups[index];
                              final addYou =
                                  context.read<AuthBloc>().state.user.uid ==
                                      group.lastMessage.sentBy;
                              final text = createLastMessage(
                                  message: group.lastMessage, addYou: addYou);
                              return UserRow(
                                title: group.groupName,
                                subtitle: text,
                                imageUrl: group.groupImage,
                                date: group.lastMessage.sentAt.forLastMessage(),
                                onChat: () {
                                  Navigator.of(context).pushNamed(
                                    GroupChattingScreen.routeName,
                                    arguments: GroupChattingScreenArgs(
                                        groupId: group.groupId),
                                  );
                                },
                                onView: () {
                                  Navigator.of(context).pushNamed(
                                      ViewGroupScreen.routeName,
                                      arguments: ViewGroupScreenArgs(
                                          groupId: group.groupId));
                                },
                              );
                            },
                            childCount: groups.length,
                          ),
                        ),
                ),
              ],
            );
          }
          if (state.status == GroupsStatus.error) {
            return Center(
              child: Text('Something Went Wrong!'),
            );
          }
          return Center(
            child: LoadingIndicator(),
          );
        },
      ),
    );
  }
}
