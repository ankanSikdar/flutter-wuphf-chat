import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/repositories/groups/groups_repository.dart';
import 'package:wuphf_chat/screens/chatting/widgets/send_message_widget.dart';
import 'package:wuphf_chat/screens/chatting/widgets/widgets.dart';

import 'bloc/groupchatting_bloc.dart';

class GroupChattingScreenArgs {
  final String groupId;

  GroupChattingScreenArgs({
    @required this.groupId,
  });
}

class GroupChattingScreen extends StatelessWidget {
  static const String routeName = '/group-chatting-screen';

  static Route route({@required GroupChattingScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<GroupChattingBloc>(
        create: (context) => GroupChattingBloc(
          groupDbId: args.groupId,
          groupsRepository: context.read<GroupsRepository>(),
        ),
        child: GroupChattingScreen(groupId: args.groupId),
      ),
    );
  }

  final String groupId;

  const GroupChattingScreen({Key key, @required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.chattingScreenScaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            TwoTextAppBar(
              title: 'Group Name',
              subtitle: 'Participants...',
            ),
          ];
        },
        body: BlocConsumer<GroupChattingBloc, GroupChattingState>(
          listener: (context, state) {
            if (state.status == GroupChattingStatus.error) {
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
                      if (state.status == GroupChattingStatus.loaded) {
                        if (state.messagesList.length == 0) {
                          return Center(
                            child: Text('No Messages Yet...'),
                          );
                        }
                        return ListView.builder(
                          primary: false,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final message = state.messagesList[index];
                            return MessageWidget(
                              message: message,
                              // isAuthor: message.sentBy != user.id,
                              isAuthor: false,
                            );
                          },
                          itemCount: state.messagesList.length,
                        );
                      }
                      if (state.status == GroupChattingStatus.error) {
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
                    onSend: ({File imageFile, String message}) {
                      context.read<GroupChattingBloc>().add(
                            SendMessage(
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
