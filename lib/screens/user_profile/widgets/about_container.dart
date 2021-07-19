import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class AboutContainer extends StatelessWidget {
  final String about;

  const AboutContainer({Key key, @required this.about}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(ThemeConfig.borderRadius)),
      child: Text(
        about.isEmpty ? 'No About' : about,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
