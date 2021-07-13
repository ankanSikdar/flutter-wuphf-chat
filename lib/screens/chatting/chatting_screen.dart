import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/config/configs.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/chatting/bloc/chatting_bloc.dart';
import 'package:wuphf_chat/screens/chatting/widgets/send_message_widget.dart';
import 'package:wuphf_chat/screens/chatting/widgets/widgets.dart';

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
      backgroundColor: ThemeConfig.chattingScreenScaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            ChattingAppBar(
              user: user,
            )
          ];
        },
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
              return Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: ListView.builder(
                  primary: false,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final message = state.messagesList[index];
                    return MessageWidget(
                      message: message,
                      isAuthor: message.sentBy != user.id,
                    );
                  },
                  itemCount: state.messagesList.length,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomSheet: SendMessageWidget(),
    );
  }
}
