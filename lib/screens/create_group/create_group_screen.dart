import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/create_group/widgets/group_name_widget.dart';
import 'package:wuphf_chat/screens/create_group/widgets/participants_widget.dart';
import 'package:wuphf_chat/screens/edit_profile/widgets/widgets.dart';

import 'cubit/creategroup_cubit.dart';

class CreateGroupScreenArgs {
  final List<User> participants;

  CreateGroupScreenArgs({@required this.participants});
}

class CreateGroupScreen extends StatefulWidget {
  static const String routeName = '/create-group-screen';

  static Route route({@required CreateGroupScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (context) => CreateGroupCubit(
          groupsRepository: context.read<GroupsRepository>(),
          storageRepository: context.read<StorageRepository>(),
          participants: args.participants,
        ),
        child: CreateGroupScreen(),
      ),
    );
  }

  const CreateGroupScreen({Key key}) : super(key: key);

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TwoTextAppBar(title: 'Create Group', subtitle: 'Edit Group Details'),
          BlocConsumer<CreateGroupCubit, CreateGroupState>(
            listener: (context, state) {
              if (state.status == CreateGroupStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${state.error}')),
                  );
                context.read<CreateGroupCubit>().reset();
              }
              if (state.status == CreateGroupStatus.submitting) {
                _formKey.currentState.deactivate();
              }
              if (state.status == CreateGroupStatus.success) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('Group Created!')),
                  );
              }
            },
            builder: (context, state) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ChangeProfilePicture(
                          imageUrl:
                              'https://figeit.com/images/chat/mck-icon-group.png',
                          onChanged: context
                              .read<CreateGroupCubit>()
                              .groupImageChanged,
                        ),
                        SizedBox(height: 16.0),
                        GroupNameWidget(
                          onChanged:
                              context.read<CreateGroupCubit>().groupNameChanged,
                        ),
                        SizedBox(height: 16.0),
                        InkWellButton(
                          onTap: () {
                            print('Check: ${_formKey.currentState.validate()}');
                          },
                          buttonColor: Theme.of(context).primaryColor,
                          title: 'Create Group',
                          titleColor: Colors.white,
                        ),
                        SizedBox(height: 16.0),
                        ParticipantsWidget(participants: state.participants),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
