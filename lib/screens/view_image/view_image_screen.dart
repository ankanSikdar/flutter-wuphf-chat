import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

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
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          TwoTextAppBar(title: 'View Image', subtitle: 'Pinch to zoom'),
          SliverFillRemaining(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 3,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => Container(color: Colors.grey),
                errorWidget: (context, url, error) =>
                    Container(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
