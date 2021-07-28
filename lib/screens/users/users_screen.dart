import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/chatting/chatting_screen.dart';
import 'package:wuphf_chat/screens/screens.dart';
import 'package:wuphf_chat/screens/users/bloc/users_bloc.dart';
import 'package:wuphf_chat/screens/users/widgets/selecting_fab.dart';

class UsersScreen extends StatefulWidget {
  static const String routeName = '/users-screen';

  // Dont need this since the UsersScreen is created through NavScreen
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: RouteSettings(name: routeName),
  //     builder: (context) => UsersScreen(),
  //   );
  // }

  const UsersScreen({Key key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  void _search(String name) {
    context.read<UsersBloc>().add(
          UsersUpdateSearchList(name: name),
        );
  }

  void _stopSearch() {
    context.read<UsersBloc>().add(UsersStopSearching());
    _textEditingController.clear();
  }

  void _selectUser(User user) {
    context.read<UsersBloc>().add(
          UsersUpdateSelectedList(user: user),
        );
  }

  void _stopSelecting() {
    context.read<UsersBloc>().add(UsersStopSelecting());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        print('Status: ${state.status}');
        if (state.status == UsersStateStatus.error) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state.status == UsersStateStatus.loaded ||
            state.status == UsersStateStatus.searching ||
            state.status == UsersStateStatus.selecting) {
          final isSelecting = state.status == UsersStateStatus.selecting;
          final List<User> usersList =
              state.searchList.isNotEmpty ? state.searchList : state.usersList;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SearchSliverAppBar(
                  title: isSelecting ? 'Create Group' : 'Users',
                  textEditingController: _textEditingController,
                  suffixActive: state.searchList.isNotEmpty,
                  search: _search,
                  stopSearch: _stopSearch,
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                      16.0, 8.0, 8.0, isSelecting ? 84.0 : 0.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final user = usersList[index];
                        final isSelected = state.selectedList.contains(user);
                        return UserRow(
                          isChecked: isSelected,
                          title: user.displayName,
                          subtitle: user.bio.isEmpty ? user.email : user.bio,
                          imageUrl: user.profileImageUrl,
                          isOnline: user.presence,
                          onChat: isSelecting
                              ? () => _selectUser(user)
                              : () {
                                  Navigator.of(context).pushNamed(
                                    ChattingScreen.routeName,
                                    arguments: ChattingScreenArgs(user: user),
                                  );
                                },
                          onLongPress: () {
                            _selectUser(user);
                          },
                          onView: isSelecting
                              ? () => _selectUser(user)
                              : () {
                                  Navigator.of(context).pushNamed(
                                    ViewProfileScreen.routeName,
                                    arguments:
                                        ViewProfileScreenArgs(user: user),
                                  );
                                },
                        );
                      },
                      childCount: usersList.length,
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isSelecting
                ? SelectingFAB(
                    onCreate: () {},
                    onCancel: () {
                      _stopSelecting();
                    },
                  )
                : null,
          );
        }
        return Center(child: LoadingIndicator());
      },
    );
  }
}
