import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';

class ParticipantsWidget extends StatelessWidget {
  final List<User> participants;
  const ParticipantsWidget({Key key, @required this.participants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<UserRow> userRows = participants
        .map((user) => UserRow(
              imageUrl: user.profileImageUrl,
              title: user.displayName,
              subtitle: user.bio,
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