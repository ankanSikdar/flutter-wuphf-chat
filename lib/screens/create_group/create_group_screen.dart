import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/create_group/widgets/group_name_widget.dart';
import 'package:wuphf_chat/screens/edit_profile/widgets/widgets.dart';

class CreateGroupScreenArgs {
  final List<User> participants;

  CreateGroupScreenArgs({@required this.participants});
}

class CreateGroupScreen extends StatefulWidget {
  static const String routeName = '/create-group-screen';

  static Route route({@required CreateGroupScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CreateGroupScreen(participants: args.participants),
    );
  }

  final List<User> participants;

  const CreateGroupScreen({Key key, @required this.participants})
      : super(key: key);

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TwoTextAppBar(title: 'Create Group', subtitle: 'Edit Group Details'),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    ChangeProfilePicture(
                      imageUrl:
                          'https://figeit.com/images/chat/mck-icon-group.png',
                      onChanged: (File file) {},
                    ),
                    SizedBox(height: 16.0),
                    GroupNameWidget(onChanged: (value) {}),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: InkWellButton(
                onTap: () {},
                buttonColor: Theme.of(context).primaryColor,
                title: 'Create Group',
                titleColor: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: InputTitle(title: 'Participants'),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final user = widget.participants[index];
                return UserRow(
                  imageUrl: user.profileImageUrl,
                  title: user.displayName,
                  subtitle: user.bio,
                );
              }, childCount: widget.participants.length),
            ),
          ),
        ],
      ),
    );
  }
}
