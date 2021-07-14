import 'package:flutter/material.dart';

class AboutContainer extends StatelessWidget {
  const AboutContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15.0)),
      child: Text(
          '25 y.o Engineering Student from Petrozasdavosk Qui placeat voluptatem ea iste corporis eius voluptate accusamus. Alias ex temporibus nihil. Et dolores est excepturi assumenda sequi dolorem. '),
    );
  }
}
