import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/chats/bloc/chats_bloc.dart';
import 'package:wuphf_chat/screens/chatting/chatting_screen.dart';
import 'package:wuphf_chat/helper/time_helper.dart';
import 'package:wuphf_chat/screens/screens.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "/chats-screen";

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChatsScreen(),
    );
  }

  const ChatsScreen({Key key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
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
    context.read<ChatsBloc>().add(SearchChats(name: name));
  }

  void _stopSearch() {
    context.read<ChatsBloc>().add(StopSearch());
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, state) {
          if (state.status == ChatsStatus.loaded ||
              state.status == ChatsStatus.searching) {
            List<ChatUser> chatList = state.status == ChatsStatus.searching
                ? state.searchList
                : state.chatUsers;
            return CustomScrollView(
              slivers: [
                SearchUserAppBar(
                  title: 'Chats',
                  textEditingController: _textEditingController,
                  suffixActive: state.status == ChatsStatus.searching,
                  search: _search,
                  stopSearch: _stopSearch,
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
                  sliver: state.chatUsers.length == 0
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text('No Chats To Show'),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final chatUser = chatList[index];
                              final addYou =
                                  context.read<AuthBloc>().state.user.uid ==
                                      chatUser.lastMessage.sentBy;
                              final text = createLastMessage(
                                  message: chatUser.lastMessage,
                                  addYou: addYou);
                              return UserRow(
                                isOnline: chatUser.user.presence,
                                title: chatUser.user.displayName,
                                subtitle: text,
                                imageUrl: chatUser.user.profileImageUrl,
                                date: chatUser.lastMessage.sentAt
                                    .forLastMessage(),
                                onChat: () {
                                  Navigator.of(context).pushNamed(
                                    ChattingScreen.routeName,
                                    arguments:
                                        ChattingScreenArgs(user: chatUser.user),
                                  );
                                },
                                onView: () {
                                  Navigator.of(context).pushNamed(
                                    ViewProfileScreen.routeName,
                                    arguments: ViewProfileScreenArgs(
                                        user: chatUser.user),
                                  );
                                },
                              );
                            },
                            childCount: chatList.length,
                          ),
                        ),
                ),
              ],
            );
          }
          if (state.status == ChatsStatus.error) {
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


// SliverPadding(
                // padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),