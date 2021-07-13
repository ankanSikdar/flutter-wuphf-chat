import 'package:flutter/material.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/helper/time_helper.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isAuthor;

  const MessageWidget({
    Key key,
    @required this.message,
    @required this.isAuthor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marginSide = MediaQuery.of(context).size.width * 0.3;
    return Container(
      margin: isAuthor
          ? EdgeInsets.fromLTRB(marginSide, 0.0, 8.0, 16.0)
          : EdgeInsets.fromLTRB(8.0, 0.0, marginSide, 16.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.text),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(message.sentAt.forMessages()),
            ],
          ),
        ],
      ),
    );
  }
}
