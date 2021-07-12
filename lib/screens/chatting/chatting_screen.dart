import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/chatting/bloc/chatting_bloc.dart';

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
      builder: (context) => BlocProvider<ChattingBloc>(
        create: (context) => ChattingBloc(
          messagesRepository: context.read<MessagesRepository>(),
          user: args.user,
          messagesRef: args.messagesDbRef,
        ),
        child: ChattingScreen(user: args.user),
      ),
    );
  }

  final User user;

  const ChattingScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
      ),
      body: BlocConsumer<ChattingBloc, ChattingState>(
        listener: (context, state) {
          if (state.status == ChattingStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('${state.error}')),
              );
          }
        },
        builder: (context, state) {
          if (state.hasMessagedBefore == false) {
            return Center(
              child: Container(
                child: Text('No Chats To Show'),
              ),
            );
          }
          if (state.status == ChattingStatus.loaded) {
            return ListView.builder(
              itemCount: state.messagesList.length,
              itemBuilder: (context, index) {
                final message = state.messagesList[index];
                return Container(
                  height: 100,
                  margin: EdgeInsets.all(16.0),
                  color: Colors.amber,
                  child: Text(message.text),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomSheet: Row(
        children: [
          Expanded(child: TextField()),
          IconButton(
              icon: Icon(Icons.send_rounded),
              onPressed: () {
                context
                    .read<ChattingBloc>()
                    .add(ChattingSendMessage(message: 'Hi Josh!'));
              })
        ],
      ),
    );
  }
}
