import 'package:flutter/material.dart';

class FlexibleAppBar extends StatelessWidget {
  final String title;

  const FlexibleAppBar({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      stretch: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 16.0),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
