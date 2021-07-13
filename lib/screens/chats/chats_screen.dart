import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/screens/chats/bloc/chats_bloc.dart';
import 'package:wuphf_chat/screens/chatting/chatting_screen.dart';
import 'package:wuphf_chat/helper/time_helper.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = "/chats-screen";

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChatsScreen(),
    );
  }

  const ChatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatsBloc, ChatsState>(listener: (context, state) {
      if (state.status == ChatsStatus.error) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text('${state.error}')),
          );
      }
    }, builder: (context, state) {
      if (state.status == ChatsStatus.loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.chatUsers.length > 0) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Chats',
                style: Theme.of(context).textTheme.headline3,
              ),
              automaticallyImplyLeading: false,
              toolbarHeight: 200,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthUserLogOut());
                    }),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final chatUser = state.chatUsers[index];
                    return UserRow(
                      title: chatUser.user.displayName,
                      subtitle: context.read<AuthBloc>().state.user.uid ==
                              chatUser.lastMessage.sentBy
                          ? 'You: ' + chatUser.lastMessage.text
                          : chatUser.lastMessage.text,
                      imageUrl: chatUser.user.profileImageUrl,
                      date: chatUser.lastMessage.sentAt.forLastMessage(),
                      onChat: () {
                        Navigator.of(context).pushNamed(
                          ChattingScreen.routeName,
                          arguments: ChattingScreenArgs(user: chatUser.user),
                        );
                      },
                    );
                  },
                  childCount: state.chatUsers.length,
                ),
              ),
            ),
          ],
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Chats'),
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthUserLogOut());
                  }),
            ],
          ),
        );
      }
    });
  }
}

// AppBar(
//         title: Text(context.read<AuthBloc>().state.user.email),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//               icon: Icon(Icons.logout),
//               onPressed: () {
//                 context.read<AuthBloc>().add(AuthUserLogOut());
//               })
//         ],
//       ),
