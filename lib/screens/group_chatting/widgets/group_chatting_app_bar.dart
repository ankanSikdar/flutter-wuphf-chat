import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/auth/auth_bloc.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';

import 'bloc/livegroup_bloc.dart';

class GroupChattingAppBar extends StatelessWidget {
  const GroupChattingAppBar({Key key}) : super(key: key);

  String buildUserNamesList({BuildContext context, List<User> participants}) {
    final userId = context.read<AuthBloc>().state.user.uid;
    List<User> removedUserParticipants = [...participants];
    removedUserParticipants.removeWhere((element) => element.id == userId);
    final namesList =
        removedUserParticipants.map((user) => user.displayName).toList();
    final names = StringBuffer();
    names.writeAll(namesList, ', ');
    return names.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveGroupBloc, LiveGroupState>(
      builder: (context, state) {
        final hasLoaded = state.status == LiveGroupStatus.loaded;
        final group = state.group;
        return SliverAppBar(
          elevation: 2.0,
          shadowColor: Colors.grey[500],
          backgroundColor: Colors.white,
          toolbarHeight: 100,
          floating: true,
          pinned: true,
          forceElevated: true,
          automaticallyImplyLeading: false,
          leadingWidth: 35.0,
          titleSpacing: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(ThemeConfig.borderRadius),
            ),
          ),
          title: InkWell(
            onTap: hasLoaded
                ? () {
                    // Navigator.of(context).pushNamed(
                    //   ViewProfileScreen.routeName,
                    //   arguments: ViewProfileScreenArgs(user: user),
                    // );
                  }
                : null,
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 8.0),
                  ProfilePicture(imageUrl: hasLoaded ? group.groupImage : ''),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasLoaded ? group.groupName : 'Loading...',
                          style: Theme.of(context).textTheme.headline5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.0),
                        hasLoaded
                            ? Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  buildUserNamesList(
                                      context: context,
                                      participants: state.group.usersList),
                                  style: Theme.of(context).textTheme.subtitle1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.navigate_before,
            ),
          ),
        );
      },
    );
  }
}
