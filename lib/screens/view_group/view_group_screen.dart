import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/create_group/widgets/participants_widget.dart';
import 'package:wuphf_chat/screens/view_profile/widgets/profile_picture.dart';

class ViewGroupScreenArgs {
  final String groupId;
  ViewGroupScreenArgs({
    @required this.groupId,
  });
}

class ViewGroupScreen extends StatelessWidget {
  static const String routeName = '/view-group-screen';

  static Route route({@required ViewGroupScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<LiveGroupBloc>(
        create: (context) => LiveGroupBloc(
          groupId: args.groupId,
          groupsRepository: context.read<GroupsRepository>(),
        ),
        child: ViewGroupScreen(),
      ),
    );
  }

  const ViewGroupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LiveGroupBloc, LiveGroupState>(
        builder: (context, state) {
          if (state.status == LiveGroupStatus.loaded) {
            return CustomScrollView(
              slivers: [
                TwoTextAppBar(
                    title: state.group.groupName,
                    subtitle: 'Showing group details'),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfilePictureWidget(imageUrl: state.group.groupImage),
                        SizedBox(height: 32.0),
                        ParticipantsWidget(participants: state.group.usersList),
                      ],
                    ),
                  ),
                )
              ],
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
