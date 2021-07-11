import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

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
    final chatUsers = context.read<MessagesRepository>().getUserChatList();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<AuthBloc>().state.user.email),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(AuthUserLogOut());
              })
        ],
      ),
      body: StreamBuilder(
        stream: chatUsers,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data as List<Future<ChatUser>>;
            print(data.length);
            // data.first.then((chatUser) {
            //   Future.delayed(Duration(seconds: 15), () {
            //     context.read<MessagesRepository>().sendMessage(
            //         recipientId: chatUser.user.id,
            //         documentReference: chatUser.messagesDbRef,
            //         message: 'This is another check! Hopefully Final!');
            //   });
            // });
            return Center(
              child: Text('Data'),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
