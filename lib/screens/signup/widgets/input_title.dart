import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  final String title;

  const InputTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6.apply(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
