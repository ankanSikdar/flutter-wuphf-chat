import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/create_group/widgets/group_name_widget.dart';
import 'package:wuphf_chat/screens/edit_profile/widgets/widgets.dart';

import 'cubit/editgroup_cubit.dart';

class EditGroupArgs {
  final Group group;

  EditGroupArgs({@required this.group});
}

class EditGroupScreen extends StatefulWidget {
  static const String routeName = '/edit-group-screen';

  static Route route({@required EditGroupArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditGroupCubit>(
        create: (context) => EditGroupCubit(
          group: args.group,
          groupsRepository: context.read<GroupsRepository>(),
          storageRepository: context.read<StorageRepository>(),
        ),
        child: EditGroupScreen(),
      ),
    );
  }

  const EditGroupScreen({
    Key key,
  }) : super(key: key);

  @override
  _EditGroupScreenState createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  void _updateGroup() {
    if (context.read<EditGroupCubit>().state.status ==
        EditGroupStatus.submitting) {
      return;
    }
    if (!_formKey.currentState.validate()) {
      return;
    }
    context.read<EditGroupCubit>().submitForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TwoTextAppBar(
            title: 'Edit Group',
            subtitle: 'Modify group details here',
          ),
          BlocConsumer<EditGroupCubit, EditGroupState>(
            listener: (context, state) {
              if (state.status == EditGroupStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${state.error}')),
                  );
                context.read<EditGroupCubit>().reset();
              }
              if (state.status == EditGroupStatus.success) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('Group Details Updated')),
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
                      children: [
                        ChangeProfilePicture(
                          imageUrl: state.groupImageUrl,
                          onChanged: (File file) {
                            context
                                .read<EditGroupCubit>()
                                .groupImageChanged(file);
                          },
                        ),
                        SizedBox(height: 16.0),
                        GroupNameWidget(
                          initialValue: state.groupName,
                          onChanged:
                              context.read<EditGroupCubit>().groupNameChanged,
                        ),
                        SizedBox(height: 16.0),
                        CustomElevatedButton(
                          onTap: state.status == EditGroupStatus.submitting
                              ? null
                              : () {
                                  _updateGroup();
                                },
                          titleColor: Theme.of(context).primaryColor,
                          icon: FontAwesomeIcons.save,
                          title: state.status == EditGroupStatus.submitting
                              ? 'Submitting...'
                              : 'Submit',
                          buttonColor: Colors.white,
                          size: Size(
                              MediaQuery.of(context).size.width * 0.6, 50.0),
                        )
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
