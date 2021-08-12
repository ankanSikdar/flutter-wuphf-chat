import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

class DetailsWidget extends StatelessWidget {
  final String title;
  final String content;

  const DetailsWidget({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: 70.0, child: InputTitle(title: title)),
        SizedBox(width: 12.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(ThemeConfig.borderRadius)),
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ],
    );
  }
}
