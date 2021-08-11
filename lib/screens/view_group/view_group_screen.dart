import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/create_group/widgets/participants_widget.dart';
import 'package:wuphf_chat/screens/view_profile/widgets/profile_picture.dart';
import 'package:wuphf_chat/helper/time_helper.dart';

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
            final createdByUser = state.group.usersList
                .firstWhere((element) => element.id == state.group.createdBy);
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
                        if (createdByUser.id ==
                            context.read<AuthBloc>().state.user.uid)
                          Column(
                            children: [
                              InkWellButton(
                                onTap: () {},
                                buttonColor: Theme.of(context).primaryColor,
                                title: 'Edit Group Details',
                                titleColor: Colors.white,
                              ),
                              SizedBox(height: 16.0),
                            ],
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTitle(title: 'Created By'),
                            UserRow(
                              imageUrl: createdByUser.profileImageUrl,
                              title: createdByUser.displayName,
                              subtitle: createdByUser.bio,
                              isOnline: createdByUser.presence,
                            ),
                            SizedBox(height: 12.0),
                            InputTitle(title: 'Created On'),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: Text(
                                state.group.createdAt.forCreatedAt(),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        ParticipantsWidget(
                          participants: state.group.usersList,
                          showPresence: true,
                        ),
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
