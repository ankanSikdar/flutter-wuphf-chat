import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/screens.dart';

class ParticipantsWidget extends StatelessWidget {
  final List<User> participants;
  final bool showPresence;
  const ParticipantsWidget(
      {Key key, @required this.participants, this.showPresence = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<UserRow> userRows = participants
        .map((user) => UserRow(
              imageUrl: user.profileImageUrl,
              title: user.displayName,
              subtitle: user.bio,
              isOnline: showPresence ? user.presence : null,
              onChat: () {
                Navigator.of(context).pushNamed(
                                    ChattingScreen.routeName,
                                    arguments:
                                        ChattingScreenArgs(userId: user.id),
                                  );
              },
              onView: () {
                Navigator.of(context).pushNamed(
                                    ViewProfileScreen.routeName,
                                    arguments:
                                        ViewProfileScreenArgs(user: user),
                                  );
              },
            ))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'Participants'),
        ...userRows,
      ],
    );
  }
}
