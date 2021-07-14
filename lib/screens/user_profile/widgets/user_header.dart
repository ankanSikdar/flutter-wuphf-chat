import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final String title;

  const UserHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
