import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/chats/bloc/chats_bloc.dart';
import 'package:wuphf_chat/screens/chatting/chatting_screen.dart';
import 'package:wuphf_chat/helper/time_helper.dart';
import 'package:wuphf_chat/screens/screens.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = "/chats-screen";

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChatsScreen(),
    );
  }

  const ChatsScreen({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        FlexibleAppBar(title: 'Chats'),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
          sliver: BlocConsumer<ChatsBloc, ChatsState>(
            listener: (context, state) {
              if (state.status == ChatsStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${state.error}')),
                  );
              }
            },
            builder: (context, state) {
              if (state.chatUsers.length > 0) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final chatUser = state.chatUsers[index];
                      final addYou = context.read<AuthBloc>().state.user.uid ==
                          chatUser.lastMessage.sentBy;
                      final text = createLastMessage(
                          message: chatUser.lastMessage, addYou: addYou);
                      return UserRow(
                        title: chatUser.user.displayName,
                        subtitle: text,
                        imageUrl: chatUser.user.profileImageUrl,
                        date: chatUser.lastMessage.sentAt.forLastMessage(),
                        onChat: () {
                          Navigator.of(context).pushNamed(
                            ChattingScreen.routeName,
                            arguments: ChattingScreenArgs(user: chatUser.user),
                          );
                        },
                        onView: () {
                          Navigator.of(context).pushNamed(
                            ViewProfileScreen.routeName,
                            arguments:
                                ViewProfileScreenArgs(user: chatUser.user),
                          );
                        },
                      );
                    },
                    childCount: state.chatUsers.length,
                  ),
                );
              } else if (state.status == ChatsStatus.loaded &&
                  state.chatUsers.length == 0) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text('No Chats'),
                    ),
                  ),
                );
              }
              if (state.status == ChatsStatus.error) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Text('Something Went Wrong!'),
                      ),
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
