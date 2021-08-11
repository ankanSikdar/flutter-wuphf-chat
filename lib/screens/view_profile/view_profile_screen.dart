import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

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
      builder: (context) => BlocProvider<LiveUserBloc>(
        create: (context) => LiveUserBloc(
          userId: args.user.id,
          userRepository: context.read<UserRepository>(),
        ),
        child: ViewProfileScreen(),
      ),
    );
  }

  const ViewProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LiveUserBloc, LiveUserState>(
        builder: (context, state) {
          if (state.status == LiveUserStatus.loaded) {
            final user = state.user;
            return CustomScrollView(
              slivers: [
                TwoTextAppBar(
                    title: 'Details',
                    subtitle: user.presence ? '🟢 Online' : '⚫ Offline'),
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
            );
          }
          if (state.status == LiveUserStatus.error) {
            return Center(
              child: Text(state.error),
            );
          }
          return Center(
            child: LoadingIndicator(),
          );
        },
      ),
    );
  }
}
