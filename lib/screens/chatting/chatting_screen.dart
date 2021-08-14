import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/chatting/bloc/chatting_bloc.dart';
import 'package:wuphf_chat/screens/chatting/widgets/send_message_widget.dart';
import 'package:wuphf_chat/screens/chatting/widgets/widgets.dart';

class ChattingScreenArgs {
  final String userId;
  final DocumentReference messagesDbRef;

  ChattingScreenArgs({
    @required this.userId,
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
          userId: args.userId,
          messagesRef: args.messagesDbRef,
        ),
        child: ChattingScreen(userId: args.userId),
      ),
    );
  }

  final String userId;

  const ChattingScreen({Key key, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.chattingScreenScaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            BlocProvider<LiveUserBloc>(
              create: (context) => LiveUserBloc(
                userRepository: context.read<UserRepository>(),
                userId: userId,
              ),
              child: ChattingAppBar(),
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
            return Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Builder(
                    builder: (context) {
                      if (state.hasMessagedBefore == false) {
                        return Center(
                          child: Container(
                            child: Text('No Chats To Show'),
                          ),
                        );
                      }
                      if (state.status == ChattingStatus.loaded) {
                        return ListView.builder(
                          physics: state.messagesList.length == 0
                              ? NeverScrollableScrollPhysics()
                              : BouncingScrollPhysics(),
                          primary: false,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final message = state.messagesList[index];
                            return MessageWidget(
                              message: message,
                              isAuthor: message.sentBy != userId,
                            );
                          },
                          itemCount: state.messagesList.length,
                        );
                      }
                      if (state.status == ChattingStatus.error) {
                        return Center(
                          child: Text('Something Went Wrong!'),
                        );
                      }
                      return Center(
                        child: LoadingIndicator(),
                      );
                    },
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: SendMessageWidget(
                    isSending: state.isSending,
                    onSend: ({String message, File imageFile}) {
                      context.read<ChattingBloc>().add(
                            ChattingSendMessage(
                              message: message,
                              image: imageFile,
                            ),
                          );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
