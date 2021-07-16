import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';

import 'package:wuphf_chat/screens/view_profile/widgets/detials_widget.dart';
import 'package:wuphf_chat/screens/view_profile/widgets/profile_picture.dart';

class ViewProfileScreenArgs {
  final User user;
  ViewProfileScreenArgs({
    @required this.user,
  });
}

class ViewProfileScreen extends StatelessWidget {
  static const String routeName = '/view-profile-screen';

  static Route route({@required ViewProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ViewProfileScreen(user: args.user),
    );
  }

  const ViewProfileScreen({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TwoTextAppBar(title: 'Details', subtitle: 'Showing all details'),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePictureWidget(imageUrl: user.profileImageUrl),
                  SizedBox(height: 32.0),
                  DetialsWidget(title: 'Name', content: user.displayName),
                  DetialsWidget(title: 'Email', content: user.email),
                  DetialsWidget(
                    title: 'About',
                    content: user.bio.isEmpty ? 'No About' : user.bio,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
