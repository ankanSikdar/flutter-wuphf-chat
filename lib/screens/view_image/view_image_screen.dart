import 'package:flutter/material.dart';

class ViewImageScreenArgs {
  final String imageUrl;

  ViewImageScreenArgs({@required this.imageUrl});
}

class ViewImageScreen extends StatelessWidget {
  static const String routeName = '/view-picture-screen';

  static Route route({@required ViewImageScreenArgs args}) {
    return MaterialPageRoute(
      builder: (context) => ViewImageScreen(imageUrl: args.imageUrl),
    );
  }

  const ViewImageScreen({Key key, @required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(imageUrl),
      ),
    );
  }
}
