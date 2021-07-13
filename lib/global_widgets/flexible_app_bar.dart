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
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
